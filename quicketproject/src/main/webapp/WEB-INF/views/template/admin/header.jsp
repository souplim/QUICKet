<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page trimDirectiveWhitespaces="true" %>
<style type="text/css">
	.container-fluid { 
		font-family: 'LeferiBaseType-RegularA';
		font-size: 17px;
	} 
	#navbar.navbar-collapse.collapse a {
		color: #fff;
	}
	a.navbar-brand-img { 
		margin:0 !important; 
		padding:0 !important;
	} 

</style>
<div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
          	<li>
          		<a class="navbar-brand navbar-brand-img" href="#">
          			<img src="/resources/image/001.png" alt="QUICKet로고" width="110" height="45"/>
          		</a>
          	</li>
          </ul>
           <ul class="nav navbar-nav navbar-right">
            <li><a href="/admin/logout">로그아웃</a></li>
            <li><a href="#">홈페이지</a></li>
          </ul>
        </div>
</div>

