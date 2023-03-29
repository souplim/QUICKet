<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<style type="text/css">
#showBox_template{
	display:none;
}
.showBox{
	padding:10px;
	text-align:center
}
.showBox_img{
	width:100%;
	margin:0px 0px 10px 0px;
}
.showBox_thumbnail{
	display:inline-block;
}
.showBox_text{
	display:inline-block;
	text-align:center;
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js" integrity="sha512-T/tUfKSV1bihCnd+MxKD0Hm1uBBroVYBOYSk1knyvQ9VyZJpc/ALb4P0r6ubwVPSGB2GvjeoMAJJImBG12TiaQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" integrity="sha512-mSYUmp1HYZDFaVKK//63EcZq4iFWFjxSL+Z3T/aCt4IO9Cejm03q3NKKYN6pFQzY0SBOr8h+eCIAZHPXcpZaNw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js" integrity="sha512-L4qpL1ZotXZLLe8Oo0ZyHrj/SweV7CieswUODAAPN/tnqN3PA1P+4qPu5vIryNor6HQ5o22NujIcAZIfyVXwbQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript">
	$(function(){
		let s_genre = "<c:out value='${showVO.s_genre}' />"
		let param_genre = encodeURIComponent(s_genre);
		
		$(".s_genre").each(function(){
			$(this).val(s_genre);
		})
		
		/*검색 후 select 위치 맞추기*/
		let region = "<c:out value='${showVO.s_select_region}' />";
		if(region!=""){
			$("#s_select_region").val(region).prop("selected",true);
		}
		
		/* 입력 양식 enter 제거 */
		$("#keyword").bind("keydown", function(event){
			 if (event.keyCode == 13) {
			        event.preventDefault();
			        $("#searchData").click();
			    }
		});
		
		/* 검색 버튼 클릭 시 처리 이벤트 */
		$("#searchData").click(function(){
			if($("#start_date").val()>$("#end_date").val()){
				alert("시작날짜가 종료날짜보다 더 클 수 없습니다.");
				return
			}
			if($("#keyword").val()==""){
				$("#search").val()==""
			}
			if($("#s_array")!="" && $("#sortorder").val()==""){
				$("#sortorder").val("desc")
			}
			$("#f_search").attr({
					"method":"get",
					"action":"/search"
			});
			$("#f_search").submit();
			
		});

		/* 정렬 박스 선택시 처리 이벤트 */
		$("#s_select_region").change(function(){
			$("#f_select").attr({
				"method":"get",
				"action":location.pathname
			});
			$("#f_select").submit();
		})
		
		
		$("#datepicker").datepicker({
			language:"ko"
		});
		$("#datepicker").on("changeDate", function(){
			$("#date_value").val(
				$("#datepicker").datepicker("getFormattedDate")
			)
		})
		
		//해당 장르 전체 평점 랭킹 3개 받아오기
		$.getJSON("/genrePointRankList?s_genre="+param_genre,function(data){
			$(data).each(function(){
				makeShowBox(this, "#genrePointRankPanel", "s_point", "4");
			})
		}).fail(function(){alert("메인페이지 로딩 중에 오류가 발생했습니다. 관리자에게 문의하세요.")})
		
		//해당 이번 주 예매율 랭킹 3개 받아오기
		$.getJSON("/genreTicketRankList?s_genre="+param_genre,function(data){
			$(data).each(function(){
				makeShowBox(this, "#genreTicketRankPanel", "rank_ticket", "4");
			})
		}).fail(function(){alert("메인페이지 로딩 중에 오류가 발생했습니다. 관리자에게 문의하세요.")})
		 
		function makeShowBox(vo, panel, sub, size){
			let $panel = $(panel);
			
			let $showBox = $("#showBox_template").clone().removeAttr("id");
			$showBox.addClass("col-xs-"+size);
			let s_num = vo.s_num;
			$showBox.attr("data-num", s_num);
			
			let s_name = vo.s_name;
			
			let subtxt ='';
			if(sub=='rank_ticket'){
				subtxt = vo.rank_ticket+"%";
			}else if(sub=='s_opendate'){
				subtxt = vo.s_opendate;
			}else if(sub=='s_point'){
				subtxt = vo.s_point;
			}
			
			let $title = $("<p class='showBox_title'>"+s_name+"</p>");
			let $subtxt = $("<p class='showBox_subtxt'>"+subtxt+"</p>");
			$showBox.find(".showBox_text").append($title).append($subtxt);
			
			let $poster = $("<img />");
			let poster_url="";
			if(vo.s_posterimg!=null){
				let poster_img = vo.s_posterimg;
				let poster_dir = poster_img.img_dir;
				let poster_name = poster_img.img_name;
				let poster_type = poster_img.img_type;
				
				poster_url = "/uploadStorage/"+poster_dir+"/"+poster_name+"."+poster_type;
			}
			
			$poster.addClass("showBox_img");
			if(poster_url!=""){
				$poster.attr("src", poster_url);
			}else{
				poster_url="/uploadStorage/show/poster_default.jpg"
				$poster.attr("src", poster_url);
			}
			
			let $link = $("<a href='/showDetail?s_num="+s_num+"'></a>");	
			$link.append($poster);
			
			$showBox.find(".showBox_thumbnail").append($link);
			
			$panel.append($showBox);
		}	
	})
</script>
	
</head>
<body>
	<div class="container">
		<br/><br/><br/>
		<div class="row">
			<form class="form-horizontal" id="f_search">
				<input type="hidden" class="s_genre" name="s_genre" value="${ShowVO.s_genre}"/>
				<div class="form-group">
					<div class="col-sm-2 col-sm-offset-2">
						<select id="search" name="search" class="form-control">
							<option value="s_name">공연명</option>
							<option value="th_name">공연장명</option>
						</select>
					</div>
					<div class="col-sm-4">
						<input type="text" name="keyword" id="keyword" class="form-control" />
					</div>
					<div class="col-sm-2">
						<button type="button" id="searchData" class="form-control btn btn-default">검색</button>
					</div>
				</div>
			</form>
			<form class="form-horizontal" id="f_select">
				<div class="form-group">
					<input type="hidden" class="s_genre" name="s_genre" value="${ShowVO.s_genre}"/>
					<div class="col-sm-2 col-sm-offset-2">
						<div id="datepicker"></div>
						<input type="hidden" id="date_value" />	
						<br/>
						<select name="s_select_region" id="s_select_region" class="form-control">
							<option value="">지역</option>
							<option value="서울">서울</option>
							<option value="경기">경기</option>							
						</select>
					</div>
					<div class="col-sm-4 col-sm-offset-2">
						<ul class="nav nav-tabs" role="tablist">
							<li class="disabled">
								<a href="#">WEEK RANKING</a>
							</li>
							<li role="presentation" class="active">
								<a href="#pointRank" aria-controls="pointRank" role="tab" data-toggle="tab">평점순</a>
							</li>
							<li role="presentation">
								<a href="#ticketRank" aria-controls="ticketRank" role="tab" data-toggle="tab">예매율순</a>
							</li>
						</ul>
						<!-- 탭의 컨텐츠를 표시하는 각 패널 부분 -->
						<div class="tab-content">
							<div role="tabpanel" class="tab-pane active" id="pointRank">
								<div id="genrePointRankPanel"></div>
							</div>
							<div role="tabpanel" class="tab-pane" id="ticketRank">
								<div id="genreTicketRankPanel"></div>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
		<br/><br/><br/>
		<div class="row">
			<div id="genrelist" class="col-xs-10 col-xs-offset-1">		
				<c:forEach var="show" items="${showList}">
					<div class="showBox col-xs-3" data-num="${show.s_num}">
						<div class="showBox_thumbnail">
							<a href="/showDetail?s_num=${show.s_num}">
								<img src=
								<c:if test="${show.s_posterimg ne null}">
									"/uploadStorage/${show.s_posterimg.img_dir}/${show.s_posterimg.img_name}.${show.s_posterimg.img_type}"
								</c:if>
								<c:if test="${show.s_posterimg eq null}">
									"/uploadStorage/show/poster_default.jpg"
								</c:if>
								 class="showBox_img" />
							</a>
						</div>
						<div class="showBox_text">
							<p class="showBox_title">${show.s_name}</p>
							<p class="showBox_subtxt">${show.s_opendate}</p>
							<p class="showBox_subtxt">${show.s_point}</p>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		<c:import url="/WEB-INF/views/common/pagination.jsp" />
		<!-- 공연 박스 템플릿 -->
		<div id="showBox_template" class="showBox">
			<div class="showBox_thumbnail">
			</div>
			<div class="showBox_text"></div>
		</div>
	</div>
</body>
</html>