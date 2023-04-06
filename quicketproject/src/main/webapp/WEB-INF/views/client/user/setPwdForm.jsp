<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<title>비밀번호 수정 </title>

<script>

	let pwdReg = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,20}$/


	$(function(){
		let errorMsg = "${errorMsg}";
		if(errorMsg!="") {
			alert(errorMsg);
			errorMsg = "";
		}
		
		// 비밀번호 변경 확인 버튼 클릭 시
		$("#pwdUpdateBtn").click(function(){
			
			if(!chkData("#oldPwd","기존 비밀번호를")) return;
			if(!chkData("#newPwd", "새 비밀번호를")) return;
			if(!chkData("#u_pwd", "비밀번호 확인을")) return;
			if($("#oldDiv.has-error").length) {
				alert("기존 비밀번호가 틀렸습니다.");
			} else if ($("#newDiv.has-warning").length){
				alert("기존 비밀번호와 새 비밀번호가 동일합니다. \n다르게 입력해주세요.");
			} else if ($("#newDiv.has-error").length){
				alert("새 비밀번호 형식이 올바르지 않습니다.");
			} else if ($("#chkDiv.has-error").length){
				alert("비밀번호 확인을 올바르게 입력해주세요.");
			} else {
				$("#pwdForm").attr({
					"method" : "post",
					"enctype" : "multipart/form-data",
					"action" : "/user/setNewPwd"
				});
				$("#pwdForm").submit();
			}
				
			
		});
		$("#oldPwd").on("keyup",function(){
			$("#oldPwd").val($("#oldPwd").val().trim());
			if($("#oldPwd").val() == $("#password").val()) {
				$('#oldDiv').removeClass("has-error");
				$("#oldicon").removeClass("glyphicon-remove");
				$('#oldDiv').addClass("has-success");
				$("#oldicon").addClass("glyphicon-ok");
			} else if ($("#oldPwd").val() != $("#password").val() && $("#oldPwd").val() != "") {
				$('#oldDiv').removeClass("has-success");
				$("#oldicon").removeClass("glyphicon-ok");
				$('#oldDiv').addClass("has-error");
				$("#oldicon").addClass("glyphicon-remove");
			} else if ($("#oldPwd").val() == "") {
				$('#oldDiv').removeClass("has-success");
				$("#oldicon").removeClass("glyphicon-ok");
				$('#oldDiv').removeClass("has-error");
				$("#oldicon").removeClass("glyphicon-remove")
			}
		});
		
		
		// 비밀번호
		$("#newPwd").on("keyup", function(){
			$('#newPwd').val($('#newPwd').val().trim());
			if(!pwdReg.test($('#newPwd').val()) && $("#newPwd").val() != "") {
				$('#newDiv').removeClass("has-success");
				$("#newicon").removeClass("glyphicon-ok");
				$('#newDiv').removeClass("has-warning");
				$("#newicon").removeClass("glyphicon-warning-sign");
				$('#newDiv').addClass("has-error");
				$("#newicon").addClass("glyphicon-remove");
			} else if ($("#newPwd").val() == "") {
				$('#newDiv').removeClass("has-success");
				$("#newicon").removeClass("glyphicon-ok");
				$('#newDiv').removeClass("has-warning");
				$("#newicon").removeClass("glyphicon-warning-sign");
				$('#newDiv').removeClass("has-error");
				$("#newicon").removeClass("glyphicon-remove")
			} else if ($("#newPwd").val() == $("#password").val()) {
				$('#newDiv').removeClass("has-success");
				$("#newicon").removeClass("glyphicon-ok");
				$('#newDiv').removeClass("has-error");
				$("#newicon").removeClass("glyphicon-remove");	
				$('#newDiv').addClass("has-warning");
				$("#newicon").addClass("glyphicon-warning-sign");
			} else {
				$('#newDiv').removeClass("has-error");
				$("#newicon").removeClass("glyphicon-remove");
				$('#newDiv').removeClass("has-warning");
				$("#newicon").removeClass("glyphicon-warning-sign");
				$('#newDiv').addClass("has-success");
				$("#newicon").addClass("glyphicon-ok");
			}
		});
		
		// 비밀번호 확인 
		$("#u_pwd").on("keyup", function(){
			$('#u_pwd').val($('#u_pwd').val().trim());
			if($('#u_pwd').val() != $('#newPwd').val()) {
				$('#chkDiv').removeClass("has-success");
				$("#chkicon").removeClass("glyphicon-ok");
				$('#chkDiv').addClass("has-error");
				$("#chkicon").addClass("glyphicon-remove");
			} else if ($("#u_pwd").val() == "") {
				$('#chkDiv').removeClass("has-success");
				$("#chkicon").removeClass("glyphicon-ok");
				$('#chkDiv').removeClass("has-error");
				$("#chkicon").removeClass("glyphicon-remove")
			}  else {
				$('#chkDiv').removeClass("has-error");
				$("#chkicon").removeClass("glyphicon-remove");
				$('#chkDiv').addClass("has-success");
				$("#chkicon").addClass("glyphicon-ok");
			}
		});
		
		// 취소 버튼 클릭
		$("#cancelBtn").click(function(){
			history.back();
		});
		
	});

</script>

<style>
	.table>tbody>tr>td {border:none;}
	#cancelBtn{width : 100%;}
  	#pwdUpdateBtn{width : 100%;}
	#pwdForm {
  	margin-top : 50px;
    border: 1px solid darkgray;
    border-radius: 20px;
    padding: 20px;
  	}
</style>
</head>
<body>

    <div class="container">

      <form class="form-signin" id="pwdForm">
      <input type="hidden" id="u_num" name="u_num" value="${userLogin.u_num}"/>
      <input type="hidden" id="u_id" name="u_id" value="${userLogin.u_id}"/>
      <input type="hidden" id="u_pwddate" name="u_pwddate" value="${userLogin.u_pwddate}"/> 	
      <input type="hidden" id="password" value="${userLogin.u_pwd}"/>
        	<h3 class="text-center">비밀번호 변경</h3>
        	<table class="table" id="table">
        		<colgroup>
				<col width="20%">
				<col width="30%">
				<col width="20%">
				<col width="30%">
				</colgroup>
				<tr>
					<td class="text-center">이름</td>
					<td colspan="3">${userLogin.u_name}</td>
				</tr>
				<tr>
					<td class="text-center">아이디</td>
					<td colspan="3">${userLogin.u_id}</td>
				</tr>
				<tr>
					<td class="text-center">기존 비밀번호</td>
					<td colspan="3">
					<div id="oldDiv" class="form-group has-feedback">
					<input type="password" class="form-control" id="oldPwd" name="oldPwd"/>
					<span id="oldicon" class="glyphicon form-control-feedback" aria-hidden="true"></span>
					</div>
					</td>
				</tr>
				<tr>
					<td class="text-center">새 비밀번호</td>
					<td colspan="3">
					<div id="newDiv" class="form-group has-feedback">
					<input type="password" class="form-control" id="newPwd" name="newPwd" placeholder="영문자(대문자 포함), 숫자 조합 8-20자"/>
					<span id="newicon" class="glyphicon form-control-feedback" aria-hidden="true"></span>
					</div>
					</td>
				</tr>
				<tr>
					<td class="text-center">새 비밀번호 확인</td>
					<td colspan="3">
					<div id="chkDiv" class="form-group has-feedback">
					<input type="password" class="form-control" id="u_pwd" name="u_pwd" placeholder="새 비밀번호를 한 번 더 입력해주세요."/>
					<span id="chkicon" class="glyphicon form-control-feedback" aria-hidden="true"></span>
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
					<td colspan="3">${userLogin.u_email}</td>
				</tr>
				<tr>
					<td class="text-center">전화번호</td>
					<td colspan="3">${userLogin.u_phone}</td>
				</tr>
				<tr><td></td><td></td></tr>
				<tr class="text-center">
					<td colspan="2"><button type="button" class="w-btn-outline w-btn-indigo-outline btn" id="cancelBtn">취소</button></td>
					<td colspan="2"><button type="button" class="w-btn-outline w-btn-indigo-outline btn" id="pwdUpdateBtn">확인</button></td>
				</tr>
			</table>
      </form>
    

    </div> <!-- /container -->
</body>
</html>