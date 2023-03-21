<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="uri"
	value='${requestScope["javax.servlet.forward.request_uri"]}' />

<div class="col-sm-3 col-md-2 sidebar">

	<ul class="nav nav-sidebar">
		<li><small>예매 관리</small>
			<ul class="nav nav-sidebar">
				<li><a href="#">예매 확인/취소</a></li>
				<li><a href="#">찜 확인/취소</a></li>
			</ul></li>
		<li><small>할인 혜택</small>
			<ul class="nav nav-sidebar">
				<li><a href="#">쿠폰</a></li>
				<li><a href="#">참여 이벤트</a></li>
			</ul></li>
		<li><small>커뮤니티 활동</small>
			<ul class="nav nav-sidebar">
				<li><a href="#">공연 기대평</a></li>
				<li><a href="#">공연 관람후기</a></li>
				<li><a href="#">작성한 Q&A</a></li>
			</ul></li>
	</ul>


</div>
