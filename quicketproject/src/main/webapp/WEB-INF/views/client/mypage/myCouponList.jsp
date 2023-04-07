<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"  %>

	<style type="text/css">
		.communityTitle { margin-bottom: 30px; }
	</style>

	<script type="text/javascript">
		$(function(){
			$("#notAvailable").on("click", function(){
				location.href="/mypage/myCouponListN";
			});
		});
		
	</script>
	</head>
	<body>
		<div class="contentContainer container">
			<%-- ================= 데이터 전달 폼 ================= --%>
			<form name="pageForm" id="pageForm">
				<!-- 페이징 처리를 위한 파라미터 -->
				<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum}"/>
				<input type="hidden" name="amount" id="amount" value="${pageMaker.cvo.amount}"/>
			</form>
			
			<div class="communityTitle">
				<h1>보유쿠폰</h1>
				<p>
					고객님께서 발급 받으신 할인 쿠폰 내역입니다. 사용가능한 쿠폰과 사용완료된 쿠폰을 확인할 수 있습니다.
				</p>
			</div>
			
			<%-- ================= 탭 시작 ================= --%>
			<div role="tabpanel">
			  <!-- Nav tabs -->
			  <ul class="nav nav-tabs" role="tablist">
			    <li role="presentation" class="active"><a href="#available" aria-controls="home" role="tab" data-toggle="tab">사용가능쿠폰</a></li>
			    <li role="presentation"><a id="notAvailable" href="" aria-controls="profile" role="tab" data-toggle="tab">사용완료쿠폰</a></li>
			  </ul>
			
			  <!-- Tab panes -->
			  <div class="tab-content">
			    <div role="tabpanel" class="tab-pane active" id="available">
			    
			    	<%-- ================= 사용가능 쿠폰 리스트 시작 ================= --%>
					<div id="qnaList" class="table-height">
						<table summary="사용가능 쿠폰 리스트" class="table">
							<thead>
								<tr>
									<th class="text-center col-md-3">쿠폰이름</th>
									<th class="text-center col-md-3">쿠폰번호</th>
									<th class="text-center col-md-1">할인율</th>
									<th class="text-center col-md-3">사용기간</th>
									<th class="text-center col-md-2">남은일자</th>
								</tr>
							</thead>
							<tbody id="list">
								<c:choose>
									<c:when test="${not empty couponList}">
										<c:forEach var="coupon" items="${couponList}" varStatus="status">
											<tr class="text-center" data-num="${coupon.c_num}">
												<td class="text-center">${coupon.c_name}</td>
												<td class="text-center">${coupon.c_num}</td>
												<td class="text-center">${coupon.c_discount}%</td>
												<td class="text-center">${coupon.c_startdate}~${coupon.c_enddate}</td>
												<td class="text-center">${coupon.c_remain}일</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="5" class="tac text-center">사용가능한 쿠폰이 존재하지 않습니다.</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
					
					<%-- ================= 페이징 출력 시작 ================= --%>
					<div class="text-center">
						<ul class="pagination">
							<!-- 이전 바로가기 10개 존재 여부를 prev 필드의 값으로 확인 -->
							<c:if test="${pageMaker.prev}">
								<li class="paginate_button previous">
									<a href="${pageMaker.startPage -1}">Previous</a>
								</li>
							</c:if>
							
							<!-- 바로가기 번호 출력 -->
							<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
								<!-- 현재 페이지 색깔 : 현재 보고 있는 페이지와 for문으로 돌리고 있는 페이지가 일치하면 class='active' 적용 -->
								<li class="paginate_button ${pageMaker.cvo.pageNum == num ? 'active':''}">
									<a href="${num}">${num}</a>
								</li>
							</c:forEach>
							
							<!-- 다음 바로가기 10개 존재 여부를 next 필드의 값으로 확인 -->
							<c:if test="${pageMaker.next}">
								<li class="paginate_button next">
									<a href="${pageMaker.endPage+1}">Next</a>
								</li>
							</c:if>
						</ul>
					</div>
			    
			    </div>
			    
			    <!-- <div role="tabpanel" class="tab-pane" id="profile"></div> -->
			  </div>
			</div>
			
			
		
		</div>
	</body>
</html>