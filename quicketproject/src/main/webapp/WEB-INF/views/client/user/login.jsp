<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
    <link href="/resources/include/dist/css/signin.css" rel="stylesheet">
    <link href="/resources/include/css/login.css" rel="stylesheet">
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    
    
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
  </head>

  <body>

    <div class=""> 
      <form class="form-signin" id="loginForm">
        <h3 class="form-signin-heading text-center">로그인</h3>
        <label for="u_id" class="sr-only">아이디</label>
        <input type="text" id="u_id" name="u_id" class="form-control" placeholder="아이디">
        <label for="admin_pwd" class="sr-only">비밀번호</label>
        <input type="password" id="u_pwd" name="u_pwd" class="form-control" placeholder="비밀번호">

        <button class="btn-gradient blue block" type="button" id="loginBtn">로그인</button>
          
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
