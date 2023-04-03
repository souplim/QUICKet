<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<title>회원 쿠폰 내역</title>

</head>
<body>
<!-- 수정 필요 -->

<div class="table-responsive table-height">
			<table class="table table-bordered">
				<thead>
					<tr>
						<!-- <th class="text-center">번호</th> -->
						<th class="text-center">쿠폰번호</th>
						<th class="text-center">쿠폰명</th>
						<th class="text-center"></th>
						<th class="text-center">이메일</th>
						<th class="text-center">전화번호</th>
						<th class="text-center">성별</th>
						<th class="text-center">가입일</th>
			
					</tr>
				</thead>
				<tbody>
					<!-- 데이터 출력 -->
					<c:choose>
						<c:when test="${not empty userCouponList}" >
							<c:forEach var="coupon" items="${userCouponList}" varStatus="status">
								<tr class="text-center" data-num="${coupon.c_num}" data-id="${coupon.u_id}">
									<!-- <td>${count - status.index}</td> -->
									<td>${coupon.c_num}</td>
									<td>${user.u_name}</td>
									<td>${user.u_id}</td>
									<td>${user.u_email}</td>
									<td>${user.u_phone}</td>
									<c:choose>
										<c:when test="${user.u_gender == 'F'}">
											<td>여성</td>
										</c:when>
										<c:otherwise>
											<td>남성</td>
										</c:otherwise>
									</c:choose>
									<td>${user.u_regdate}</td>
									<td>${user.u_moddate}</td>
									<td>${user.u_pwddate}</td>
									<c:choose>
										<c:when test="${user.u_state == 1}">
											<td>일반회원</td>
										</c:when>
										<c:otherwise>
											<td>탈퇴회원</td>
										</c:otherwise>
									</c:choose>
									<td><button type="button" class="btn btn-primary ticketBtn">예매내역</button></td>
									<td><button type="button" class="btn btn-primary couponBtn">쿠폰내역</button></td>
									<c:choose>
										<c:when test="${user.u_state == 1}">
											<td><button type="button" class="btn btn-danger outBtn">탈퇴</button></td>
										</c:when>
										<c:otherwise>
											<td><button type="button" class="btn">탈퇴</button></td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="13" class="text-center">등록된 회원이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>


</body>
</html>