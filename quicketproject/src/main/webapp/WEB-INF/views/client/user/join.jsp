<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<script type="text/javascript">
  $(function() {
	  
	  
		// 인증번호 전송 버튼 클릭 시
		$("#keySendBtn").click(function(){
			
			let email = $("#email").val() + "@" + $("#email_address").val();
			$("#u_email").val(email);
			

			
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
		

		
		// 회원가입 버튼 클릭
		$("#regBtn").click(function(){
			
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
			if($("#emailConfirmChk").html() == "인증번호가 확인되었습니다.") {
				$("#regForm").attr({
					"method" : "post",
					"enctype" : "multipart/form-data",
					"action" : "/user/userJoin"
				});
				$("#regForm").submit();
			} else {
				alert("이메일을 인증해주세요.");
			}
			
			
		});//
		
		
		$("#emaildomain").change(function(){
			let domain = $("#emaildomain").val();
			$("#email_address").val(domain);
		});//
		
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
  </style>
  
<title>회원가입</title>

</head>
<body>
	
	<section class="bg-light">
		<div class="container">
			<div class="row align-items-center justify-content-between">
				<h4>회원 가입</h4>
			</div>
			<form id="regForm">
			
				<table class="table">
					<tr class="form-group"> 
						<td class="text-center">이름</td>
						<td colspan="4"><input type="text" class="form-control" id="u_name" name="u_name" placeholder="이름을 입력해주세요." required/></td>
					</tr>
					<tr class="form-group">
						<td class="text-center">아이디</td>
						<td colspan="3"><input type="text" class="form-control" id="u_id" name="u_id" placeholder="아이디를 입력해주세요. (영문자 + 숫자 조합, 5-15자)" required/></td>
						<td><button type="button" id="idChkBtn" class="btn btn-default">중복 확인</button></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="4"><div class="id-chk-msg"></div></td>
					</tr>
					<tr class="form-group">
						<td class="text-center">비밀번호</td>
						<td colspan="4"><input type="password" class="form-control" id="u_pwd" name="u_pwd" placeholder="비밀번호를 입력해주세요. (영문자 + 숫자 조합, 대문자 포함 8-20자)" required/></td>
					</tr>
					<tr class="form-group">
						<td class="text-center">비밀번호 확인</td>
						<td colspan="4"><input type="password" class="form-control" id="u_pwdChk" name="u_pwdChk" placeholder="비밀번호를 한번 더 입력해주세요." required /></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="4"><div class="pwd-chk-msg"></div></td>
					</tr>
					<tr class="form-group">
						<td class="text-center">성별</td>
						<td>
							<input id="M" type="radio" value="M" name="u_gender">
							<label for="M" class="" >남성</label>
							&nbsp;&nbsp;
							<input id="F" type="radio" checked value="F" name="u_gender">
							<label for="F" class="">여성</label>
						</td>
						<td></td>
						<td class="text-center">생년월일</td>
						<td><input  class="form-control" type="date" name="u_birth" id="u_birth" value="2000-01-01" required></td>
					</tr>
					<tr class="form-group">
						<td class="text-center">이메일</td>
						<td colspan="2"><input type="text" id="email" class="form-control" required></td>
						<td><div class="input-group"><span class="input-group-addon">@</span><input type="text" id="email_address" class="form-control" required></div></td>
						<td>
							<select name="emaildomain" id="emaildomain" class="form-control" >
						        <option value="">직접입력</option>
						        <option value="naver.com">naver.com</option>
						        <option value="gmail.com">gmail.com</option>
						        <option value="daum.net">daum.net</option>
						        <option value="hanmail.net">hanmail.net</option>
						        <option value="nate.com">nate.com</option>
						    </select>
							<input type="hidden" id="u_email" name="u_email" value="" required>
						</td>
						<td>
							<button type="button" class="btn btn-default" id="keySendBtn">인증번호 전송</button>
						</td>
					</tr>
					<tr id="keyForm"  class="form-group">
						<td></td>
						<td colspan="3"><input type="text" id="chkKey" name="chkKey" class="form-control" placeholder="인증번호를 입력해주세요."></td>
						<td><div id="emailConfirmChk"></div></td>
					</tr>
					<tr class="form-group">
						<td class="text-center">전화번호</td>
						<td colspan="4"><input type="text" id="u_phone" name="u_phone" class="form-control" placeholder="전화번호를 입력해주세요. (- 제외)" required></td>
					</tr>
					<tr>
						<td colspan="5"><button type="button" id="regBtn" class="btn">회원 가입</button></td>
					</tr>
				</table>				
				
			</form>
		</div>
	
	</section>
	
</body>
</html>