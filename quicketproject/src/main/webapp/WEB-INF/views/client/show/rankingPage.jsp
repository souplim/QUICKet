<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style type="text/css">
.btn-group-lg>.btn-default{
	background-image:none;
	background-color:transparent;
	border:none;
}
.btn-group-lg>.btn-default.active{
	background-color: #e0e0e0;
    border-color: #dbdbdb;
}
.nav-pills>li>a{
	text-shadow: 0 1px 0 #fff;
	color:black;
	box-shadow: 0 1px 1px rgba(0,0,0,.125);
}
.nav-pills>li:first-child>a{
	border-top-right-radius:0px;
	border-bottom-right-radius:0px;
}
.nav-pills>li:last-child>a{
	border-top-left-radius:0px;
	border-bottom-left-radius:0px;
}
.nav-pills>li:not(:first-child):not(:last-child)>a{border-radius:0px;}
.nav-pills>li+li{margin:0px;}
.nav-pills>li.active>a{
	background-color:#ddd;
	box-shadow: inset 0 3px 5px rgba(0,0,0,.125);
}
.nav-pills>li.active>a:hover{background-color:#999;}
.nav-pills>li.active>a:focus{background-color:#777;}

.topRankBox_wrapper{
	padding:10px;
}
.topRankBox{
	padding:25px;
	box-shadow:10px 10px 20px 3px rgb(123,123,123,0.5);
}
.topRankBox_title{
	font-size:24px;
	font-weight:bold;
}
.rankBox_thumbnail{
	display:inline-block;
}
.topRankBox .rankBox_img{
	width:100%;
	max-width:300px;
	max-height:400px;
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
	box-shadow:10px 10px 20px 3px rgb(123,123,123,0.5);
}
.otherRankBox .rankBox_img{
	width:100%;
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
.otherRankBox_title{
	font-size:24px;
	font-weight:bold;
}
#start_date, #end_date{
	display:none;
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
.ui-datepicker-trigger{
	border:none;
	background-color:transparent;
	font-size:20px;
}
</style>
<c:if test="${showVO.rank_period=='month' or showVO.rank_period=='year'}">
<style type="text/css">
.ui-datepicker-calendar{display:none;}
.ui-datepicker-current{display:none;}
#ui-datepicker-div{height:auto;}
.ui-datepicker-year{text-align:center;border:none; appearance:none;}
.ui-datepicker-month{text-align:center;border:none; appearance:none;}
</style>
</c:if>
<c:if test="${showVO.rank_period=='year'}">
<style type="text/css">.ui-datepicker-month{display:none;}</style>
</c:if>
<link rel="stylesheet" href="/resources/include/css/jquery-ui-custom.css" />
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="/resources/include/js/showBox.js"></script>
<script type="text/javascript">
	$(function(){
		let s_array = "<c:out value='${showVO.s_array}' />"
		//화면 시작시에 필요없는 컴포넌트 숨김 처리
		if(s_array=='s_point'){
			$('#dateSelect').hide();
			$('#periodNav').hide();
		}
		
		//점수 기준 input에 입력 처리
		$("#s_array").val(s_array);
		$("#s_array").change(function(){
			
			//기준이 바뀌면 날짜 설정이 초기화되어야 한다
			$("#start_date").val('');
			$("#end_date").val('');
			
			rankingSubmit();
		})
		
		//장르 input에 입력하고 해당 버튼 활성화
		let s_genre = "<c:out value='${showVO.s_genre}' />"
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
		
		//기간 기준 input에 입력하고 해당하는 버튼 활성화
		let rank_period = "<c:out value='${showVO.rank_period}' />"
		$("#rank_period").val(rank_period);
		$(".periodBtn[data-period='"+rank_period+"']").parents("li[role='presentation']").addClass("active");
		$(".periodBtn").each(function(){
			$(this).click(function(){
				let period_value = $(this).data('period');
				$("#rank_period").val(period_value);
				
				//기준이 바뀌면 날짜 설정이 초기화되어야 한다
				$("#start_date").val('');
				$("#end_date").val('');
				
				rankingSubmit();
			})
		})


		if(s_array='rank_ticket'){
			
			//버튼에 표시할 검색 날짜를 저장하는 구문
			let start_date="<c:out value='${showVO.start_date}' />";
			let end_date="<c:out value='${showVO.end_date}' />";
			$("#start_date").val(start_date);
			$("#end_date").val(end_date);
			
			//선택기준이 날짜 또는 주간인 경우
			if(rank_period=='day' || rank_period=='week'){
				let maxdate_gap = 0;
				let d = new Date();
				if(rank_period=="week"){
					maxdate_gap = -d.getDay();
				}
				let start_date_pick = new Date($("#start_date").val());
				let end_date_pick = new Date($("#end_date").val());
				$("#start_date").datepicker({
					showOn:"button",
					buttonText:()=>{
						if(start_date==end_date || end_date==""){
							return "▼ "+start_date;
						}else{
							return "▼ "+start_date+" ~ "+end_date;
						}		
					},
					maxDate: maxdate_gap,
				    showOtherMonths: true,
				    selectOtherMonths: true,
					showMonthAfterYear:true,
					yearSuffix:"년",
					monthNamesShort:['1','2','3','4','5','6','7','8','9','10','11','12'],
					monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
					dayNamesMin: ['일','월','화','수','목','금','토'],
					dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
					dateFormat:"yy-mm-dd",
					onSelect: function(dateText, inst){
						if(rank_period=='day'){
							$("#start_date").val($(this).val());
							$("#end_date").val($(this).val());
							rankingSubmit();
						}else if(rank_period=='week'){
							let picked = $(this).datepicker("getDate");
							start_date_pick = new Date(picked.getFullYear(), picked.getMonth(), picked.getDate()-picked.getDay()+1);
							end_date_pick  = new Date(picked.getFullYear(), picked.getMonth(), picked.getDate()-picked.getDay()+7);
							let dateFormat = inst.settings.dateFormat || $.datepicker._defaults.dateFormat;
							$("#start_date").val($.datepicker.formatDate(dateFormat, start_date_pick, inst.settings))
							$("#end_date").val($.datepicker.formatDate(dateFormat, end_date_pick, inst.settings));
							rankingSubmit();
						}
					},
					beforeShow:function(){
						if(rank_period=='week'){
							selectCurrentWeek();
						}
					},
				    beforeShowDay: function(date) {
						if(rank_period=='week'){
					        let cssClass = "";
					        if(date>=start_date_pick && date<=end_date_pick)
					            cssClass = "ui-datepicker-current-day";
					        return [true, cssClass];
						}else{
							return [true];
						}
				    },
				    onChangeMonthYear: function(year, month, inst) {
						if(rank_period=='week'){
					        selectCurrentWeek();
						}
				    }
				});
				function selectCurrentWeek() {
					window.setTimeout(function(){
						 $("#ui-datepicker-div").find(".ui-datepicker-current-day a").addClass("ui-state-active");
					}, 1);
				}
				

			}
			
			//기준이 월이나 년인 경우
			if(rank_period=='month' || rank_period=='year'){
	            $("#start_date").datepicker({
	            	showOn:"button",
					buttonText: "▼ "+start_date+" ~ "+end_date,	
					closeText: '선택',
					yearSuffix:(rank_period=='year')?"년":"",
					monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
					monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
					dateFormat: 'yy-mm-dd',
					isRTL: false,
					showMonthAfterYear: true,
					changeMonth: true,
					changeYear: true,
					showButtonPanel: true,
					yearRange: 'c-99:c+99',
					onClose: function(dateText, inst){
						let dateFormat = inst.settings.dateFormat || $.datepicker._defaults.dateFormat;
						let year = Number($(".ui-datepicker-year option:selected").val());
						if(rank_period=='month'){
							let month = Number($(".ui-datepicker-month option:selected").val());
							start_date_pick = new Date(year, month, 1);
							end_date_pick  = new Date(year, month+1, 0);
							$("#start_date").val($.datepicker.formatDate(dateFormat, start_date_pick, inst.settings))
							$("#end_date").val($.datepicker.formatDate(dateFormat, end_date_pick, inst.settings));
							rankingSubmit();  
						}else if(rank_period=='year'){
							start_date_pick = new Date(year, 0, 1);
							end_date_pick  = new Date(year+1, 0, 0);
							$("#start_date").val($.datepicker.formatDate(dateFormat, start_date_pick, inst.settings))
							$("#end_date").val($.datepicker.formatDate(dateFormat, end_date_pick, inst.settings));
							rankingSubmit(); 
						}
					},
					beforShow:function(){
							var selectDate = $("#start_date").val().split("-");
							var year = Number(selectDate[0]);
							var month = Number(selectDate[1]) - 1;
							$(this).datepicker( "option", "defaultDate", new Date(year, month, 1) );
					}
	            });
			}
				
			//공통
			$(".ui-datepicker-trigger").click(function(){
				if(rank_period=='day'){
					$("#ui-datepicker-div").css({
						'top':Math.floor($(this).offset().top+30)+'px',
						'left':Math.floor($(this).offset().left-75)+'px'
					});
				}else{
					$("#ui-datepicker-div").css({
						'top':Math.floor($(this).offset().top+30)+'px',
						'left':Math.floor($(this).offset().left-15)+'px'
					});
				}
			})
			$(window).resize(function(){
				window.setTimeout(function () {
					$("#ui-datepicker-div").css('display','none');
				},1);
			})
			
		}
		
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
			<input type="hidden" id="s_genre" name="s_genre" />
			<div class="btn-group btn-group-justified">
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
					<input type="date" id="start_date" name="start_date" />
					<input type="date" id="end_date" name="end_date" />
				</div>				
				<div id="periodNav" class="col-sm-3 col-sm-offset-1">
					<input type="hidden" id="rank_period" name="rank_period" />
					<ul class="nav nav-pills">
						<li role="presentation"><a role="button" class="periodBtn" data-period="day">일간</a></li>
						<li role="presentation"><a role="button" class="periodBtn" data-period="week">주간</a></li>
						<li role="presentation"><a role="button" class="periodBtn" data-period="month">월간</a></li>
						<li role="presentation"><a role="button" class="periodBtn" data-period="year">연간</a></li>
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
								"/uploadStorage${rank.s_posterimg.img_dir}/${rank.s_posterimg.img_name}.${rank.s_posterimg.img_type}"
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
						<div class="topRankBox_point" data-point="${rank.s_point}">&nbsp;<fmt:formatNumber value="${rank.s_point}" pattern=".00" /></div>
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
								"/uploadStorage${rank.s_posterimg.img_dir}/${rank.s_posterimg.img_name}.${rank.s_posterimg.img_type}"
							</c:if>
							<c:if test="${rank.s_posterimg eq null}">
								"/uploadStorage/show/poster_default.jpg"
							</c:if>
							 class="rankBox_img" />
						</a>
					</div>
					<div class="otherRankBox_text col-xs-4 col-xs-offset-1">
						<p class="otherRankBox_title">${rank.s_name}</p>
						<br/>
						<p class="otherRankBox_theater"><strong>장소 : </strong>${rank.th_name}</p>
						<p class="otherRankBox_date"><strong>기간 : </strong>${rank.s_opendate} ~ ${show.s_closedate}</p>
					</div>
					<div class="otherRankBox_ticket_point col-xs-2">
						<div class="row"><span class="otherRankBox_ticket">${rank.rank_ticket}%</span></div>
						<c:set var="s_point" value="${(rank.s_point+0.005)-((rank.s_point+0.005)%0.01)}" />
						<div class="row otherRankBox_pointBox" data-point="${rank.s_point}">&nbsp;<fmt:formatNumber value="${rank.s_point}" pattern="0.00" /></div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

</body>
</html>