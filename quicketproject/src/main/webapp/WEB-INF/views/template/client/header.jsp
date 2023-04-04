<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page trimDirectiveWhitespaces="true" %>
<style>

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
    background-color: #00000075;
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
    width: 250px;
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
}
.sidebar-nav li a:hover {
    text-decoration: none;
    color: #444;
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

@media(min-width:768px) {
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
    #page-content-wrapper {
        padding: 20px;
        position: relative;
    }
    #wrapper.toggled #page-content-wrapper {
        position: relative;
        margin-right: 0;
    }
}
</style>

<script>
	$(document).ready(function(){
		$("#open-btn").click(function (e) {
		    e.preventDefault();
		    $("#wrapper").removeClass("toggled").addClass("active")
		});
		
		$("#close-btn").click(function (e) {
		    e.preventDefault();
		    $("#wrapper").removeClass("active").addClass("toggled")
		});
	});
</script>


<div class="container-fluid">
	<div id="wrapper" class="toggled">
    <!-- Sidebar -->
    <div id="sidebar-wrapper">
        <ul class="sidebar-nav">
            <button type="button" id="close-btn" class="btn btn-info">CLOSE</button>
            <li><a href="/genre?s_genre=뮤지컬">뮤지컬</a> </li>
            <li><a href="/genre?s_genre=연극">연극</a> </li>
            <li><a href="/ranking">랭킹</a></li>
            <li> <a href="/user/coupon/">쿠폰/이벤트</a></li>
            <li> <a href="/faq/faqList">FAQ</a></li>
            <li> <a href="/mypage/">마이페이지</a></li>
        </ul>
    </div>
    <!-- /#sidebar-wrapper -->
    <!-- Page Content
    <div id="page-content-wrapper"> <a href="#" class="btn btn-default" id="menu-toggle"><span class="glyphicon glyphicon-th-list"></span></a>

        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">
                     <h1>KODI</h1>

                </div>
            </div>
        </div>
    </div> -->
    <!-- /#page-content-wrapper -->
</div>

        <div class="navbar-header">
        
        <button type="button" id="open-btn" class="btn btn-info navbar-left">메뉴</button>
          
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Project name</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li><a href="/">홈</a></li>
            <li><a href="/genre?s_genre=뮤지컬">뮤지컬</a></li>
            <li><a href="/genre?s_genre=연극">연극</a></li>
            <li><a href="/ranking">랭킹</a></li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <c:if test="${not empty userLogin}">
            	<li><a>${userLogin.u_name }님 환영합니다.</a></li>
		 		<li><a href="/user/logout">로그아웃</a></li>
			</c:if>
			<c:if test="${empty userLogin}">
			 	<li><a href="/user/login">로그인</a></li>
			</c:if>
            <li><a href="#">고객센터</a></li>
          </ul>
        </div>
        
      </div>
  