<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page trimDirectiveWhitespaces="true" %>

<style>
	.container-fluid { 
		background-color: #fff;
		font-family: 'LeferiBaseType-RegularA';
		font-size: 17px;
	}
	
	#navbar.navbar-collapse.collapse {
		margin-top: 25px;
	} 
	#navbar.navbar-collapse.collapse a {
		color: #000;
	}
	a.navbar-brand-img { 
		margin:0 !important; 
		padding:0 !important;
	} 
	.margin { margin-right: 30px; }
	#mainKeyword {
		width: 230px;
		border: none;
		border-bottom: 3px solid black;
		outline: none;	
	}
	#mainBtn {
		border:none;
		background-color: #fff;
	}
	#wrapper {
	 	width : 100%;
	    padding-left: 0;
	    -webkit-transition: all 0.5s ease;
	    -moz-transition: all 0.5s ease;
	    -o-transition: all 0.5s ease;
	    transition: all 0.5s ease;
	}
	#wrapper.toggled {
	    padding-left: 250px;
	}
	
	#sidebar-wrapper {
	    z-index: 1000;
	    position: fixed;
	    left: 250px;
	    height: 100%;
	    margin-left: -250px;
	    overflow-y: auto;
	    overflow-x: hidden;
	    -webkit-transition: all 0.5s ease;
	    -moz-transition: all 0.5s ease;
	    -o-transition: all 0.5s ease;
	    transition: all 0.5s ease;
	    background-color: #0000009e;
	}
	#wrapper.toggled #sidebar-wrapper {
	    width: 250px;
	}
	#page-content-wrapper {
	    width: 100%;
	    position: absolute;
	    padding: 15px;
	}
	#wrapper.toggled #page-content-wrapper {
	    position: absolute;
	    margin-right: -250px;
	}
	
	/* Sidebar Styles */
	 .sidebar-nav {
	    position: absolute;
	    top: 0;
/* 	    width: 250px; */
	    margin: 0;
	    padding: 0;
	    list-style: none;
	}
	.sidebar-nav li {
	    text-indent: 20px;
	    line-height: 40px;
	}
	.sidebar-nav li a {
	    display: block;
	    text-decoration: none;
	    color: #ddd;
	    margin-left:20px;
	}
	.sidebar-nav li a:hover {
	    text-decoration: none;
	    color: #9f9f9f;
	    background: rgba(255, 255, 255, 0.2);
	}
	.sidebar-nav li a:active, .sidebar-nav li a:focus {
	    text-decoration: none;
	}
	.sidebar-nav .sidebar-brand {
	    text-align: left;
	}
	.sidebar-nav .sidebar-brand img {
	    width: 75px;
	}
	.sidebar-nav ul {
	    list-style: none;
	    list-style-position:outside;
	    padding: 0;
	    margin: 0;
	}
	.sidebar-nav ul > li {
	    font-size: 13px;
	}
	.sidebar-nav ul > li > a {
	    color: #ddd;
	    text-decoration: none;
	    padding-left: 10px;
	}
	.sidebar-nav ul > li > a:hover {
	    color: #fff;
	    background: rgba(255, 255, 255, 0.6);
	}
	
	@media(min-width:0px){
		#wrapper {
	        padding-left: 250px;
	    }
	    #wrapper.toggled {
	        padding-left: 0;
	    }
	    #sidebar-wrapper {
	        width: 250px;
	    }
	    #wrapper.toggled #sidebar-wrapper {
	        width: 0;
	    }
	}	
	
	@media(min-width:768px) {
	   /* #wrapper {
	        padding-left: 250px;
	    }
	    #wrapper.toggled {
	        padding-left: 0;
	    }
	    #sidebar-wrapper {
	        width: 250px;
	    }
	    #wrapper.toggled #sidebar-wrapper {
	        width: 0;
	    } */
	    #page-content-wrapper {
	        padding: 20px;
	        position: relative;
	    }
	    #wrapper.toggled #page-content-wrapper {
	        position: relative;
	        margin-right: 0;
	    }
	}
	
	#close-btn{margin-left:170px; color:white; cursor:pointer;}
	#open-btn{color : white; cursor:pointer;}
</style>

<script>
	$(document).ready(function(){
		
		/* 마우스 오버 헤더 메뉴 표시 */
		$(".topMenu > li").hover(function(){
			$(this).css("borderBottom", "3px solid dodgerblue");
			$(this).css("fontWeight","bold");
		}, function(){
			$(this).css("borderBottom","").css("fontWeight","");
		});
		
		/* 해당 페이지 메뉴 표시 */
		const urlParams = new URL(location.href).searchParams;
		const genre = urlParams.get('s_genre');
		const rank = document.location.href;
		
		console.log(genre);
		if(genre=='뮤지컬'){
			$("#musical").css("borderBottom", "3px solid dodgerblue").css("fontWeight","bold");
		} else if(genre=='연극'){
			$("#play").css("borderBottom", "3px solid dodgerblue").css("fontWeight","bold");
		} else if(rank=='http://localhost:8080/ranking'){
			$("#rank").css("borderBottom", "3px solid dodgerblue").css("fontWeight","bold");
		}
		
		
		$("#open-btn").click(function (e) {
		    e.preventDefault();
		    $("#wrapper").removeClass("toggled").addClass("active")
		});
		
		$("#close-btn").click(function (e) {
		    e.preventDefault();
		    $("#wrapper").removeClass("active").addClass("toggled")
		});
		
		/* 검색창 placeholder 제어 이벤트 처리 */
		$("#mainKeyword").on("focus", function(){
			$(this).attr("placeholder","검색어를 입력하세요.");
		});
		$("#mainKeyword").on("input", function(){
			$(this).removeAttr("placeholder");
		});
		$("#mainKeyword").on("focusout", function(){
			$(this).removeAttr("placeholder");
		});
		
		/* 입력 양식 enter 제거 */
		$("#keyword").bind("keydown", function(event){
			 if (event.keyCode == 13) {
			        event.preventDefault();
			        $("#searchData").click();
			    }
		});
		
		/* 검색버튼 클릭시 검색어 /search로 넘기기 */
		$("#mainBtn").on("click", function(){

			$("#mainSearchForm").attr({
				"method":"get",
				"action":"/search"
			});
			$("#mainSearchForm").submit();
		});
		
		/* 입력 양식 enter 제거 */
		$("#mainKeyword").bind("keydown", function(event){
			 if (event.keyCode == 13) {
			        event.preventDefault();
			        $("#mainBtn").click();
			    }
		});
		
	});
</script>


<div class="container-fluid">
	<div id="wrapper" class="toggled">
		<!-- Sidebar -->
		<div id="sidebar-wrapper">
			<ul class="sidebar-nav">
				<li>
					<i class="fa-solid fa-circle-xmark fa-xl" id="close-btn"></i>
				</li>
				<br/><br/>
				<li><a href="/genre?s_genre=뮤지컬">뮤지컬</a></li>
 				<li><a href="/genre?s_genre=연극">연극</a></li>
				<li><a href="/ranking">랭킹</a></li>
				<li><a href="/user/coupon/">쿠폰</a></li>
				<li><a href="/faq/faqList">FAQ</a></li>
				<li><a href="/mypage/">마이페이지</a></li>
			</ul>
		</div>
	</div>

	<div class="navbar-header">
		<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#navbar" aria-expanded="false"
			aria-controls="navbar">
			<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span>
			<span class="icon-bar"></span> <span class="icon-bar"></span>
		</button>
	</div>
	
	<div id="navbar" class="navbar-collapse collapse">
		<ul class="nav navbar-nav">
			<li><a><i class="fa-solid fa-bars fa-xl" id="open-btn" style="color: #000000;"></i></a></li>
			<li>
				<a class="navbar-brand navbar-brand-img" href="/">
					<img src="/resources/image/001.png" alt="QUICKet로고" width="110" height="45"/>
				</a>
			</li>
		</ul>

		<ul class="nav navbar-nav topMenu">
			<li><a href="/"><i class="fa-solid fa-house fa-xl"></i></a></li>
			<li id="musical"><a href="/genre?s_genre=뮤지컬">뮤지컬</a></li>
			<li id="play"><a href="/genre?s_genre=연극">연극</a></li>
			<li class="margin" id="rank"><a href="/ranking">랭킹</a></li>
		</ul>
		
		<ul class="nav navbar-nav navbar-right">
			<li>
				<a> 
					<form id="mainSearchForm">
						<input type="text" name="keyword" id="mainKeyword" />
						<button type="button" name="mainBtn" id="mainBtn">
							<i class="fa-solid fa-magnifying-glass fa-xl"></i>
						</button>
					</form>
				</a>
			</li>
			<c:if test="${not empty userLogin.u_name}">
				<li><a>${userLogin.u_name }님 환영합니다.</a></li>
				<li><a href="/user/logout">로그아웃</a></li>
			</c:if>
			<c:if test="${empty userLogin.u_name}">
				<li><a href="/user/login">로그인</a></li>
			</c:if>
			<li><a href="/faq/faqList">고객센터</a></li>
			<li class="margin"><a href="/mypage/"><i class="fa-solid fa-user fa-xl"></i></a></li>
		</ul>
	</div>

</div>
