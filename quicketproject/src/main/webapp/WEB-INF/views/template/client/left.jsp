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
		<strong>예매 관리</strong>
		<ul class="nav nav-sidebar">
			<li><a href="/mypage/myTicketList">예매 확인/취소</a></li>
			<li><a href="/mypage/myLikeList">관심공연 확인/취소</a></li>
		</ul>
	</li>
	<li>
		<strong>할인 혜택</strong>
		<ul class="nav nav-sidebar">
			<li ><a href="/mypage/myCouponList">쿠폰</a></li>
			<!-- <li><a href="#">참여 이벤트</a></li> -->
		</ul>
	</li>
	<li>
		<strong>커뮤니티 활동</strong>
		<ul class="nav nav-sidebar">
			<li><a href="/mypage/myExpectList">공연 기대평</a></li>
			<li><a href="/mypage/myReviewList">공연 관람후기</a></li>
			<li><a href="/mypage/myQnaList">작성한 Q&A</a></li>
		</ul>
	</li>
</ul>
