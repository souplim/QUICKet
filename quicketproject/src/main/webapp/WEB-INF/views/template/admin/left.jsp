<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var = "uri" value="${requestScope['javax.servlet.forward.request_uri']}" />

	<ul class="nav nav-sidebar">
	  <!-- <li class="active"><a href="#">Overview <span class="sr-only">(current)</span></a></li> -->
	  <li><a href="#">관리자 메뉴</a></li>
	  <li <c:if test="${fn:containsIgnoreCase(uri,'/admin/board')}">class="active"</c:if>>
	  	<a href="/admin/board/boardList">게시판 관리</a>
  	  </li>
	  <li <c:if test="${fn:containsIgnoreCase(uri,'/admin/member')}">class="active"</c:if>>
	  	<a href="/admin/member/memberList">회원 관리</a>
  	  </li>
	</ul>
	