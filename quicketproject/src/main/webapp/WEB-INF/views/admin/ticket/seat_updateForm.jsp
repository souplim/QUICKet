<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/WEB-INF/views/common/common.jspf" %>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix= "fn" uri= "http://java.sun.com/jsp/jstl/functions" %>
	<script type="text/javascript">
	$(function(){
		/* 뒤로가기 버튼 클릭 시 처리 이벤트 */
		$("#back").click(function(){
			location.href="/admin/ticket/hall_updateForm?th_num="+"${th_numValue.th_num}";
		});
		/* 좌석정보등록 버튼 클릭 시 처리 이벤트 */
		$("#writeBtn").click(function(){
			location.href="/admin/ticket/seat_insertForm?hall_id="+"${seat_updateForm[0].hall_id}";
		});
	
		/* update 클릭시 상세 페이지 이동을 위한 처리 이벤트 */		
		$(".goDetail1").click(function(){
			//let num = $(this).parents("tr").children().eq(0).html();
			// 이벤트가 발생한 자기 자신. 자신을 포함한 부모 요소중 tr을 찾아 trdㅢ 속성인 data-num의 값을 읽ㅇ옴
			let seat_num = $(this).parents("tr").attr("data-num");
			$("#seat_num").val(seat_num);
			console.log("글번호 : "+seat_num);
			$("#detailForm").attr({
				"method":"get",
				"action":"/admin/ticket/seat_updateForm2"
			});
			$("#detailForm").submit();
		})
		/* delete 클릭시 상세 페이지 이동을 위한 처리 이벤트 */		
		$(".goDetail2").click(function(){
			//let num = $(this).parents("tr").children().eq(0).html();
			// 이벤트가 발생한 자기 자신. 자신을 포함한 부모 요소중 tr을 찾아 trdㅢ 속성인 data-num의 값을 읽ㅇ옴
			let seat_num = $(this).parents("tr").attr("data-num");
			$("#seat_num").val(seat_num);
			$("#detailForm").attr({
				"method":"post",
				"action":"/admin/ticket/seat_delete"
			});
			$("#detailForm").submit();
		})
	}); // $ 함수 종료문
	
	/* 검색을 위한 실질적인 처리 함수 */
</script>
</head>
<body>
<div class="contentContainer container">
<div class="contentTit page-header"><h3 class="text-center">예매(좌석) 정보 등록</h3></div>
	<form id="detailForm">
		<input type="hidden" id="seat_num" name="seat_num"/>
		<input type="hidden" id="hall_id" name="hall_id" value="${seat_updateForm[0].hall_id}"/>
		
	</form>
	<div id="seat_updateForm" class="table-height"> 
	<table summary="게시판 리스트" class="table table-striped">
		<thead>
			<tr>
				<th class="text-left col-md-1">좌석번호</th>
				<th class="text-left col-md-1">좌석이름</th>
				<th class="text-left col-md-1">hall_id</th>
				<th class="text-left col-md-1">좌석상태</th>
				<th class="text-left col-md-2">좌석연령</th>
				<th class="text-left col-md-3">좌석등록일</th>
				<th class="text-left col-md-3">좌석수정일</th>
			</tr>
		</thead>
		<tbody id="list" class="table-striped">
			<!--데이터 출력 -->
			<c:choose>
				<c:when test="${not empty seat_updateForm}">
					<c:forEach var="update" items="${seat_updateForm}" varStatus="status">
						<tr class="text-center" data-num="${update.seat_num}">
							<td class="text-left">${update.seat_num}</td>
							<td class="text-left">${update.seat_name}</td>
							<td class="text-left">${update.hall_id}</td>
							<td class="text-left">${update.seat_status}</td>
							<td class="text-left">${update.seat_age}</td>
							<td class="text-left">${update.seat_regdate}</td>
							<td class="text-left">${update.seat_update}</td>
							<td class="goDetail1"><button>Update</button></td>
							<td class="goDetail2"><button>delete</button></td>
							
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
				<button type="button" id="writeBtn" class="btn btn-primary btn-sm">좌석정보등록</button>
				<button type="button" id="back" class="btn btn-primary btn-sm">뒤로가기</button>
			</div>
</div>

		
		
</body>

