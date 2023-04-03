<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/resources/image/icon.png">

    <title>ADMIN LOGIN</title>

    <!-- Bootstrap core CSS -->
    <link href="/resources/include/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/resources/include/dist/css/signin.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="/resources/include/dist/assets/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    
	<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="/resources/include/js/common.js"></script>
	
	<link rel="stylesheet" type="text/css" href="/resources/include/css/default.css"/>
    
    <script src="/resources/js/common.js"></script>
    
    <script type="text/javascript">
    	$(function(){
    		let errorMsg = "${errorMsg}";
    		if(errorMsg!="") {
    			alert(errorMsg);
    			errorMsg = "";
    		}
    		
    		$("#loginBtn").click(function(){
    			if (!chkData("#admin_id", "아이디를")) return;
    			else if(!chkData("#admin_pwd", "비밀번호를")) return;
    			else {
    				$("#loginForm").attr({
    					"method" : "post",
    					"action" : "/admin/login"
    				});
    				$("#loginForm").submit();
    			}
    		});
    	});
    </script>
  </head>

  <body>

    <div class="container">

      <form class="form-signin" id="loginForm">
        <h3 class="form-signin-heading">관리자 로그인</h3>
        <label for="admin_id" class="sr-only">아이디</label>
        <input type="text" id="admin_id" name="admin_id" class="form-control" placeholder="아이디">
        <label for="admin_pwd" class="sr-only">비밀번호</label>
        <input type="password" id="admin_pwd" name="admin_pwd" class="form-control" placeholder="비밀번호">

        <button class="btn btn-lg btn-info btn-block" type="button" id="loginBtn">로그인</button>
      </form>

    </div> <!-- /container -->


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="/resources/include/dist/assets/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
