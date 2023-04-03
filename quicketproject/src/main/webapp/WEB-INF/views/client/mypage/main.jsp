<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

<style>
	.row { display: flex; }
	.mypageDiv {
		border: 2px solid black;
		border-radius: 20px;
		width : 25%;
		height : 200px;
		margin : 20px;
	}
</style>
</head>
<body>
	<div class="container text-center">
        <h4 class="text-center">마이페이지</h4>
        <br><br>
    	<h3 class="text-center">${userLogin.u_name} 님</h3>
    	<br>
    	<div class="text-center">
    		<p>가입 날짜 : ${userLogin.u_regdate}</p>
    		<p>최근 정보 변경일 : ${userLogin.u_moddate}</p>
    	</div>
    	<br><br><br>
    	<div class="row">
	        <div class="mypageDiv">
	        	<h1 class="glyphicon glyphicon-user" aria-hidden="true"></h1>
	          	<h3>회원정보 조회</h3>
	        </div><!-- /.col-lg-4 -->
	         <div class="mypageDiv">
	        	<h1 class="glyphicon glyphicon-pencil" aria-hidden="true"></h1>
	          	<h3>회원정보 수정</h3>
	        </div><!-- /.col-lg-4 -->
	       <div class="mypageDiv">
	        	<h1 class="glyphicon glyphicon-lock" aria-hidden="true"></h1>
	          	<h3>비밀번호 변경</h3>
	        </div><!-- /.col-lg-4 -->
      	</div><!-- /.row -->
    </div>
</body>
</html>