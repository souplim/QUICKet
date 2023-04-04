<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<style type="text/css">
.showBox_detail{
	box-shadow:10px 10px 20px 3px rgb(123,123,123,0.5);
	padding:30px 50px 50px 50px;
}
.showBox_detail_genre{font-size:16px; font-weight:bold;}
.showBox_detail_genre a{color: #888;}
.showBox_detail_title{margin-left:5px;}
.showBox_detail_title h1{font-weight:bold;}
.showBox_detail_text table{font-size:16px;}
.showBox_detail_text tr{border-style:hidden; height:50px}
.showBox_detail_text th{width:120px}
#theaterBox th{text-align:center;}
#theaterBox td{text-align:left;}
div[role="tabpanel"]{min-height:30em;}
.nav-pills>li{
	text-align:center;
	width:150px;
}
.nav-pills>li+li{
    margin-left: 0px;
}
.nav-pills>li>a{
	color: gray;
    border-radius: 4px 4px 0px 0px;
    border-bottom: 2px solid rgb(120,120,120,0.3);
}
.nav-pills>li.active>a{
    color: black;
    background-color: transparent;
    border-top: 2px solid rgb(120,120,120,0.3);
    border-left: 2px solid rgb(120,120,120,0.3);
    border-right: 2px solid rgb(120,120,120,0.3);
    border-bottom: none;
}
.nav-pills>li.active>a:focus, .nav-pills>li.active>a:hover{
	background-color: #eee;
}
.tab-content{
	padding:100px 0px 50px 0px;
}
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3dc7376a2cb1e4f12306eaaebe2593e4"></script>
<script type="text/javascript" src="/resources/include/js/theaterMap.js"></script>
<script type="text/javascript">
	$(function(){		
		$("a[aria-controls='theaterBox']").on("shown.bs.tab", function(){
			let th_num = Number("<c:out value='${detailData.th_num}' />");		
			$.ajax({
				url:"/theater/theaterOne",
				type:"post",
				headers:{
					"Content-Type":"application/json"
				},
				dataType:"text",
				data: JSON.stringify({
					th_num:th_num
				}),
				success:function(result){
					let theater = JSON.parse(result);
					
					$("#th_name").html(theater.th_name);
					$("#th_seat").html("총 "+theater.th_seat+"석");
					$("#th_addr").html(theater.th_addr);
					$("#th_web").html(theater.th_web);
					
					let th_name = theater.th_name;
					let th_map_lat = theater.th_map_lat;
					let th_map_lng = theater.th_map_lng;
					
	
					makemap("th_map", th_map_lat, th_map_lng, th_name, "100%", "500px");
				},
				error:function(xhr, textStatus, errorThrown){
					alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
				}
			})
		})
		
	})
</script>
</head>
<body>
	<br/><br/>
	<div class="container">
		<div class="showBox_detail row">
			<div class="showBox_detail_genre row">
				<p>장르> <a href="/genre?s_genre=${detailData.s_genre}">${detailData.s_genre}</a></p>
			</div>
			<div class="showBox_detail_title row">
				<h1>${detailData.s_name}</h1>
			</div>
			<br />
			<div class="row">
				<div class="showBox_thumbnail col-sm-3">
					<img src=
					<c:if test="${detailData.s_posterimg ne null}">
						"/uploadStorage/${detailData.s_posterimg.img_dir}/${detailData.s_posterimg.img_name}.${detailData.s_posterimg.img_type}"
					</c:if>
					<c:if test="${detailData.s_posterimg eq null}">
						"/uploadStorage/show/poster_default.jpg"
					</c:if>
					class="showBox_img" />
				</div>
				<div class="showBox_detail_text col-sm-7 col-sm-offset-2">
					<table class="table">
						<tr>
							<th>장소</th>
							<td>${detailData.th_name}</td>
						</tr>
						<tr>
							<th>기간</th>
							<td>${detailData.s_opendate} ~ ${detailData.s_closedate}</td>
						</tr>
						<tr>
							<th>관람시간</th>
							<td>${detailData.s_time}분</td>
						</tr>
						<tr>
							<th>주최·주관</th>
							<td>${detailData.s_sponsor}</td>
						</tr>
						<tr>
							<th>기획·제작</th>
							<td>${detailData.s_director}</td>
						</tr>
						<tr>
							<th>티켓가격</th>
							<td>${detailData.s_price}원</td>
						</tr>						
					</table>
				</div>
			</div>
		</div>
		<br/><br/>
		<!-- 예매기능 박스 -->
		<div class="ticketBox row">
			<c:import url="/WEB-INF/views/client/ticket/showDetail.jsp" />
		</div>
		<br/><br/>
		<!-- 상세페이지 탭 기능 구현 -->
		<div class="detail_tabBox row">
			<div class="row">
				<div class="col-xs-10 col-xs-offset-1">
					<!-- Navi 형 탭리스트 -->
					<ul class="nav nav-pills" role="tablist">
						<li role="presentation" class="active">
							<a href="#detailimgBox" aria-controls="detailimgBox" role="tab" data-toggle="tab">공연 소개</a>
						</li>
						<li role="presentation">
							<a href="#theaterBox" aria-controls="theaterBox" role="tab" data-toggle="tab">공연장 안내</a>
						</li>
						<li role="presentation">
							<a href="#reviewBox" aria-controls="reviewBox" role="tab" data-toggle="tab">관람 후기</a>
						</li>
						<li role="presentation">
							<a href="#expectBox" aria-controls="expectBox" role="tab" data-toggle="tab">기대평</a>
						</li>
						<li role="presentation">
							<a href="#qnaBox" aria-controls="qnaBox" role="tab" data-toggle="tab">Q&A</a>
						</li>
						<li role="presentation">
							<a href="#guideBox" aria-controls="guideBox" role="tab" data-toggle="tab">안내사항</a>
						</li>					
					</ul>
				</div>
			</div>	
			<!-- 탭의 컨텐츠를 표시하는 각 패널 부분 -->
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane active" id="detailimgBox">
					<div class="row text-center">
						<c:if test="${detailData.s_detailimg ne null and not empty detailData.s_detailimg}"></c:if>
						<c:forEach var="detailimg" items="${detailData.s_detailimg}">
							<c:if test="${detailimg ne null}">
								<img class="showBox_img" src="/uploadStorage/${detailimg.img_dir}/${detailimg.img_name}.${detailimg.img_type}" />
							</c:if>
						</c:forEach>
					</div>
				</div>
				<div role="tabpanel" class="tab-pane" id="theaterBox">
					<div class="row text-center">
						<div class="row">
							<h3 id="th_name"></h3>
						</div>
						<br />
						<div class="row">
							<table class="table table-bordered">
								<tr>
									<th class="col-xs-2">좌석수</th>
									<td class="col-xs-10" id="th_seat"></td>
								</tr>
								<tr>
									<th>주소</th>
									<td id="th_addr"></td>
								</tr>
								<tr>
									<th>웹사이트</th>
									<td id="th_web"></td>
								</tr>
								<tr>
									<th colspan="2">공연장 지도</th>
								</tr>
								<tr>
									<td colspan="2">
										<div id="th_map"></div>
									</td>
								</tr>						
							</table>
						</div>

					</div>
				</div>
				<div role="tabpanel" class="tab-pane" id="reviewBox">
					<div class="row text-center">
						<c:import url="/WEB-INF/views/client/review/reviewList.jsp" />
					</div>
				</div>
				<div role="tabpanel" class="tab-pane" id="expectBox">
					<div class="row text-center"></div>
				</div>
				<div role="tabpanel" class="tab-pane" id="qnaBox">
					<div class="row text-center"></div>
				</div>
				<div role="tabpanel" class="tab-pane" id="guideBox">
					<div class="row text-center">
						<div id="s_guide">${detailData.s_guide}</div>
					</div>
				</div>															
			</div>
		</div>
	</div>

</body>
</html>