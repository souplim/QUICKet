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
			<li ><a href="/faq/faqList?pageNum=1&amount=10&search=f_title&keyword=로그인">로그인</a></li>	
			<li ><a href="/faq/faqList?pageNum=1&amount=10&search=f_title&keyword=아이디/패스워드">아이디/패스워드</a></li>		
			<li ><a href="/faq/faqList?pageNum=1&amount=10&search=f_title&keyword=회원가입">회원가입</a></li>
			<li ><a href="/faq/faqList?pageNum=1&amount=10&search=f_category&keyword=회원정보">회원정보</a></li>
			<li ><a href="/faq/faqList?pageNum=1&amount=10&search=f_title&keyword=탈퇴">회원탈퇴</a></li>		
			<li ><a href="/faq/faqList?pageNum=1&amount=10&search=f_category&keyword=공연">공연</a></li>
			<li ><a href="/faq/faqList?pageNum=1&amount=10&search=f_category&keyword=결제">결제</a></li>		
			<li ><a href="/faq/faqList?pageNum=1&amount=10&search=f_category&keyword=예매/취소">예매/취소</a></li>
			<li ><a href="/faq/faqList?pageNum=1&amount=10&search=f_category&keyword=배송">배송</a></li>
			<li ><a href="/faq/faqList?pageNum=1&amount=10&search=f_category&keyword=이벤트">이벤트</a></li>
			<li ><a href="/faq/faqList?pageNum=1&amount=10&search=f_category&keyword=기타">기타</a></li>		
		</ul>
	</li>
	<li>
		<strong>1:1문의</strong>
		<ul class="nav nav-sidebar">
			<li ><a href="/inq/inqList">1:1문의하기</a></li>
		</ul>
	</li>
</ul>
