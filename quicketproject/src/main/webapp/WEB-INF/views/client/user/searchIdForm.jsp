<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

<title>아이디 / 비밀번호 찾기</title>

<script>

	$(function(){/////////////////
		let click = 0;
		
		// 전화번호로 찾기 입력값이 입력되어있는 상태라면 확인 버튼에 
		// data-toggle="modal" data-target="#myModal" 속성 추가
		$(".p-input").keyup(function(){
			$('#p-name').val($('#p-name').val().trim());
			$('#p-phone').val($('#p-phone').val().trim());
			if($("#p-name").val() != "" && $("#p-phone").val() != "") {
				$("#idPhoneBtn").attr("data-toggle", "modal");
				$("#idPhoneBtn").attr("data-target", "#myModal");
			}
		});
		
		// 이메일로 찾기 입력값이 입력되어있는 상태라면 확인 버튼에 
		// data-toggle="modal" data-target="#myModal" 속성 추가
		$(".e-input").keyup(function(){
			$('#e-name').val($('#e-name').val().trim());
			$('#e-email').val($('#e-email').val().trim());
			$('#emailaddress').val($("#emailaddress").val().trim());
			if($("#e-name").val() != "" && $("#e-email").val() != "") {
				$("#idEmailBtn").attr("data-toggle", "modal");
				$("#idEmailBtn").attr("data-target", "#myModal");
			}
		});
		
		// 이메일 도메인 select option 선택 시 input입력창 값을 선택한 값으로 바꿔주기
		$("#emaildomain").change(function(){
			let domain = $("#emaildomain").val();
			$("#emailaddress").val(domain);
		});
		$("#pw-emaildomain").change(function(){
			let domain = $("#pw-emaildomain").val();
			$("#pw-emailaddress").val(domain);
		});
		
		// 전화번호로 아이디 찾기 확인 버튼 클릭 시
		$("#idPhoneBtn").click(function(){
			
			if(!chkData("#p-name","이름을")) return;
			else if (!chkData("#p-phone","전화번호를")) return;
			else {
				$.ajax({
					type:"POST",
					url:"/user/searchIdPhone",
					data : {
						"u_name":$("#p-name").val(), "u_phone":$("#p-phone").val(),
					},
					success:function(resultData){
						if(resultData=="") {
							$("#result-id").text("조회된 아이디가 없습니다.");
							$("#result-id").css("display", "block" );
							$("#p-name").val("");
							$("#p-phone").val("");
						} else {
							$.each(resultData, function(index, item){ // 데이터 =item

								let $table = $('#id-table');
								
								let $element = $('#result-id').clone().removeAttr('id');
								
							    $element.find('.r-id').html(item.u_id);
							    $element.find('.r-regdate').html(item.u_regdate);
							    
							    $table.append($element); 
							});							
						}
					}, error:function(){
						alert("에러 발생");
					}
				});
			}
		});
		
		// 이메일로 아이디 찾기 확인 버튼 클릭 시
		$("#idEmailBtn").click(function(){

			let email = $("#e-email").val() + "@" + $("#emailaddress").val();
			console.log(email);
			if(!chkData("#e-name","이름을")) return;
			else if (!chkData("#e-email","이메일을")) return;
			else if (!chkData("#emailaddress", "이메일 도메인을")) return;
			else {
				$.ajax({
					type:"POST",
					url:"/user/searchIdEmail",
					data : {
						"u_name":$("#e-name").val(), "u_email":email,
					},
					success:function(resultData){
						if(resultData=="") {
							$("#result-id").text("조회된 아이디가 없습니다.");
							$("#result-id").css("display", "block" );
							$("#e-name").val("");
							$("#e-email").val("");
						} else {
							$.each(resultData, function(index, item){ // 데이터 =item

								let $table = $('#id-table');
								
								let $element = $('#result-id').clone().removeAttr('id');
								
							    $element.find('.r-id').html(item.u_id);
							    $element.find('.r-regdate').html(item.u_regdate);
							    
							    $table.append($element); 
							});
						}
					}, error:function(){
						alert("에러 발생");
					}
				});
			}
		});
		
	
		// 모달창의 로그인 버튼 클릭하면 로그인 페이지로 이동
		$("#goLogin").click(function(){
			location.href="/user/login";
		});
		
		
		$('#closeBtn').click(function(){
			location.href="/user/searchIdForm";
		});
		
		$("#modalCloseBtn").click(function(){
			console.log("클릭");
			location.href="/user/searchIdForm";
		});
		
		// 비밀번호 찾기 폼
		
		/* 비밀번호 찾기 */
		$(".pw-input").keyup(function(){	// 입력값 입력되면
			$('#pw-name').val($('#pw-name').val().trim());
			$('#pw-id').val($('#pw-id').val().trim());
			$('#pw-email').val($('#pw-email').val().trim());
			if($("#pw-name").val() != "" && $("#pw-id").val() != "" && $("#pw-email").val() != "") {
				$("#sendBtnArea").css("display","table-row");	// 인증키 전송 버튼 보이게
			}
		}); 	// 백스페이스로 지웠을 때는 왜 안될꼬,,,,
		
		$("#pwdSendBtn").click(function(){

			let email = $("#pw-email").val() + "@" + $("#pw-emailaddress").val();
			
			let userChk = 0;
			// 입력한 이름, 아이디, 이메일이 회원 데이터에 존재하는 지 확인 후 메일 전송
			$.ajax({
				url : "/user/userConfirm",
				type : "POST",
				data : { "u_name":$("#pw-name").val(), "u_id":$("#pw-id").val(), "u_email":email
				},
				success:function(data){
					if(data == 0) {
						alert("입력한 정보와 일치하는 회원 정보가 없습니다.");
					} else {
						$.ajax({
							type:"POST",
							url:"/user/sendTempPwd",
							data : {
								"email":email, "id":$("#pw-id").val()
							},
							success:function(data){
								
								$("#pwdSendBtn").attr("disabled", "disabled");
								$("#goLoginArea").css("display","table-row");
								alert("해당 이메일로 임시 비밀번호가 발급되었습니다. 임시 비밀번호로 로그인해주세요.");
								
							},
							error: function (xhr, status, error) { alert("실패"); }
						});
						////// 왜 실패가 뜨지...
					}
				}
			});
		
		$("#goLoginBtn").click(function(){
			location.href="/user/login";
		});
		
		

		 
			// ----
			
			$("#chkKey").change(function(){
				if($("#chkKeyDiv.has-success").length) {
					$("#pwdBtnArea").css("display", "table-row");
				} else {
					$("#pwdBtnArea").css("display", "none");
				}
			});
			/*
			$("#pwdBtn").click(function(){
				
				$.ajax({
					url : "/user/setNewPwdForm",
					type : "POST",
					data : { "u_name":$("#pw-name").val(), "u_id":$("#pw-id").val(), "u_email":email
					},success:function(data){
				
					}
				});
	
				//location.href="/user/setNewPwdForm?u_id="+$("#pw-id").val();
			});
			*/


		});
		
		
		
		/******************/
	
	}); 	///////////////////////////////

		/*
	  function chkEmailConfirm(data) {
		  $("#chkKey").on("keyup",function(){
			  if(data != $("#chkKey").val() ) { 	// 인증번호 일치 X
				  	$("#chkKeyDiv").removeClass("has-success");
					$("#chkSpan").removeClass("glyphicon-ok");
				  	$("#chkKeyDiv").addClass("has-error");
					$("#chkSpan").addClass("glyphicon-remove");	
				} else if ($("#chkKey").val() == ""){	// 아무것도 입력 X
					$("#chkKeyDiv").removeClass("has-success");
					$("#chkSpan").removeClass("glyphicon-ok");
				  	$("#chkKeyDiv").removeClass("has-error");
					$("#chkSpan").removeClass("glyphicon-remove");	
				}else {								// 인증번호 일치 O
					$("#chkKeyDiv").removeClass("has-error");
					$("#chkSpan").removeClass("glyphicon-remove");
				  	$("#chkKeyDiv").addClass("has-success");
					$("#chkSpan").addClass("glyphicon-ok");	
				} 
		  });
	  }*/
	
</script>

<style>
	#result-id{display: none;}
	#pwdBtnArea{display: none;}
	#chkKeyArea{display:none;}
	#sendBtnArea{display:none;}
	#goLoginArea{display:none;}
	.container{margin-top : 40px;}
	.gridForm {display: grid;}
	.nav-tabs>li>a {color:black;}
	.nav-tabs>li.active>a {background-color : dodgerblue; color:white;}
	.table>tbody>tr>td {border : none;}
	
</style>

</head>
<body>
<br>
<div><h3 class="text-center">아이디 / 비밀번호 찾기</h3></div>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="closeBtn"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">아이디 찾기 결과</h4>
      </div>
      <div class="modal-body">
      	<table id="id-table">
       		<tr id="result-id" class="result">
       			<td></td>
       			<td class="r-id"></td>
       			<td>&nbsp;&nbsp;</td>
       			<td class="r-regdate"></td>
       		</tr>
       	</table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" id="modalCloseBtn">닫기</button>
        <button type="button" class="btn btn-primary" id="goLogin">로그인</button>
      </div>
      
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

	 <div class="container">
	 
		<ul class="nav nav-tabs nav-justified">
		  <li class="active"><a data-toggle="tab" href="#searchId">아이디 찾기</a></li>
		  <li><a data-toggle="tab" href="#searchPwd">비밀번호 찾기</a></li>
		</ul>
		
		<div class="tab-content">
		<!-- 아이디 찾기 -->
			  <div id="searchId" class="tab-pane fade in active">
		          <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
			 		<!--  전화번호로 찾기 -->
					  <div class="panel panel-default">
					    <div class="panel-heading" role="tab" id="headingOne">
					    <h4 class="panel-title">
					      <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne"> ▶ 등록된 전화번호로 찾기</a>
					    </h4>
					    </div>
					    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
					      <div class="panel-body">
					      		<!-- 전화번호로 찾기 폼 -->
					      		<form id="idPhoneForm" class="container-fluid gridForm">
					      		<input type="hidden" id="searchType" value="phone"/>
					      		<table class="table tableForm">
									<tr class="form-group"> 
										<td>이름</td>
										<td colspan="4" class="inputTD" style="width: 85%;"><input type="text" class="form-control p-input" id="p-name" name="p-name" placeholder="이름을 입력해주세요." /></td>
									</tr>
									<tr class="form-group">
										<td>전화번호</td>
										<td colspan="4" class="inputTD" style="width: 85%;"><input type="text" class="form-control p-input" id="p-phone" name="p-phone" placeholder="전화번호를 입력해주세요. (- 제외)"/></td>
									</tr>
									<tr class="form-group">
										<td colspan="5" class="inputTD"><button type="button" id="idPhoneBtn" class="btn btn-block w-btn-outline w-btn-indigo-outline">확인</button></td>
									</tr>
								</table>
								</form>
					      		<!-- 전화번호로 찾기 폼 -->
					      </div>
					      
					    </div>
					  </div>
					<!--  전화번호로 찾기 -->
					<!--  이메일로 찾기 -->
					  <div class="panel panel-default">
					    <div class="panel-heading" role="tab" id="headingTwo">
					      <h4 class="panel-title">
					      <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo"> ▶ 등록된 이메일로 찾기</a>
					      </h4>
					    </div>
					    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
					      <div class="panel-body">
			        			<!-- 이메일로 찾기 폼 -->
			        			<form id="emailIdForm" class="container-fluid gridForm">
			        			<table class="table tableForm">
									<tr class="form-group"> 
										<td>이름</td>
										<td colspan="3" class="inputTD" style="width: 85%;"><input type="text" class="form-control e-input" id="e-name" name="e-name" placeholder="이름을 입력해주세요." /></td>
									</tr>
									<tr class="form-group">
										<td>이메일</td>
										<td><input type="text" class="form-control e-input"  id="e-email" name="e-email" placeholder="이메일을 입력해주세요." /></td>
										<td>
										 <div class="input-group">
									      <span class="input-group-addon">@</span>
									      <input type="text" class="form-control" id="emailaddress" name="emailaddress"/>
									    </div>
										</td>
										<td>
											<select name="emaildomain" id="emaildomain" class="form-control">
										        <option value="">직접입력</option>
										        <option value="naver.com">naver.com</option>
										        <option value="gmail.com">gmail.com</option>
										        <option value="daum.net">daum.net</option>
										        <option value="hanmail.net">hanmail.net</option>
										        <option value="nate.com">nate.com</option>
										    </select>
										    <input type="hidden" id="u_email" name="u_email" value="">
										</td>
									</tr>
									<tr class="form-group">
										<td colspan="5"><button type="button" id="idEmailBtn" class="btn btn-block w-btn-outline w-btn-indigo-outline">확인</button></td>
									</tr>
								</table>
								</form>
				        	   	<!-- 이메일로 찾기 폼 -->
						  </div>
					   </div>
					</div>
					<!--  이메일로 찾기 -->
				</div> <!-- panel-group 종료 -->
		  	</div>
		  
		  <!-- 비밀번호 찾기 -->
		  <div id="searchPwd" class="tab-pane fade">
		   <form id="pwdForm" class="container gridForm">
      			<table class="table tableForm">
					<tr class="form-group"> 
						<td>이름</td>
						<td colspan="3"><input type="text" class="form-control pw-input" id="pw-name" name="pw-name" placeholder="이름을 입력해주세요." /></td>
					</tr>
					<tr class="form-group"> 
						<td>아이디</td>
						<td colspan="3"><input type="text" class="form-control pw-input" id="pw-id" name="pw-id" placeholder="아이디를 입력해주세요." /></td>
					</tr>
					<tr class="form-group">
						<td>이메일</td>
						<td><input type="text" class="form-control pw-input"  id="pw-email" name="pw-email" placeholder="이메일을 입력해주세요." /></td>
						<td>
						 <div class="input-group">
					      <span class="input-group-addon">@</span>
					      <input type="text" class="form-control pw-input" id="pw-emailaddress" name="pw-emailaddress"/>
					    </div>
						</td>
						<td>
							<select name="pw-emaildomain" id="pw-emaildomain" class="form-control">
						        <option value="">직접입력</option>
						        <option value="naver.com">naver.com</option>
						        <option value="gmail.com">gmail.com</option>
						        <option value="daum.net">daum.net</option>
						        <option value="hanmail.net">hanmail.net</option>
						        <option value="nate.com">nate.com</option>
						    </select>
						</td>
					</tr>
					<tr class="form-group" id="sendBtnArea">
						<td></td>
						<td colspan="4"><button type="button" id="pwdSendBtn" class="btn btn-block w-btn-outline w-btn-indigo-outline">임시 비밀번호 전송</button></td>
					</tr>
					<tr class="form-group" id="goLoginArea">
						<td></td>
						<td colspan="4"><button type="button" id="goLoginBtn" class="btn btn-block w-btn-outline w-btn-indigo-outline">로그인 페이지로 이동</button></td>
					</tr>
					<!-- 
					<tr class="form-group" id="chkKeyArea">
						<td></td>
						<td colspan="4">
							<div class="form-group has-feedback" id="chkKeyDiv">
							<input type="text" class="form-control" id="chkKey" name="chkKey" placeholder="인증키를 입력해주세요."/>
							<span class="glyphicon form-control-feedback" aria-hidden="true" id="chkSpan"></span>
							</div>
						</td>
					</tr>
					<tr class="form-group" id="pwdBtnArea">
						<td></td>
						<td colspan="4"><button type="button" id="pwdBtn" class="btn btn-default btn-block">확인</button></td>
					</tr>
					-->
				</table>
			</form>
		  </div>

		</div>
    

    </div> <!-- /container -->
</body>
</html>