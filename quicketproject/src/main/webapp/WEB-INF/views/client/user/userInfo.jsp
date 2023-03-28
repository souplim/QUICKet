<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

<title>회원 정보</title>

<script>
	$(function(){
		$("#userUpdateBtn").click(function(){
			location.href="/user/userUpdateForm?u_num=" + ${userInfo.u_num};
		});
		
		$("#updatePwdBtn").click(function(){
			location.href="/user/setPwdForm?u_num=" + $("#u_num").val();
		});
	});
</script>
		
</head>
<body>
	회원 정보
	<div class="container">
	<form id="userNum"><input type="hidden" id="u_num" name="u_num" value="${userLogin.u_num}"/></form>
	<table class="table">
		<tr>
			<td class="text-center">이름</td>
			<td colspan="3">${userInfo.u_name}</td>
		</tr>
		<tr>
			<td class="text-center">아이디</td>
			<td colspan="3">${userInfo.u_id}</td>
		</tr>
		<tr>
			<td class="text-center">비밀번호</td>
			<td></td>
			<td colspan="2">마지막 비밀번호 변경일 : ${userInfo.u_pwddate}</td>
		</tr>
		<tr>
			<td class="text-center">성별</td>
			<td>
				<c:choose>
					<c:when test="${userInfo.u_gender == 'M'}">
						남
					</c:when>
					<c:otherwise>
						여
					</c:otherwise>
				</c:choose>
			</td>
			<td class="text-right">생년월일</td>
			<td>${userInfo.u_birth }</td>
		</tr>
		<tr>
			<td class="text-center">이메일</td>
			<td colspan="3" class="">${userInfo.u_email}</td>
		</tr>
		<tr>
			<td class="text-center">전화번호</td>
			<td colspan="3">${userInfo.u_phone}</td>
		</tr>
		<tr>
			<td colspan="3"></td>
			<td class="text-right"><button class="btn btn-warning" id="userUpdateBtn">회원정보 수정</button></td>
		</tr>
	</table>
	</div>
</body>
</html>