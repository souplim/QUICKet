<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<style type="text/css">
th{
	text-align:center;
}
</style>
<script type="text/javascript">
	$(function(){
		$.ajax()
		
		
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
				<h2>${detailData.s_name}</h2>
			</div>
			<br />
			<div class="row">
				<div class="showBox_thumbnail col-xs-3">
					<img src=
					<c:if test="${detailData.s_posterimg ne null}">
						"/uploadStorage/${detailData.s_posterimg.img_dir}/${detailData.s_posterimg.img_name}.${detailData.s_posterimg.img_type}"
					</c:if>
					<c:if test="${detailData.s_posterimg eq null}">
						"/uploadStorage/show/poster_default.jpg"
					</c:if>
					class="showBox_img" />
				</div>
				<div class="showBox_detail_text col-xs-6 col-xs-offset-1">
					<table class="table">
						<tr>
							<th>공연장</th>
							<td>${detailData.th_name}</td>
						</tr>
						<tr>
							<th>공연기간</th>
							<td>${detailData.s_opendate} ~ ${detailData.s_closedate}</td>
						</tr>
						<tr>
							<th>공연시간</th>
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
		<div class="ticketBox row">예매기능이<br/>들어갈<br/>박스입니다.</div>
		<br/><br/>
		<!-- 상세페이지 탭 기능 구현 -->
		<div class="detail_tabBox row">
			
				<!-- Navi 형 탭리스트 -->
				<ul class="nav nav-pills" role="tablist">
					<li class="disabled">
						<a href="#">WEEK RANKING</a>
					</li>
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
				
				<br/><br/>
				
				<!-- 탭의 컨텐츠를 표시하는 각 패널 부분 -->
				<div class="tab-content">
					<div role="tabpanel" class="tab-pane active" id="detailimgBox">
						<div class="row">
							<c:if test="${detailData.s_detailimg ne null and not empty detailData.s_detailimg}"></c:if>
							<c:forEach var="detailimg" items="${detailData.s_detailimg}">
								<c:if test="${detailimg ne null}">
									<img class="showBox_img" src="/uploadStorage/${detailimg.img_dir}/${detailimg.img_name}.${detailimg.img_type}" />
								</c:if>
							</c:forEach>
						</div>
					</div>
					<div role="tabpanel" class="tab-pane" id="theaterBox">
						<div class="row">
							<div class="row">
								<h3>${detailData.th_name}</h3>
							</div>
							<br />
							<div class="row">
								<table class="table table-bordered">
									<tr>
										<th class="col-xs-2">좌석수</th>
										<td class="col-xs-10"></td>
									</tr>
									<tr>
										<th>주소</th>
										<td></td>
									</tr>
									<tr>
										<th>웹사이트</th>
										<td></td>
									</tr>
									<tr>
										<th colspan="2">공연장 지도</th>
									</tr>
									<tr>
										<td colspan="2"></td>
									</tr>						
								</table>
							</div>

						</div>
					</div>
					<div role="tabpanel" class="tab-pane" id="reviewBox">
						<div class="row"></div>
					</div>
					<div role="tabpanel" class="tab-pane" id="expectBox">
						<div class="row"></div>
					</div>
					<div role="tabpanel" class="tab-pane" id="qnaBox">
						<div class="row"></div>
					</div>
					<div role="tabpanel" class="tab-pane" id="guideBox">
						<div class="row">
							<div id="s_guide">${detailData.s_guide}</div>
						</div>
					</div>															
				</div>
		
		</div>
	</div>

</body>
</html>