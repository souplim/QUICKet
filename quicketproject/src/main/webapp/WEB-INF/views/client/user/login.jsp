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

    <title>로그인</title>


	<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>
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
    			login();
    		});
    		
    		$("#loginForm").keypress(function(e){
    			if(e.keyCode === 13) {
    				login();
    			}
    		});
    		
    		
    	});
    	
    	function login() {
    		if (!chkData("#u_id", "아이디를")) return;
			else if(!chkData("#u_pwd", "비밀번호를")) return;
			else {
				$("#loginForm").attr({
					"method" : "post",
					"action" : "/user/login"
				});
				$("#loginForm").submit();
			}
    	}
    </script>
    
    <style>
    	body {background-color : white;}
    	
    	.w-btn {
    position: relative;
    border: none;
    display: inline-block;
    padding: 15px 30px;
    border-radius: 15px;
    font-family: "paybooc-Light", sans-serif;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
    text-decoration: none;
    font-weight: 600;
    transition: 0.25s;
}

.w-btn-outline {
    position: relative;
    padding: 15px 30px;
    border-radius: 15px;
    font-family: "paybooc-Light", sans-serif;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
    text-decoration: none;
    font-weight: 600;
    transition: 0.25s;
}

.w-btn-indigo {
    background-color: dodgerblue;
    color: #191970;
}

.w-btn-indigo-outline {
    border: 3px solid dodgerblue;
    color: #191970;
}

.w-btn-indigo-outline:hover {
    color: #191970;
    background: dodgerblue;
}
    	
#loginDiv {margin-top : 100px;}
input {margin:20px 0;}
    </style>
  </head>

  <body>

    <div class="container">
	<div id="loginDiv">
      <form class="form-signin" id="loginForm">
        <h4 class="form-signin-heading text-center">QUICKet 로그인</h4>
        <input type="text" id="u_id" name="u_id" class="form-control" placeholder="아이디">
        <input type="password" id="u_pwd" name="u_pwd" class="form-control" placeholder="비밀번호">

        <button class="w-btn-outline w-btn-indigo-outline btn-block" type="button" id="loginBtn">로그인</button>
          
       <div class="footer text-center">
       <br>
       <a href="/user/join">회원가입</a>
       <a href="/user/searchIdForm">아이디/비밀번호 찾기</a>
       </div>
        
      </form>
    </div>

    </div> <!-- /container -->


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="/resources/include/dist/assets/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>
