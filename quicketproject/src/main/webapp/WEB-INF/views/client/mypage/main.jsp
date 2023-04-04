<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

<style>
	.row { display: flex; justify-content: center;}
	.mypageDiv {
		border: 2px solid black;
		border-radius: 20px;
		width : 25%;
		height : 200px;
		margin : 20px;
		cursor: pointer;
	}
</style>

<script>

	$(function(){
		
		let click = "";
		
		$(".mypageDiv").click(function(){
			click = $(this).attr('id');
			console.log(click);
		});
		
		$("#okBtn").click(function(){
			$.ajax({
				type:"POST",
				url:"/user/pwdConfirm",
				data:{
					"u_id" : $("#u_id").val(), "u_pwd" : $("#u_pwd").val()
				},
				success:function(data){
					if(data == 1) {
						console.log("클릭한 버튼 : " + click);
						if(click == "userInfoBtn"){
							location.href="/user/userInfo";
						} else if (click == "userUpdateBtn") {
							location.href="/user/userUpdateForm";
						} else if (click == "setPwdBtn") {
							location.href="/user/setPwdForm";
						}
					} else {
						alert("비밀번호가 일치하지 않습니다.");
						$("#u_pwd").focus();
					}
				}
			});
		});
		
	});
	
</script>
</head>
<body>
	
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="closeBtn"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">비밀번호 확인</h4>
      </div>
      <div class="modal-body text-center">
      	<h1></h1>
		<h1 class="glyphicon glyphicon-lock text-center"></h1>
		<br>
		<h3>정보를 안전하게 보호하기 위해<br>비밀번호를 다시 한 번 확인합니다.</h3>
		<br>
		<h5>비밀번호가 타인에게 노출되지 않게 항상 주의하세요.</h5>
		<br><br><br>
		<form id="pwdForm" name="pwdForm">
		
		<table class="table">
			<tr>
				<td class="text-center">아이디</td>
				<td class="text-left" colspan="4"><input type="text" readonly="readonly" id="u_id" name="u_id" value="${userLogin.u_id}"/></td>
			</tr>
			<tr>
				<td class="text-center">비밀번호</td>
				<td colspan="3">		
				<input type="password" class="form-control" id="u_pwd" name="u_pwd" placeholder="비밀번호를 입력해주세요."/>
				</td>
			</tr>
		</table>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" id="closeBtn" data-dismiss="modal" aria-label="Close">닫기</button>
        <button type="button" class="btn btn-primary" id="okBtn">확인</button>
      </div>
      
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->




	<div class="container text-center">
	<br>
        <h4 class="text-center">마이페이지</h4>
        <br><br>
    	<h3 class="text-center">${userLogin.u_name} 님</h3>
    	<br>
    	<div class="text-center">
    		<p>가입 날짜 : ${userLogin.u_regdate}</p>
    		<p>최근 정보 변경일 : ${userLogin.u_moddate}</p>
    	</div>
    	<div class="row" >
	        <div class="mypageDiv" id="userInfoBtn" data-toggle="modal" data-target="#myModal">
	        	<br>
	        	<h1 class="glyphicon glyphicon-user" aria-hidden="true"></h1>
	        	<br><br>
	          	<h3>회원정보 조회</h3>
	        </div><!-- /.col-lg-4 -->
	         <div class="mypageDiv" id="userUpdateBtn" data-toggle="modal" data-target="#myModal">
	       		<br>
	        	<h1 class="glyphicon glyphicon-pencil" aria-hidden="true"></h1>
	          	<br><br>
	          	<h3>회원정보 수정</h3>
	        </div><!-- /.col-lg-4 -->
	       <div class="mypageDiv" id="setPwdBtn" data-toggle="modal" data-target="#myModal">
	       		<br>
	        	<h1 class="glyphicon glyphicon-lock" aria-hidden="true"></h1>
	          	<br><br>
	          	<h3>비밀번호 변경</h3>
	        </div><!-- /.col-lg-4 -->
      	</div><!-- /.row -->
    </div>
    
</body>
</html>