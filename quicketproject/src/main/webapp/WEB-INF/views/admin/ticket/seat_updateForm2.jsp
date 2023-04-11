<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/WEB-INF/views/common/common.jspf" %>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix= "fn" uri= "http://java.sun.com/jsp/jstl/functions" %>
	<script type="text/javascript">
	$(function(){
		/* 뒤로가기 버튼 클릭 시 처리 이벤트 */
		$("#back").click(function(){
			$("#detailForm").attr({
				"method":"get",
				"action":"/admin/ticket/hall_updateForm"
			});
			$("#detailForm").submit();
		});
		$("#updateBtn").click(function(){
			if(!chkData('#seat_name', "좌석이름을")) return;
			if(!chkData('#seat_status', "좌석상태를")) return;
			
			$("#updateForm").attr({
				"method":"post",
				"action":"/admin/ticket/seatUpdate"
			});
			$("#updateForm").submit();
		});
	
	}); // $ 함수 종료문
	
	/* 검색을 위한 실질적인 처리 함수 */
</script>
</head>
<body>
<div class="contentContainer container">
<form id="detailForm">
		<input type="hidden" id="s_num" name="s_num" value = "${seat_updateForm2.s_num}"/>
		
</form>
<div class="contentTit page-header"><h3 class="text-center">좌석 정보 등록</h3></div>
	<form id="updateForm">
	<table summary="게시판 리스트" class="table table-striped">
		<thead>
			<tr>
				<th class="text-left col-md-1">좌석번호</th>
				<th class="text-left col-md-1">좌석이름</th>
				<th class="text-left col-md-1">좌석상태</th>
				<th class="text-left col-md-2">좌석연령</th>
				<th class="text-left col-md-3">좌석수정일</th>
			</tr>
		</thead>
		
		<tbody id="list" class="table-striped">
			<!--데이터 출력 -->
			<tr>
				<td class="text-left"><input type="text" name="seat_num" id="seat_num" value = "${seat_updateForm2.seat_num}" class="form-control" readonly/></td>
				<td class="text-left"><input type="text" name="seat_name" id="seat_name" value = "${seat_updateForm2.seat_name}" class="form-control" /></td>
				<td class="text-left"><input type="text" name="seat_status" id="seat_status" value = "${seat_updateForm2.seat_status}" class="form-control" /></td>
				<td class="text-left"><input type="text" name="seat_age" id="seat_age" value = "${seat_updateForm2.seat_age}" class="form-control" /></td>
				<td class="text-left"><input type="text" name="seat_update" id="seat_update" value = "${seat_updateForm2.seat_update}" class="form-control" /></td>
				<td class="goDetail"><button id = "updateBtn">update</button></td>
			</tr>

		</tbody>
		
	</table>
	<input type="hidden" id="hall_id" name="hall_id" value = "${seat_updateForm2.hall_id}"/>
	<input type="hidden" id="th_num" name="th_num" value = "${seat_updateForm2.th_num}"/>
	</form>
	
</div> 
			<div class="text-right">
				<button type="button" id="back" class="btn btn-primary btn-sm">뒤로가기</button>
			</div>

		
		
</body>

