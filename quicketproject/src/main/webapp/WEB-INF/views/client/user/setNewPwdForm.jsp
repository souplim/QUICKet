<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>새로운 비밀번호 설정</title>

<style>
	.table>tbody>tr>td {border:none;}
</style>

<script>
	$("#newPwdBtn").click(function(){
		$("#pwdForm").attr({
			"method" : "post",
			"enctype" : "multipart/form-data",
			"action" : "/user/setNewPwd?u_id="+$("#u_id").val()
		});
		$("#pwdForm").submit();
	});
</script>
</head>
<body>

    <div class="container">

      <form class="form-signin" id="pwdForm">
      <input type="hidden" id="u_id" value="${user.u_id}"/>
        	<table class="table" id="table">
				<tr class="form-group">
					<td class="text-center">새 비밀번호</td>
					<td colspan="3">
					<div class="form-group has-feedback">
					<input type="password" class="form-control" id="newPwd" name="newPwd" placeholder="영문자(대문자 포함), 숫자 조합 8-20자"/>
					<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
					</div>
					</td>
				</tr>
				<tr class="form-group">
					<td class="text-center">새 비밀번호 확인</td>
					<td colspan="3">
					<div class="form-group has-feedback">
					<input type="password" class="form-control" id="u_pwd" name="u_pwd" placeholder="새 비밀번호를 한 번 더 입력해주세요."/>
					<span class="glyphicon form-control-feedback" aria-hidden="true"></span>
					</div>
					</td>
				</tr>
				<tr id="btnArea">
					<td></td>
					<td colspan="3">
						<button type="button" id="newPwdBtn" class="btn btn-block">확인</button>
					</td>
				</tr>
			</table>
      </form>
    

    </div> <!-- /container -->
</body>
</html>