<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/WEB-INF/views/common/common.jspf" %>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix= "fn" uri= "http://java.sun.com/jsp/jstl/functions" %>
	<script type="text/javascript">
	$(function(){
		
		/* 뒤로가기 버튼 클릭 시 처리 이벤트 */
		$("#back").click(function(){
			location.href = "/admin/ticket/hall_list";
		});
	
		/* 제목 클릭시 상세 페이지 이동을 위한 처리 이벤트 */		
		$(".goDetail").click(function(){
			//let num = $(this).parents("tr").children().eq(0).html();
			// 이벤트가 발생한 자기 자신. 자신을 포함한 부모 요소중 tr을 찾아 trdㅢ 속성인 data-num의 값을 읽ㅇ옴
			let hall_id = $(this).parents("tr").attr("data-num");
			$("#hall_id").val(hall_id);
			console.log("글번호 : "+hall_id);
			$("#detailForm").attr({
				"method":"get",
				"action":"/admin/ticket/hall_updateForm2"
			});
			$("#detailForm").submit();
		})
	}); // $ 함수 종료문
	
	/* 검색을 위한 실질적인 처리 함수 */
</script>
</head>
<body>
<div class="contentContainer container">
<div class="contentTit page-header"><h3 class="text-center">예매 정보 등록</h3></div>
	<form id="detailForm">
		<input type="hidden" id="hall_id" name="hall_id"/>
	</form>
 	<table class="table table-striped">
		<tr>
			<td class="text-left col-md-2"><h4>공연명</h4></td>
			<td class="text-left col-md-1">${updateData[0].s_name}</td>
			<td class="text-left col-md-2"><h4>공연장</h4></td>
			<td class="text-left col-md-1">${updateData[0].th_name}</td>
			<td class="text-left col-md-2"><h4>공연시작일</h4></td>
			<td class="text-left col-md-1">${updateData[0].hall_start}</td>
			<td class="text-left col-md-2"><h4>공연종료일</h4></td>
			<td class="text-left col-md-1">${updateData[0].hall_end}</td>
		</tr>
	</table> 
	<div id="updateData" class="table-height"> 
	<table summary="게시판 리스트" class="table table-striped">
		<thead>
			<tr>
				<th class="text-left col-md-2">공연관</th>
				<th class="text-left col-md-2">공연회차</th>
				<th class="text-left col-md-3">공연시간</th>
				<th class="text-left col-md-2">좌석수</th>
				<th class="text-left col-md-3">예매 날짜</th>
			</tr>
		</thead>
		<tbody id="list" class="table-striped">
			<!--데이터 출력 -->
			<c:choose>
				<c:when test="${not empty updateData}">
					<c:forEach var="update" items="${updateData}" varStatus="status">
						<tr class="text-center" data-num="${update.hall_id}">
							<td class="text-left">${update.hall_place}</td>
							<td class="text-left">${update.hall_turn}</td>
							<td class="text-left">${update.hall_time}</td>
							<td class="text-left">${update.hall_seatNum}</td>
							<td class="text-left">${update.hall_date}</td>
							<td class="goDetail"><button>update</button></td>
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
			<div class="text-right">
				<button type="button" id="back" class="btn btn-primary btn-sm">뒤로가기</button>
			</div>
</div>

		
		
</body>

