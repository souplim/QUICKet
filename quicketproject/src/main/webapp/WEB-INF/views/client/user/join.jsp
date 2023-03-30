<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<script type="text/javascript">
  $(function() {
	  
	    let nameReg = /^[가-힣]{2,5}$/ 	// 이름 : 한글 2-5자
		let idReg = /^[A-Za-z0-9]{5,15}$/ // 아이디 : 영문자 숫자 조합 5-15자
		let pwdReg = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,20}$/
		let phoneReg = /^\d{9,11}$/	// 전화번호 : 숫자 9-11자
		
		let idChkClick = 0;
	  
		// 인증번호 전송 버튼 클릭 시
		$("#keySendBtn").click(function(){
			
			let email = $("#email").val() + "@" + $("#email_address").val();
			$("#u_email").val(email);
			
			// 입력값 변수에 담기
			/*$('#u_name').val($('#u_name').val().trim());
			$("#u_id").val($("#u_id").val().trim());
			$("#pwd").val($("#pwd").val().trim());
			$("#u_phone").val($("#u_phone").val().trim());
			
			let name = $('#u_name').val();
			let id = $("#u_id").val();
			let pwd = $("#pwd").val();
			let phone = $("u_phone").val();
			*/
			/*** 정규표현식 
			const nameReg = /^[가-힣]{2,5}$/ 	// 이름 : 한글 2-5자
			const idReg = /^[A-Za-z0-9]{5,15}$/ // 아이디 : 영문자 숫자 조합 5-15자
			const pwdReg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8-20}$/
			const phoneReg = /^\d{9,11}$/	// 전화번호 : 숫자 9-11자
			*****************/
			
			
			$("#keyForm").css("display", "contents");
			
			$.ajax({
				type:"POST",
				url:"/user/mailConfirm",
				data : {
					"email":$("#u_email").val()
				},
				success:function(data){
					alert("해당 이메일로 인증키 발송이 완료되었습니다. \n인증키를 입력해주세요.");
					$("#chkKey").focus();
					chkEmailConfirm(data);
				}
			});
			
		});//
		

		
		// 회원가입 버튼 클릭
		$("#regBtn").click(function(){
			
			console.log("gender : " + $("input[name=u_gender]:checked").val());
			console.log("email : " + $("#u_email").val());
			console.log("birth : " + $("#u_birth").val());
		
			if ($("#keyDiv.has-error").length){
				alert("인증키가 올바르지 않습니다. \n다시 입력해주세요.");
			} else if ($("#nameDiv.has-error").length){
				alert("이름 형식이 올바르지 않습니다.");
			} else if ($("#idDiv.has-error").length){
				alert("아이디 형식이 올바르지 않습니다.");
			} else if ($("#idDiv.has-warning").length){
				alert("중복되는 아이디입니다.");
			} else if ($("#pwdDiv.has-error").length){
				alert("비밀번호 형식이 올바르지 않습니다.");
			} else if ($("#pwdChkDiv.has-error").length){
				alert("비밀번호와 비밀번호 확인을 올바르게 입력해주세요.");
			} else if ($("#keyDiv.has-error").length){
				alert("인증키가 올바르지 않습니다. \n다시 입력해주세요.");
			} else if ($("#id-chk-msg").html() != "아이디 중복확인 완료.") {
				alert("아이디 중복확인을 해주세요.");
			} else if($(".has-feedback.has-success").length) {
				$("#regForm").attr({
					"method" : "post",
					"enctype" : "multipart/form-data",
					"action" : "/user/userJoin"
				});
				$("#regForm").submit();
			} else {
				alert("이메일 본인인증이 필요합니다.");
			}
			
			
		});//
		
		
		$("#emaildomain").change(function(){
			let domain = $("#emaildomain").val();
			$("#email_address").val(domain);
		});//
		
		
		// 이름 확인
		$("#u_name").on("keyup", function(){
			$('#u_name').val($('#u_name').val().trim());
			if(!nameReg.test($('#u_name').val())) {
				$('#nameDiv').removeClass("has-success");
				$("#nameicon").removeClass("glyphicon-ok");
				$('#nameDiv').addClass("has-error");
				$("#nameicon").addClass("glyphicon-remove");
			} else {
				$('#nameDiv').removeClass("has-error");
				$("#nameicon").removeClass("glyphicon-remove");
				$('#nameDiv').addClass("has-success");
				$("#nameicon").addClass("glyphicon-ok");
			}
		});
		
		// 아이디 확인
		$("#idChkBtn").on("click", function(){
			$('#u_id').val($('#u_id').val().trim());
			chkId($("#u_id").val());
		});
		
		$("#u_id").on("keyup", function(){
			if(!idReg.test($('#u_id').val())) {
				$('#idDiv').removeClass("has-success");
				$("#idicon").removeClass("glyphicon-ok");
				$('#idDiv').removeClass("has-warning");
				$("#idicon").removeClass("glyphicon-warning-sign");
				$('#idDiv').addClass("has-error");
				$("#idicon").addClass("glyphicon-remove");
				$("#id-chk-msg").css("display", "block");
				$("#id-chk-msg").html("아이디 형식이 올바르지 않습니다. (한글 2-5자)");
				$("#id-chk-msg").removeClass("alert-warning");
				$("#id-chk-msg").removeClass("alert-success");
				$("#id-chk-msg").addClass("alert-danger");
			} else {
				$('#idDiv').removeClass("has-error");
				$("#idicon").removeClass("glyphicon-remove");
				$('#idDiv').removeClass("has-warning");
				$("#idicon").removeClass("glyphicon-warning-sign");
				$('#idDiv').addClass("has-success");
				$("#idicon").addClass("glyphicon-ok");
				$("#id-chk-msg").css("display", "none");
				$("#idChkBtn").focus();
			}
		});
		
		// 비밀번호
		$("#pwd").on("keyup", function(){
			$('#pwd').val($('#pwd').val().trim());
			if(!pwdReg.test($('#pwd').val())) {
				$('#pwdDiv').removeClass("has-success");
				$("#pwdicon").removeClass("glyphicon-ok");
				$('#pwdDiv').addClass("has-error");
				$("#pwdicon").addClass("glyphicon-remove");
			} else {
				$('#pwdDiv').removeClass("has-error");
				$("#pwdicon").removeClass("glyphicon-remove");
				$('#pwdDiv').addClass("has-success");
				$("#pwdicon").addClass("glyphicon-ok");
			}
		});
		
		// 비밀번호 확인 
		$("#u_pwd").on("keyup", function(){
			$('#u_pwd').val($('#u_pwd').val().trim());
			if($('#u_pwd').val() != $('#pwd').val()) {
				$('#pwdChkDiv').removeClass("has-success");
				$("#pwdChkicon").removeClass("glyphicon-ok");
				$('#pwdChkDiv').addClass("has-error");
				$("#pwdChkicon").addClass("glyphicon-remove");
			} else {
				$('#pwdChkDiv').removeClass("has-error");
				$("#pwdChkicon").removeClass("glyphicon-remove");
				$('#pwdChkDiv').addClass("has-success");
				$("#pwdChkicon").addClass("glyphicon-ok");
			}
		});
		
		
  });
  
  function chkEmailConfirm(data) {
	  $("#chkKey").on("keyup",function(){
		  if(data != $("#chkKey").val() ) {
			 	$('#keyDiv').removeClass("has-success");
				$("#keyicon").removeClass("glyphicon-ok");
				$('#keyDiv').addClass("has-error");
				$("#keyicon").addClass("glyphicon-remove");
			} else {
				$('#keyDiv').removeClass("has-error");
				$("#keyicon").removeClass("glyphicon-remove");
				$('#keyDiv').addClass("has-success");
				$("#keyicon").addClass("glyphicon-ok");
			} 
	  });
  }
  
  function chkId(id){
	  $.ajax({
			type:"POST",
			url:"/user/idCheck",
			data : {
				"u_id":id
			},
			success:function(data){
				console.log(data);
				if(data == 1) {
					$("#id-chk-msg").css("display", "block");
					$("#id-chk-msg").html("중복되는 아이디입니다.");
					$("#id-chk-msg").removeClass("alert-danger");
					$("#id-chk-msg").removeClass("alert-success");
					$("#id-chk-msg").addClass("alert-warning");
					$('#idDiv').removeClass("has-error");
					$("#idicon").removeClass("glyphicon-remove");
					$('#idDiv').removeClass("has-success");
					$("#idicon").removeClass("glyphicon-ok");
					$('#idDiv').addClass("has-warning");
					$("#idicon").addClass("glyphicon-warning-sign");
				} else {
					$("#id-chk-msg").css("display", "block");
					$("#id-chk-msg").html("아이디 중복확인 완료.");
					$("#id-chk-msg").removeClass("alert-danger");
					$("#id-chk-msg").removeClass("alert-warning");
					$("#id-chk-msg").addClass("alert-success");
					$('#idDiv').removeClass("has-error");
					$("#idicon").removeClass("glyphicon-remove");
					$('#idDiv').removeClass("has-warning");
					$("#idicon").removeClass("glyphicon-warning-sign");
					$('#idDiv').addClass("has-success");
					$("#idicon").addClass("glyphicon-ok");
				}
			}
		});
  }
 
  
 </script>
  
  <style>
  	#keyForm{display:none;}
  	#id-chk-msg{display:none};
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
						<td colspan="4">
							<div id="nameDiv" class="has-feedback">
							<input type="text" class="form-control" id="u_name" name="u_name" placeholder="이름을 입력해주세요."/>
							<span id="nameicon" class="glyphicon form-control-feedback" aria-hidden="true"></span>
							</div>
						</td>
					</tr>
					<tr class="form-group">
						<td class="text-center">아이디</td>
						<td colspan="3">
						<div id="idDiv" class="has-feedback">
							<input type="text" class="form-control" id="u_id" name="u_id" placeholder="아이디를 입력해주세요. (영문자 + 숫자 조합, 5-15자)"/>
							<span id="idicon" class="glyphicon form-control-feedback" aria-hidden="true"></span>
						</div>
						</td>
						<td><button type="button" id="idChkBtn" class="btn btn-default">중복 확인</button></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="4"><div id="id-chk-msg" class="alert"></div></td>
					</tr>
					<tr class="form-group">
						<td class="text-center">비밀번호</td>
						<td colspan="4">
						<div id="pwdDiv" class="has-feedback">
							<input type="password" class="form-control" id="pwd" name="pwd" placeholder="비밀번호를 입력해주세요. (영문자 + 숫자 조합, 대문자 포함 8-20자)"/>
							<span id="pwdicon" class="glyphicon form-control-feedback" aria-hidden="true"></span>
						</div>	
						</td>
					</tr>
					<tr class="form-group">
						<td class="text-center">비밀번호 확인</td>
						<td colspan="4">
						<div id="pwdChkDiv" class="has-feedback">
							<input type="password" class="form-control" id="u_pwd" name="u_pwd" placeholder="비밀번호를 한번 더 입력해주세요."/>
							<span id="pwdChkicon" class="glyphicon form-control-feedback" aria-hidden="true"></span>
						</div>
						</td>
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
							<button type="button" class="btn btn-default" id="keySendBtn">인증키 전송</button>
						</td>
					</tr>
					<tr id="keyForm"  class="form-group">
						<td></td>
						<td colspan="3">
						<div id="keyDiv" class="has-feedback">
							<input type="text" id="chkKey" name="chkKey" class="form-control" placeholder="인증키를 입력해주세요.">
							<span id="keyicon" class="glyphicon form-control-feedback" aria-hidden="true"></span>
						</div>
						</td>
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