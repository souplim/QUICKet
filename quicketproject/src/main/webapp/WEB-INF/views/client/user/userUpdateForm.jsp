<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

<title>회원 정보</title>

<script>
	
	//$(function(){ 시작
	$(function(){
		
		let emailKey = "";
		
		// 이메일과 도메인 분리
		let emailStr = $("#u_email").val();
		let emails = emailStr.split('@');
		
		console.log(emailStr);
		console.log(emails[0]);
		console.log(emails[1]);
		
		$("#email").val(emails[0]);
		$("#email_address").val(emails[1]);
		$("#emaildomain").val(emails[1]).prop("selected", true);
		
		// 이메일 변경 여부
		let emailChk = 0; // 변경 X -> 0, 변경 O -> 1
		
		// 이메일 입력 값이 변경되었다면 인증번호 전송 버튼 보이게
		$("#email").on("keyup",function(){
			if($("#email").val() != emails[0]) {
				$("#btnArea").css("display", "contents");
				emailChk = 1;
			} else {
				$("#btnArea").css("display", "none");
				emailChk = 0;
			}
		}); //------------------------------------
		
		// 이메일 도메인 값 변경
		$("#emaildomain").on("change",function(){
			if($("#emaildomain").val() != emails[1]) {
				$("#btnArea").css("display", "contents");
				emailChk = 1;
			} else if ($("#emaildomain").val() == "") {
				alert("이메일 도메인을 입력해주세요.");
				$("#btnArea").css("display", "none");
				emailChk = 0;
			}else {
				$("#btnArea").css("display", "none");
				emailChk = 0;
			}
		}); //------------------------------------------
		
		// 인증번호 전송 버튼 클릭 시
		$("#keySendBtn").click(function(){
			
			$("#u_email").val("");
			let email = $("#email").val() + "@" + $("#email_address").val();
			$("#u_email").val(email);
			console.log("u_email => " + $("#u_email").val());
			

			
			$("#keyForm").css("display", "contents");
			
			$.ajax({
				type:"POST",
				url:"/user/mailConfirm",
				data : {
					"email":$("#u_email").val()
				},
				success:function(data){
					alert("해당 이메일로 인증번호 발송이 완료되었습니다. \n인증번호를 입력해주세요.");
					$("#chkKey").focus();
					console.log(data);
				  	emailKey = data;
				  	console.log("emailKey -> " + emailKey);
				}// ----success-----------
			
			});//---------ajax------------
		});// ------------ 인증키 전송 버튼 클릭 이벤트 종료 ---------------
		
		$("#chkKey").on("keyup",function(){	//인증키 확인
	  		if ($("#chkKey").val() == emailKey) {
				$('#chkDiv').removeClass("has-error");
				$("#chkicon").removeClass("glyphicon-remove");
				$('#chkDiv').addClass("has-success");
				$("#chkicon").addClass("glyphicon-ok");
	  		} else if ( $("#chkKey").val() == "" ) {
			 	$('#chkDiv').removeClass("has-success");
				$("#chkicon").removeClass("glyphicon-ok");
				$('#chkDiv').removeClass("has-error");
				$("#chkicon").removeClass("glyphicon-remove");
			} else if ($("#chkKey").val() != emailKey || $("#chkKey").val() != "") {
				$('#chkDiv').removeClass("has-success");
				$("#chkicon").removeClass("glyphicon-ok");
				$('#chkDiv').addClass("has-error");
				$("#chkicon").addClass("glyphicon-remove");
			} 
		}); // 인증키 확인
		
		// 비밀번호 변경 버튼
		$("#updatePwdBtn").click(function(){
			location.href="/user/setPwdForm";
		});//----------------------
		

		
		// 수정 버튼 클릭
		$("#updateBtn").click(function(){
			
			// 수정 버튼 클릭 시 
			if(emailChk == 0 && $("#u_phone").val() == ${userLogin.u_phone}) {	// 변경된 값이 없다면
				location.href="/user/userInfo";
			} else if (emailChk == 1 && $("#chkKey").val() == "") {	// 이메일 인증이 안됐다면
				alert("이메일 인증키를 입력해주세요.");
				$("#chkKey").focus();
			} else if ($("#chkDiv.has-error").length) {	// 이메일 인증이 안됐다면
				alert("이메일 인증이 필요합니다.");
				$("#chkKey").focus();
			}else {
			
				$("#userUpdateForm").attr({
					"method" : "post",
					"enctype" : "multipart/form-data",
					"action" : "/user/userUpdate"
				});
				$("#userUpdateForm").submit();
			}
			
			
		});//------------수정버튼클릭이벤트종료
		
		
		// 이메일 도메인 option 변경되면 input 값도 같게 변경
		$("#emaildomain").change(function(){
			let domain = $("#emaildomain").val();
			$("#email_address").val(domain);
		});//-------------------------------------
		
		
		// 탈퇴 버튼 클릭 시
		$("#userDelBtn").click(function(){
			alert("탈퇴를 위해 비밀번호를 입력해주세요.");
			$("#pwdChkArea").css("visibility", "visible");
			$("#DelChk").focus();
		});//---------------------------
		
		//------------탈퇴 -> 비밀번호 확인
		$("#DelChkBtn").click(function(){
			if($("#DelChk").val() == "${userInfo.u_pwd}") {
				location.href="/user/userDelete";
			} else if ($("#DelChk").val() == "") {
				alert("비밀번호 확인을 입력해주세요.");
				$("#DelChk").focus();
			} else if ($("#DelChk").val() != "${userLogin.u_pwd}") {
				alert("비밀번호 확인이 틀렸습니다. 다시 입력해주세요.");
				$("#DelChk").val("");
				$("#DelChk").focus();
			}
		});//----------------------------------
		
  });//$(function() 종료)
  


 
</script>

<style>
  	#keyForm{display:none;}
  	#btnArea{display:none;}
  	#pwdChkArea{visibility:hidden;}
</style>
  
		
</head>
<body>
	회원 정보 수정
	<div class="container">
<form id="userUpdateForm" name="userUpdateForm">
	<input type="hidden" id="u_num" name="u_num" value="${userLogin.u_num}"/>
	<table class="table">
		<tr class="form-group">
			<td>이름</td>
			<td colspan="5">${userLogin.u_name}</td>
		</tr>
		<tr class="form-group">
			<td>아이디</td>
			<td colspan="5">${userLogin.u_id}</td>
		</tr>
		<tr class="form-group">
			<td>비밀번호</td>
			<td colspan="3" class="">마지막 비밀번호 변경일 : ${userLogin.u_pwddate}</td>
			<td></td>
			<td class="text-right"><button type="button" class="btn btn-warning " id="updatePwdBtn">비밀번호 변경</button></td>
		</tr>
		<tr class="form-group">
			<td>성별</td>
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
			<td colspan="2"></td>
			<td class="text-center">생년월일</td>
			<td>${userLogin.u_birth }</td>
		</tr>
		<tr class="form-group">
						<td>이메일</td>
						<td colspan="2"><input type="text" id="email" class="form-control" required></td>
						<td colspan="2"> <div class="input-group"><span class="input-group-addon">@</span><input type="text" id="email_address" class="form-control" required></div></td>
						<td>
							<select name="emaildomain" id="emaildomain" class="form-control">
						        <option value="">직접입력</option>
						        <option value="naver.com">naver.com</option>
						        <option value="gmail.com">gmail.com</option>
						        <option value="daum.net">daum.net</option>
						        <option value="hanmail.net">hanmail.net</option>
						        <option value="nate.com">nate.com</option>
						    </select>
							<input type="hidden" id="u_email" name="u_email" value="${userLogin.u_email}" required>
						</td>
						<td>
							<div id="btnArea"><button type="button" id="keySendBtn">인증번호 전송</button></div>
						</td>
					</tr>
					<tr id="keyForm"  class="form-group">
						<td></td>
						<td colspan="5">
						<div id="chkDiv" class="has-feedback">
							<input type="text" id="chkKey" name="chkKey" class="form-control" placeholder="인증번호를 입력해주세요.">
							<span id="chkicon" class="glyphicon form-control-feedback" aria-hidden="true"></span>
						</div>
						</td>
					</tr>
		<tr class="form-group">
			<td>전화번호</td>
			<td colspan="5"><input type="text" class="form-control" id="u_phone" name="u_phone" placeholder="전화번호를 입력해주세요. (- 제외)" value="${userLogin.u_phone}"/></td>
		</tr>
		<tr class="form-group">
			<td colspan="2"></td>
			<td colspan="3" class="form-inline text-right" id="pwdChkArea"><label>비밀번호 확인</label><input type="password" id="DelChk" name="DelChk" class="form-control"/><button type="button" id="DelChkBtn" class="btn btn-default">확인</button></td>
			<td class="text-right"><button type="button" class="btn btn-warning btn-block" id="userDelBtn">회원 탈퇴</button></td>
		</tr>
		<tr class="form-group">
			<td colspan="3" class="text-center"><button type="button" id="cancelBtn" class="btn btn-danger btn-block">취소</button></td>
			<td colspan="3" class="text-center"><button type="button" id="updateBtn" class="btn btn-danger btn-block">수정</button></td>
		</tr>
	</table>
</form>
</div>
</body>
</html>