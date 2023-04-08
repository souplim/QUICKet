<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ page trimDirectiveWhitespaces="true" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
		
		<title><tiles:getAsString name="title"/></title>
		
		<link rel="shortcut icon" href="/resources/image/icon.png" />
		<link rel="apple-touch-icon" href="/resources/image/icon.png" />
		
		<!--IE8이하 브라우저에서 HTML5를 인식하기 위해서는 아래의 패스필터를 적용하면 된다.--> 
		<!--[if lt IE 9]>
		<script src="../js/html5shiv.js"></script>
		<![endif]-->
		
		<script type="text/javascript" src="/resources/include/js/jquery-3.6.2.min.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		
		<!-- Bootstrap core CSS -->
	    <link rel="stylesheet" type="text/css" href="/resources/include/dist/css/bootstrap.min.css"/> 
		<link rel="stylesheet" type="text/css" href="/resources/include/dist/css/bootstrap-theme.min.css"/>
	
	    <!-- Custom styles for this template -->
	    <link href="/resources/include/dist/css/dashboard.css" rel="stylesheet">    
	    <link rel="stylesheet" type="text/css" href="/resources/include/dist/css/button.css"/>
	
	    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
	    <!--[if lt IE 9]><script src="/resources/include/dist/assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
	    <script src="/resources/include/dist/assets/js/ie-emulation-modes-warning.js"></script>
	
		<!-- fontAwesome CDN 링크 -->
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
	
		<style type="text/css">
			@font-face {
			    font-family: 'LeferiBaseType-RegularA';
			    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/LeferiBaseType-RegularA.woff') format('woff');
			    font-weight: normal;
			    font-style: normal;
			}
	
			/* 헤더 때문에 바디 잘림 방지 */
			.row { margin-top: 50px; }
			
			/* select 글자 잘림 방지 */
			select {
				font: initial;
			}
			
			/* 페이지네이션 css */
			.pagination>li>a, .pagination>li>a:hover{
				color:#999;
			}
			.pagination>.active>a{
			    background-color:#ccc;
			    border-color:#ccc;
			}
			.pagination>.active>a:hover{
			    background-color:#999;
			    border-color:#ccc;
			}
			.pagination>.active>a:focus{
			    background-color:#777;
			    border-color:#ccc;
			}
			
			/* footer 하단 고정 */
			#body-row {
				height: auto;
				min-height: 100%;
				padding-bottom: 80px;
			}
			/* .footer {
				height: 100px;
				position: relative;
				transform: translateY(-100%);
			} */
		</style>
	
		<script type="text/javascript">
			$("#menu-toggle").click(function (e) {
			    e.preventDefault();
			    $("#wrapper").toggleClass("toggled");
			});
			
		</script>
	</head>
	<body>
		<nav class="navbar navbar-inverse navbar-fixed-top">
			<tiles:insertAttribute name="header"/>
		</nav>
		
		<div class="container-fluid">
			<div id="body-row">
				<div class="row">
					<tiles:insertAttribute name="body"/>
				</div>
			</div>
			
			<div class="footer">
				<tiles:insertAttribute name="footer"/>
			</div>
		</div>	
		
		<!-- <div class="container-fluid navbar-fixed-bottom"> -->
		 <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <!--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script> -->    
    <!--<script src="/resources/include/dist/js/bootstrap.min.js"></script>-->
    <!--<script src="/resources/include/dist/assets/js/docs.min.js"></script>-->
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="/resources/include/dist/assets/js/ie10-viewport-bug-workaround.js"></script>
	</body>
</html>