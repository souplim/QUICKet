<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/WEB-INF/views/common/common.jspf" %>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix= "fn" uri= "http://java.sun.com/jsp/jstl/functions" %>
	<script type="text/javascript">
	$(function(){
		/* 뒤로가기 버튼 클릭 시 처리 이벤트 */
		$("#back").click(function(){
			window.history.back();
		});
		
		$("#write").click(function(){
			if(!chkData('#seat_num', "좌석번호를")) return;
			if(!chkData('#seat_name', "좌석이름을")) return;
			if(!chkData('#seat_status', "좌석상태를")) return;
			$("#writeForm").attr({
				"method":"post",
				"action":"/admin/ticket/seat_write"
			});
			$("#writeForm").submit();
		});
	
	}); // $ 함수 종료문
	
	/* 검색을 위한 실질적인 처리 함수 */
</script>
</head>
<body>
<div class="contentContainer container">
<form id="writeForm">
		<input type="hidden" id="hall_id" name="hall_id" value = "${hall_idValue.hall_id}"/>
		
<div class="contentTit page-header"><h3 class="text-center">좌석 정보 등록</h3></div>
	<table summary="게시판 리스트" class="table table-striped">
		<thead>
			<tr>
				<th class="text-left col-md-1">좌석번호</th>
				<th class="text-left col-md-1">좌석이름</th>
				<th class="text-left col-md-1">좌석상태</th>
				<th class="text-left col-md-2">좌석연령</th>
			</tr>
		</thead>
		
		<tbody id="list" class="table-striped">
			<!--데이터 출력 -->
			<tr>
				<td class="text-left"><input type="text" name="seat_num" id="seat_num" class="form-control" /></td>
				<td class="text-left"><input type="text" name="seat_name" id="seat_name" class="form-control" /></td>
				<td class="text-left"><input type="text" name="seat_status" id="seat_status" class="form-control" /></td>
				<td class="text-left"><input type="text" name="seat_age" id="seat_age"  class="form-control" /></td>
				<td class="goDetail"><button id = "write">write</button></td>
			</tr>

		</tbody>
		
	</table>
	</form>
	
</div> 
			<div class="text-right">
				<button type="button" id="back" class="btn btn-primary btn-sm">뒤로가기</button>
			</div>

		
		
</body>

