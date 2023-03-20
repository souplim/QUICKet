<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="uri" value='${requestScope["javax.servlet.forward.request_uri"]}' />


<div class="position-sticky pt-3 sidebar-sticky">

	<ul class="nav flex-column">
	<li class="nav-item"><a class="nav-link active" href="#">공연 관리</a></li>
	<li class="nav-item"><a class="nav-link" href="#">공연장 관리</a></li>
	<li class="nav-item"><a class="nav-link" href="#">회원 관리</a></li>
	<li class="nav-item"><a class="nav-link" href="#">예매 관리</a></li>
	<li class="nav-item"><a class="nav-link" href="#">공지사항</a></li>
	<li class="nav-item"><a class="nav-link" href="#">FAQ</a></li>
	<li class="nav-item"><a class="nav-link" href="#">1:1 문의</a></li>
	<li class="nav-item"><a class="nav-link" href="#">이벤트 관리</a></li>
	<li class="nav-item"><a class="nav-link" href="#">쿠폰 관리</a></li>
	<li class="nav-item"><a class="nav-link" href="#">커뮤니티 관리</a></li>	
	<li class="nav-item"><a class="nav-link" href="#">통계 관리</a></li>
</ul>

      </div>


