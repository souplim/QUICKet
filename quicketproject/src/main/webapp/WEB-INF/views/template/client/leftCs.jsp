<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="uri" value='${requestScope["javax.servlet.forward.request_uri"]}' />

<style>
	/* small {color : gray;} */
	a {
		color : gray;
		font-size: 15px;
	}
	strong {color : dodgerblue;}
</style>

<ul class="nav">
	<li>
		<strong>공지</strong>
		<ul class="nav nav-sidebar">
			<li ><a href="#">공지사항</a></li>
		</ul>
	</li>
	<li>
		<strong>FAQ 자주 묻는 질문</strong>
		<ul class="nav nav-sidebar">
			<li><a href="#">로그인</a></li>
			<li><a href="#">아이디/패스워드</a></li>
			<li><a href="#">회원가입</a></li>
			<li><a href="#">회원정보</a></li>
			<li><a href="#">회원탈퇴</a></li>
			<li><a href="#">예매</a></li>
			<li><a href="#">취소/변경</a></li>
			<li><a href="#">배송</a></li>
			<li><a href="#">결제</a></li>
			<li><a href="#">이벤트</a></li>
			<li><a href="#">건의사항</a></li>
			<li><a href="#">기타</a></li>
		</ul>
	</li>
	<li>
		<strong>1:1문의</strong>
		<ul class="nav nav-sidebar">
			<li ><a href="/inq/inqList">1:1문의하기</a></li>
		</ul>
	</li>
</ul>
