<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/popup.jspf" %>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<title>회원 쿠폰 내역</title>

</head>
<body>
<div class="contentTit page-header"><h3 class="text-center">회원 쿠폰 내역</h3></div>  
<div class="container">
			<table class="table table-bordered">
				<thead>
					<tr>
							<th class="text-center col-md-3">쿠폰이름</th>
							<th class="text-center col-md-3">쿠폰번호</th>
							<th class="text-center col-md-1">할인율</th>
							<th class="text-center col-md-2">사용기간</th>
							<th class="text-center col-md-2">발급날짜</th>
							<th class="text-center col-md-1">사용여부</th>
					</tr>
				</thead>
				<tbody>
					<!-- 데이터 출력 -->
							<c:choose>
									<c:when test="${not empty couponList}">
										<c:forEach var="coupon" items="${couponList}" varStatus="status">
											<tr class="text-center" data-num="${coupon.c_num}">
												<td class="text-center">${coupon.c_name}</td>
												<td class="text-center">${coupon.c_num}</td>
												<td class="text-center">${coupon.c_discount}%</td>
												<td class="text-center"><span>${coupon.c_startdate}</span>~<span>${coupon.c_enddate}</span></td>
												<td class="text-center">${coupon.uc_date}</td>
												<td class="text-center">
													<c:if test="${coupon.uc_state == 0}">
													미사용
													</c:if>
													<c:if test="${coupon.uc_state == 1}">
													사용완료
													</c:if>
													<c:if test="${coupon.uc_state == -1}">
													기간만료
													</c:if>
												</td>
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


</body>
</html>