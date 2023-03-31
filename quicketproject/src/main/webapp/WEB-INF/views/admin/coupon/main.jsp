<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<title>관리자 쿠폰 관리</title>
</head>
<body>
<div class="table-responsive table-height">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th class="text-center">번호</th>
						<th class="text-center">쿠폰번호</th>
						<th class="text-center">쿠폰명</th>
						<th class="text-center">기간</th>
						<th class="text-center">할인율</th>
						<th class="text-center">등록일</th>
						<th class="text-center">발급횟수</th>
					</tr>
				</thead>
				<tbody>
					<!-- 데이터 출력 -->
					<c:choose>
						<c:when test="${not empty couponList}" >
							<c:forEach var="coupon" items="${couponList}" varStatus="status">
								<tr class="text-center" data-num="${coupon.c_num}">
									<td>글번호</td>
									<td>${coupon.c_num}</td>
									<td>${coupon.c_name}</td>
									<td><span>${coupon.c_startdate}</span>~<span>${coupon.c_enddate}</span></td>
									<td>${coupon.c_discount}%</td>
									<td>${coupon.c_regdate}</td>
									<td>발급횟수</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="7" class="text-center">등록된 쿠폰이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		
</body>
</html>