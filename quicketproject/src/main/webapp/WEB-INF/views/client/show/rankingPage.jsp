<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<style type="text/css">
.topRankBox_wrapper{
	padding:10px;
}
.topRankBox{
	padding:20px;
	border: 1px solid #ccc
}
.rankBox_thumbnail{
	display:inline-block;
}
.rankBox_img{
	width:100%;
}
.rank_label{
	position:absolute;
	top:10px;
	left:10px;
	width:50px;
	height:40px;
	background-color:#f3f2e9;
	border:2px solid #ccc;
}
.rank_label_part1{
	position:absolute;
	width:0px;
	height:0px;
	top:100%;
	left:0%;
	border-top: 46px solid #ccc;
	border-left: 50px solid transparent;
	transform:translate(-2px, 2px);
}
.rank_label_part2{
	position:absolute;
	width:0px;
	height:0px;
	top:100%;
	left:0%;
	border-top: 46px solid #ccc;
	border-right: 50px solid transparent;
	transform:translate(-2px, 2px);
}
.rank_label_part3{
	position:absolute;
	width:0px;
	height:0px;
	top:100%;
	left:0%;
	border-top: 44px solid #f3f2e9;
	border-left: 46px solid transparent;
}
.rank_label_part4{
	position:absolute;
	width:0px;
	height:0px;
	top:100%;
	left:0%;
	border-top: 44px solid #f3f2e9;
	border-right: 46px solid transparent;
}
.rank_label_text{
	text-align:center;
    height:50px;
    justify-content:center;
    align-items:center;
    display:flex;
    z-index:1;
    position:relative;
}
.rank_label_rank {
	font-weight: bold;
    font-size: 22px;
    top: 5px;
    position: absolute;
}
.rank_label_change {
	text-align:center;
    position: absolute;
    top: 33px;
}
.otherRankBox{
	display:flex;
	align-items:center;
	margin:10px 0px;
	padding:15px;
	text-align:center;
	border:1px solid #ccc;
}
.otherRankBox_ranking{
	display:flex;
	flex-flow:column;
}
.otherRankBox_rank{
	font-weight: bold;
    font-size: 25px;
}
.otherRankBox_text{
	display:inline-block;
	text-align:left;
}
#start_date, #end_date{
	display:none;
}
#datelabel{
	font-size:20px;
}

.rankup_icon{
	display:inline-block;
	width:0px;
	height:0px;
	border-left: 6px solid transparent;
	border-right: 6px solid transparent;
	border-bottom: 9px solid red;
}
.rankdown_icon{
	display:inline-block;
	width:0px;
	height:0px;
	border-left: 6px solid transparent;
	border-right: 6px solid transparent;
	border-top: 9px solid blue;
}

</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js" integrity="sha512-T/tUfKSV1bihCnd+MxKD0Hm1uBBroVYBOYSk1knyvQ9VyZJpc/ALb4P0r6ubwVPSGB2GvjeoMAJJImBG12TiaQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" integrity="sha512-mSYUmp1HYZDFaVKK//63EcZq4iFWFjxSL+Z3T/aCt4IO9Cejm03q3NKKYN6pFQzY0SBOr8h+eCIAZHPXcpZaNw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js" integrity="sha512-L4qpL1ZotXZLLe8Oo0ZyHrj/SweV7CieswUODAAPN/tnqN3PA1P+4qPu5vIryNor6HQ5o22NujIcAZIfyVXwbQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript" src="/resources/include/js/showBox.js"></script>
<script type="text/javascript">
	$(function(){
			
		let s_array = "<c:out value='${param.s_array}' />"
		
		//조건변수 없이 접근했을 경우 강제 리다이렉트
		if(s_array==''){
			location.href=location.pathname+'?s_array=s_point'
		}else{
			if(s_array=='s_point'){
				//화면 시작시에 필요없는 컴포넌트 숨김 처리	
				$('#dateSelect').hide();
				$('#periodNav').hide();
			}
			$("#s_array").val(s_array);
		}
		$("#s_array").change(function(){
			$("#f_ranking").submit();
		})
		
		let s_genre = "<c:out value='${param.s_genre}' />"
		if(s_genre==''){
			$($(".genreBtn")[0]).addClass('active');
		}else if(s_genre=='뮤지컬'){
			$("#s_genre").val(s_genre);
			$($(".genreBtn")[1]).addClass('active');
		}else if(s_genre=='연극'){
			$("#s_genre").val(s_genre);
			$($(".genreBtn")[2]).addClass('active');
		}
		$(".genreBtn").each(function(){
			$(this).click(function(){
				let genre_value = $(this).val();
				$("#s_genre").val(genre_value);
				rankingSubmit();
			})
		})
		
		$('.topRankBox_point').each(function(){
			let point = $(this).data('point');
			makeStar(this, point);
		})
		$('.otherRankBox_pointBox').each(function(){
			let point = $(this).data('point');
			makeStar(this, point);
		})
		
		function rankingSubmit(){
			$("#f_ranking").attr({
				"method":"get",
				"action":location.pathname
			})
			$("#f_ranking").submit();
		}
	}) 
</script>
</head>
<body>
	<div class="container">
	<br/>
	<form id="f_ranking">
		<div class="row">
			<div class="col-xs-4 col-xs-offset-4">
			<div class="btn-group btn-group-justified">
				<input type="hidden" id="s_genre" name="s_genre" />
				<div class="btn-group btn-group-lg" role="group">
					<button type="button" class="genreBtn btn btn-default" value="">전체</button>
				</div>
				<div class="btn-group btn-group-lg" role="group">
					<button type="button" class="genreBtn btn btn-default" value="뮤지컬">뮤지컬</button>
				</div>
				<div class="btn-group btn-group-lg" role="group">
					<button type="button" class="genreBtn btn btn-default" value="연극">연극</button>
				</div>
			</div>
			</div>
		</div>
		<br/><br/>
		<div class="row">
			<div class="form-group">
				<div class="col-sm-2">
					<select id="s_array" name="s_array" class="form-control">
						<option value="rank_ticket">예매율순</option>
						<option value="s_point">평점순</option>	
					</select>						
				</div>	
				<div id="dateSelect" class="col-sm-4 col-sm-offset-2 text-center">
					<label for="start_date" id="datelabel">▼ 날짜 입력하기</label>
					<input type="date" id="start_date" name="start_date" />
					<input type="date" id="end_date" name="end_date" />
				</div>				
				<div id="periodNav" class="col-sm-3 col-sm-offset-1">
					<input type="hidden" id="rank_period" name="rank_period" />
					<ul class="nav nav-pills">
						<li role="presentation"><a role="button" data-period="day">일간</a></li>
						<li role="presentation"><a role="button" data-period="week">주간</a></li>
						<li role="presentation"><a role="button" data-period="month">월간</a></li>
						<li role="presentation"><a role="button" data-period="year">연간</a></li>
					</ul>
				</div>
			</div>
		</div>
	</form>
		<br/><br/><br/>
		<div id="top3list" class="row">
			<c:forEach var="rank" items="${rankList}" end="2" step="1" varStatus="status">
			<div class="topRankBox_wrapper col-xs-4">
				<div class="topRankBox text-center" data-num="${rank.s_num}">
					<div class="rank_label">
						<div class="rank_label_text">
						<c:if test="${empty param.s_array or param.s_array=='s_point'}">
							<span class="rank_label_rank">${rank.s_point_rank}</span>
						</c:if>
						<c:if test="${param.s_array=='rank_ticket'}">
							<span class="rank_label_rank">${rank.rank_rank}</span>
							<span class="rank_label_change">
								<c:choose>
									<c:when test="${fn:startsWith(rank.rank_change, '-')}">
										<span class="rankdown_icon"></span>
										${fn:substringAfter(rank.rank_change,'-')}
									</c:when>
									<c:when test="${rank.rank_change=='new'}">
										${rank.rank_change}
									</c:when>
									<c:when test="${rank.rank_change=='0'}">
										(-)
									</c:when>
									<c:otherwise>
										<span class="rankup_icon"></span>
										<span>${rank.rank_change}</span>
									</c:otherwise>
								</c:choose>
							</span>
						</c:if>
						</div>
						<div class="rank_label_part1"></div>
						<div class="rank_label_part2"></div>
						<div class="rank_label_part3"></div>
						<div class="rank_label_part4"></div>
					</div>
					<div class="rankBox_thumbnail">
						<a href="/showDetail?s_num=${rank.s_num}">
							<img src=
							<c:if test="${rank.s_posterimg ne null}">
								"/uploadStorage/${rank.s_posterimg.img_dir}/${rank.s_posterimg.img_name}.${rank.s_posterimg.img_type}"
							</c:if>
							<c:if test="${rank.s_posterimg eq null}">
								"/uploadStorage/show/poster_default.jpg"
							</c:if>
							 class="rankBox_img" />
						</a>
					</div>
					<div class="topRankBox_text">
						<h4 class="topRankBox_title">${rank.s_name}</h4>
						<p class="topRankBox_date">${rank.s_opendate} ~ ${rank.s_closedate}</p>
						<p class="topRankBox_theater">${rank.th_name}</p>
						<br/>
						<div class="topRankBox_ticket">${rank.rank_ticket}%</div>
						<div class="topRankBox_point" data-point="${rank.s_point}">${rank.s_point}</div>
					</div>
				</div>
			</div>	
			</c:forEach>
		</div>
		<br />
		<br />
		<br />		
		<div id="otherlist" class="row">
			<c:forEach var="rank" items="${rankList}" begin="3" step="1" varStatus="status">
				<div class="otherRankBox col-xs-12" data-num="${rank.s_num}">
					<div class="otherRankBox_ranking text-center col-xs-2">
						<c:if test="${empty param.s_array or param.s_array=='s_point'}">
							<div class="row"><span class="otherRankBox_rank">${rank.s_point_rank}</span></div>
						</c:if>
						<c:if test="${param.s_array=='rank_ticket'}">
							<span span class="otherRankBox_rank">${rank.rank_rank}</span>
							<span span class="otherRankBox_change">
								<c:choose>
									<c:when test="${fn:startsWith(rank.rank_change, '-')}">
										<span class="rankdown_icon"></span>
										${fn:substringAfter(rank.rank_change,'-')}
									</c:when>
									<c:when test="${rank.rank_change=='new'}">
										${rank.rank_change}
									</c:when>
									<c:when test="${rank.rank_change=='0'}">
										(-)
									</c:when>
									<c:otherwise>
										<span class="rankup_icon"></span>
										${rank.rank_change}
									</c:otherwise>
								</c:choose>
							</span>
						</c:if>
					</div>			
					<div class="rankBox_thumbnail col-xs-2">
						<a href="/showDetail?s_num=${rank.s_num}">
							<img src=
							<c:if test="${rank.s_posterimg ne null}">
								"/uploadStorage/${rank.s_posterimg.img_dir}/${rank.s_posterimg.img_name}.${rank.s_posterimg.img_type}"
							</c:if>
							<c:if test="${rank.s_posterimg eq null}">
								"/uploadStorage/show/poster_default.jpg"
							</c:if>
							 class="rankBox_img" />
						</a>
					</div>
					<div class="otherRankBox_text col-xs-4 col-xs-offset-1">
						<h4 class="otherRankBox_title"><strong>${rank.s_name}</strong></h4>
						<br/>
						<p class="otherRankBox_theater"><strong>장소 : </strong>${rank.th_name}</p>
						<p class="otherRankBox_date"><strong>기간 : </strong>${rank.s_opendate} ~ ${show.s_closedate}</p>
					</div>
					<div class="otherRankBox_ticket_point col-xs-2">
						<div class="row"><span class="otherRankBox_ticket">${rank.rank_ticket}%</span></div>
						<div class="row otherRankBox_pointBox" data-point="${rank.s_point}">${rank.s_point}</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

</body>
</html>