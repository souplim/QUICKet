<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

<title>회원 정보</title>

<script>
	$(function(){
		$("#userUpdateBtn").click(function(){
			location.href="/user/userUpdateForm";
		});
		
		$("#updatePwdBtn").click(function(){
			location.href="/user/setPwdForm";
		});
	});
</script>

<style>
  	#tableDiv {
  	margin-top : 50px;
    border: 1px solid darkgray;
    border-radius: 20px;
    padding: 0 20px;
  	}
  	.table>tbody>tr>td {border : none;}
</style>
		
</head>
<body>
	<div class="container">
	<form id="userNum">
		<input type="hidden" id="u_num" name="u_num" value="${userLogin.u_num}"/>
	</form>
	<br>
	<h3 class="text-center">회원 정보</h3>
	<div id="tableDiv">
			<table class="table">
			<br>
		<tr>
			<td class="text-center">이름</td>
			<td colspan="3">${userLogin.u_name}</td>
		</tr>
		<tr>
			<td class="text-center">아이디</td>
			<td colspan="3">${userLogin.u_id}</td>
		</tr>
		<tr>
			<td class="text-center">비밀번호</td>
			<td colspan="3">마지막 비밀번호 변경일 : ${userLogin.u_pwddate}</td>
		</tr>
		<tr>
			<td class="text-center">성별</td>
			<td>
				<c:choose>
					<c:when test="${userLogin.u_gender == 'M'}">
						남
					</c:when>
					<c:otherwise>
						여
					</c:otherwise>
				</c:choose>
			</td>
			<td class="text-right">생년월일</td>
			<td>${userLogin.u_birth }</td>
		</tr>
		<tr>
			<td class="text-center">이메일</td>
			<td colspan="3" class="">${userLogin.u_email}</td>
		</tr>
		<tr>
			<td class="text-center">전화번호</td>
			<td colspan="3">${userLogin.u_phone}</td>
		</tr>
		<tr>
			<td colspan="3"></td>
			<td class="text-right"><button class="w-btn-outline w-btn-indigo-outline btn" id="userUpdateBtn">회원정보 수정</button></td>
		</tr>
	</table>
	</div>
	</div>
</body>
</html>