<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

<title>회원 정보</title>

<script>
	
	$(function(){
		
		
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
		});
		
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
		});
		
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
					chkEmailConfirm(data);
				}
			});
			
		});//
		
		
		// 비밀번호 변경 버튼
		$("#updatePwdBtn").click(function(){
			location.href="/user/setPwdForm?u_num=" + $("#u_num").val();
		});
		

		
		// 수정 버튼 클릭
		$("#updateBtn").click(function(){
			
			// 이메일 도메인 값과 합치기
			/*
			let email = $("#email").val() + "@" + $("#email_address").val();
			$("#u_email").val(email);
			*/
			
			console.log("gender : " + $("input[name=u_gender]:checked").val());
			console.log("email : " + $("#u_email").val());
			console.log("birth : " + $("#u_birth").val());
			// 입력값 유효 체크
			/*
			if(!chkData("#u_name","이름을")) return;
			else if (!chkData("#u_id","아이디를")) return;
			else if (!chkData("#u_pwd","비밀번호를")) return;
			else if (!chkData("#u_pwdChk","비밀번호 확인을")) return;
			else if (!chkData("#u_gender","성별을")) return;
			else if (!chkData("#u_birth","생년월일을")) return;
			else if (!chkData("#email","이메일을")) return;
			else if (!chkData("#email_address","이메일 도메인을")) return;
			else if (!chkData("#chkKey","이메일 본인 인증번호를")) return;
			else if (!chkData("#u_phone","전화번호를")) return;*/
			
			// 회원가입 폼 전송
			if(emailChk == 0 || $("#emailConfirmChk").html() == "인증번호가 확인되었습니다.") {
				$("#userUpdateForm").attr({
					"method" : "post",
					"enctype" : "multipart/form-data",
					"action" : "/user/userUpdate"
				});
				$("#userUpdateForm").submit();
			} else {
				alert("이메일을 인증해주세요.");
			}
			
			
		});//
		
		
		$("#emaildomain").change(function(){
			let domain = $("#emaildomain").val();
			$("#email_address").val(domain);
		});//
		
		
		// 탈퇴 버튼 클릭 시
		$("#userDelBtn").click(function(){
			alert("탈퇴를 위해 비밀번호를 입력해주세요.");
			$("#pwdChkArea").css("visibility", "visible");
			$("#DelChk").focus();
		});
		
		$("#DelChkBtn").click(function(){
			if($("#DelChk").val() == "${userInfo.u_pwd}") {
				location.href="/user/userDelete?u_num="+${userInfo.u_num};
			} else if ($("#DelChk").val() == "") {
				alert("비밀번호 확인을 입력해주세요.");
				$("#DelChk").focus();
			} else if ($("#DelChk").val() != "${userInfo.u_pwd}") {
				alert("비밀번호 확인이 틀렸습니다. 다시 입력해주세요.");
				$("#DelChk").val("");
				$("#DelChk").focus();
			}
		});
		
  });
  
  function chkEmailConfirm(data) {
	  $("#chkKey").on("keyup",function(){
		  if(data != $("#chkKey").val() ) {
				$("#emailConfirmChk").html("인증번호가 잘못되었습니다.");
			} else {
				$("#emailConfirmChk").html("인증번호가 확인되었습니다.");
			} 
	  });
  }
 
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
	<input type="hidden" id="u_num" name="u_num" value="${userInfo.u_num}"/>
	<table class="table">
		<tr class="form-group">
			<td>이름</td>
			<td colspan="4">${userInfo.u_name}</td>
		</tr>
		<tr class="form-group">
			<td>아이디</td>
			<td colspan="4">${userInfo.u_id}</td>
		</tr>
		<tr class="form-group">
			<td>비밀번호</td>
			<td><button type="button" class="btn btn-warning" id="updatePwdBtn">비밀번호 변경</button></td>
			<td colspan="3">마지막 비밀번호 변경일 : ${userInfo.u_pwddate}</td>
		</tr>
		<tr class="form-group">
			<td>성별</td>
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
			<td></td>
			<td>생년월일</td>
			<td>${userInfo.u_birth }</td>
		</tr>
		<tr class="form-group">
						<td>이메일</td>
						<td colspan="2"><input type="text" id="email" class="form-control" required></td>
						<td> <div class="input-group"><span class="input-group-addon">@</span><input type="text" id="email_address" class="form-control" required></div></td>
						<td>
							<select name="emaildomain" id="emaildomain" class="form-control">
						        <option value="">직접입력</option>
						        <option value="naver.com">naver.com</option>
						        <option value="gmail.com">gmail.com</option>
						        <option value="daum.net">daum.net</option>
						        <option value="hanmail.net">hanmail.net</option>
						        <option value="nate.com">nate.com</option>
						    </select>
							<input type="hidden" id="u_email" name="u_email" value="${userInfo.u_email}" required>
						</td>
						<td>
							<div id="btnArea"><button type="button" id="keySendBtn">인증번호 전송</button></div>
						</td>
					</tr>
					<tr id="keyForm"  class="form-group">
						<td></td>
						<td colspan="3"><input type="text" id="chkKey" name="chkKey" class="form-control" placeholder="인증번호를 입력해주세요."></td>
						<td><div id="emailConfirmChk"></div></td>
					</tr>
		<tr class="form-group">
			<td>전화번호</td>
			<td colspan="4"><input type="text" class="form-control" id="u_phone" name="u_phone" placeholder="전화번호를 입력해주세요. (- 제외)" value="${userInfo.u_phone}"/></td>
		</tr>
		<tr class="form-group">
			<td colspan="2"></td>
			<td colspan="2" class="form-group" id="pwdChkArea"><label>비밀번호 확인</label><input type="password" id="DelChk" name="DelChk"/><button type="button" id="DelChkBtn">확인</button></td>
			<td class="text-right"><button type="button" class="btn btn-warning" id="userDelBtn">회원 탈퇴</button></td>
		</tr>
		<tr class="form-group">
			<td colspan="2" class="text-center"><button type="button" id="cancelBtn" class="btn btn-danger">취소</button></td>
			<td></td>
			<td colspan="2" class="text-center"><button type="button" id="updateBtn" class="btn btn-danger">수정</button></td>
		</tr>
	</table>
</form>
</div>
</body>
</html>