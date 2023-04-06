<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/WEB-INF/views/common/common.jspf" %>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix= "fn" uri= "http://java.sun.com/jsp/jstl/functions" %>
	<script type="text/javascript">
	$(function(){
		
	
		/* 제목 클릭시 상세 페이지 이동을 위한 처리 이벤트 */		
		$(".goDetail").click(function(){
			let pay_num = $(this).parents("tr").attr("data-num");
			console.log("글번호 : "+pay_num);
		})
	}); // $ 함수 종료문
	
	/* 검색을 위한 실질적인 처리 함수 */
</script>
</head>
<body>
<div class="contentContainer container">
<div class="contentTit page-header"><h3 class="text-center">결제 취소 페이지</h3></div>
	<div id="payList" class="table-height"> 
	<table summary="게시판 리스트" class="table table-striped">
		<thead>
			<tr>
				<th class="text-left col-md-3">예매번호</th>
				<th class="text-left col-md-2">공연명</th>
				<th class="text-left col-md-2">아이디</th>
				<th class="text-left col-md-3">예매시간</th>
				<th class="text-left col-md-2"></th>
			</tr>
		</thead>
		<tbody id="list" class="table-striped">
			<!--데이터 출력 -->
			<c:choose>
				<c:when test="${not empty payList}">
					<c:forEach var="pay" items="${payList}" varStatus="status">
						<tr class="text-center" data-num="${pay.pay_num}">
							<td class="text-left">${pay.pay_num}</td>
							<td class="text-left">${pay.s_name}</td>
							<td class="text-left">${pay.u_id}</td>
							<td class="text-left">${pay.ti_date}</td>
							<td class="goDetail"><button>결제취소</button></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="4" class="tac text-center">등록된 게시글이 존재하지 않습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		
		</tbody>
	</table>
	
</div> 
</div>

		
		
</body>

