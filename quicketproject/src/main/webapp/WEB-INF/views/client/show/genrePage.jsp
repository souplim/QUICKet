<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<style type="text/css">
#searchBox{
	margin-bottom:80px;
}
#genrePageDate{
	display:inline-block;
	float:left;
}
#genrePageTab{
	display:inline-block;
	float:right;
}
.genreBox{
	display:inline-block;
	vertical-align:top;
	box-shadow:10px 10px 20px 3px rgb(123,123,123,0.5);
	margin:10px;
	padding:15px 20px;
	width: 250px;
	height: 450px;
	text-align:center;
}
.genreBox_img{
	max-width:100%;
	margin-bottom:10px;
}
.genreBox_title{
	font-size:20px;
	font-weight:bold;
}
a[role='tab']{
	font-weight:bold;
	color:#ccc;
}
.tab-content{
	height:350px;
}
</style>
<link rel="stylesheet" href="/resources/include/css/jquery-ui-custom.css" />
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="/resources/include/js/showBox.js"></script>
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
			$("#searchData").click();
		})
		
		//달력기능 처리 이벤트
		$("#datepicker").datepicker({
		    showOtherMonths: true,
		    selectOtherMonths: true,
			showMonthAfterYear:true,
			yearSuffix:"년",
			buttonText:"선택",
			showMonthAfterYear:true,
			yearSuffix:"년",
			monthNamesShort:['1','2','3','4','5','6','7','8','9','10','11','12'],
			monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			dayNamesMin: ['일','월','화','수','목','금','토'],
			dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
			dateFormat:"yy-mm-dd",
			onSelect:function(){
				$("#start_date").val($(this).val());
				$("#end_date").val($(this).val());
				$("#searchData").click();
			}
		});
		
		//해당 장르 전체 평점 랭킹 3개 받아오기
		$.getJSON("/genrePointRankList?s_genre="+param_genre,function(data){
			$(data).each(function(){
				makeShowBox(this, "#genrePointRankPanel", "s_point", 180, 320);
			})
		}).fail(function(){alert("메인페이지 로딩 중에 오류가 발생했습니다. 관리자에게 문의하세요.")})
		
		//해당 이번 주 예매율 랭킹 3개 받아오기
		$.getJSON("/genreTicketRankList?s_genre="+param_genre,function(data){
			$(data).each(function(){
				makeShowBox(this, "#genreTicketRankPanel", "rank_ticket", 180, 320);
			})
		}).fail(function(){alert("메인페이지 로딩 중에 오류가 발생했습니다. 관리자에게 문의하세요.")})	
		
		//장르 박스 포인트란에 별 부여
		$(".genreBox_subtxt_point").each(function(){
			let point = $(this).data('point');
			makeStar($(this), point);
		})
	})
</script>
	
</head>
<body>
	<div class="container">
		<br/><br/><br/>
		<div class="row">
			<form class="form-horizontal" id="f_search">
				<input type="hidden" class="s_genre" name="s_genre" value="${ShowVO.s_genre}"/>
				<div id="searchBox" class="form-group">
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
				<div class="form-group">
					<div id="genrePageDate">
						<div id="datepicker"></div>
						<input type="hidden" id="start_date" name="start_date" />	
						<input type="hidden" id="end_date" name="end_date" />	
					</div>
					<div id="genrePageTab">
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
				<div class="form-group"><div class="col-sm-2 col-sm-offset-1">
					<select name="s_select_region" id="s_select_region" class="form-control">
						<option value="">지역</option>
						<option value="서울">서울</option>
						<option value="경기">경기</option>							
					</select>
				</div></div>
			</form>
		</div>
		<br/><br/><br/>
		<div class="row">
			<div id="genrelist" class="col-xs-12">		
				<c:forEach var="show" items="${showList}">
					<div class="genreBox" data-num="${show.s_num}">
						<div class="genreBox_thumbnail">
							<a href="/showDetail?s_num=${show.s_num}">
								<img src=
								<c:if test="${show.s_posterimg ne null}">
									"/uploadStorage${show.s_posterimg.img_dir}/${show.s_posterimg.img_name}.${show.s_posterimg.img_type}"
								</c:if>
								<c:if test="${show.s_posterimg eq null}">
									"/uploadStorage/show/poster_default.jpg"
								</c:if>
								 class="genreBox_img" />
							</a>
						</div>
						<div class="genreBox_text">
							<p class="genreBox_title">${show.s_name}</p>
							<p class="genreBox_subtxt">${show.s_opendate}</p>
							<c:set var="s_point" value="${(show.s_point+0.005)-((show.s_point+0.005)%0.01)}" />
							<span class="genreBox_subtxt_point" data-point="${s_point}">${s_point}</span>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		<c:import url="/WEB-INF/views/common/pagination.jsp" />
	</div>
</body>
</html>