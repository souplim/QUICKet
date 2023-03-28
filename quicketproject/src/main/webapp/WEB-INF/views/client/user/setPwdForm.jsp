<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<title>비밀번호 수정 </title>

<script>
	$(function(){
		let errorMsg = "${errorMsg}";
		if(errorMsg!="") {
			alert(errorMsg);
			errorMsg = "";
		}
		
		// 비밀번호 변경 확인 버튼 클릭 시
		$("#pwdUpdateBtn").click(function(){
			
			$("#pwdForm").attr({
				"method" : "post",
				"enctype" : "multipart/form-data",
				"action" : "/user/setNewPwd?u_num="+$("#u_num").val()
			});
			$("#pwdForm").submit();
		});
		
		
		
	});

</script>

<style>
	.table>tbody>tr>td {border:none;}
</style>
</head>
<body>

    <div class="container">

      <form class="form-signin" id="pwdForm">
      <input type="hidden" id="u_num" value="${userLogin.u_num}"/>
      <input type="hidden" id="u_id" value="${userLogin.u_id}"/>
        	<table class="table" id="table">
				<tr>
					<td class="text-center">이름</td>
					<td colspan="3">${userInfo.u_name}</td>
				</tr>
				<tr>
					<td class="text-center">아이디</td>
					<td colspan="3">${userInfo.u_id}</td>
				</tr>
				<tr>
					<td class="text-center">기존 비밀번호</td>
					<td colspan="3">
					<div class="form-group has-success has-feedback">
					<input type="password" class="form-control" id="oldPwd" name="oldPwd"/>
					<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
					</div>
					</td>
				</tr>
				<tr>
					<td class="text-center">새 비밀번호</td>
					<td colspan="3">
					<div class="form-group has-success has-feedback">
					<input type="password" class="form-control" id="newPwd" name="newPwd" placeholder="영문자(대문자 포함), 숫자 조합 8-20자"/>
					<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
					</div>
					</td>
				</tr>
				<tr>
					<td class="text-center">새 비밀번호 확인</td>
					<td colspan="3">
					<div class="form-group has-success has-feedback">
					<input type="password" class="form-control" id="u_pwd" name="u_pwd" placeholder="새 비밀번호를 한 번 더 입력해주세요."/>
					<span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
					</div>
					</td>
				</tr>
				<!-- 
				<tr>
					<td></td>
					<td colspan="3"><span id="pwdChkMsg">다시 입력해주세요.</span></td>
				</tr>
				-->
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
					<td colspan="3">${userInfo.u_email}</td>
				</tr>
				<tr>
					<td class="text-center">전화번호</td>
					<td colspan="3">${userInfo.u_phone}</td>
				</tr>
				<tr class="text-center">
					<td colspan="2"><button type="button" class="btn btn-info" id="cancelBtn">취소</button></td>
					<td colspan="2"><button type="button" class="btn btn-info" id="pwdUpdateBtn">확인</button></td>
				</tr>
			</table>
      </form>
    

    </div> <!-- /container -->
</body>
</html>