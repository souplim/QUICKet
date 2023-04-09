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
		
		/* writeBtn 버튼 클릭 시 처리 이벤트 */
		$("#write").click(function(){
			$("#insertForm").attr({
				"method":"post",
				"action":"/admin/ticket/hall_write"
			});
			$("#insertForm").submit();
		});
	
	}); // $ 함수 종료문
	
	/* 검색을 위한 실질적인 처리 함수 */
</script>
</head>
<body>
<div class="contentContainer container">
<form id="insertForm">
		<input type="hidden" id="th_num" name="th_num" value = "${th_numValue.th_num}"/>
		<input type="hidden" id="s_num" name="s_num" value = "${th_numValue.s_num}"/>
		
<div class="contentTit page-header"><h3 class="text-center">예매 정보 등록</h3></div>
 	<table class="table table-striped">
		<tr>
			<td class="text-left col-md-1"><h4>공연관 종류</h4></td>
			<td class="text-left col-md-2">1관, 2관, 3관</td>
			<td class="text-left col-md-1"><h4>공연회차 종류</h4></td>
			<td class="text-left col-md-2">1회차, 2회차, 3회차</td>
		</tr>
		<tr>
			<td class="text-left col-md-1"><h4>좌석수 종류</h4></td>
			<td class="text-left col-md-2">30, 40, 50</td>
		</tr>
	</table> 
	<table summary="게시판 리스트" class="table table-striped">
		<thead>
			<tr>
				<th class="text-left col-md-1">공연관</th>
				<th class="text-left col-md-2">공연회차</th>
				<th class="text-left col-md-2">공연시간</th>
				<th class="text-left col-md-1">좌석수</th>
				<th class="text-left col-md-2">예매 날짜</th>
				<th class="text-left col-md-2">예매 시작</th>
				<th class="text-left col-md-2">예매 종료</th>
			</tr>
		</thead>
		
		<tbody id="list" class="table-striped">
			<!--데이터 출력 -->
			<tr>
				<td class="text-left"><input type="text" name="hall_place" id="hall_place" class="form-control" /></td>
				<td class="text-left"><input type="text" name="hall_turn" id="hall_turn"class="form-control" /></td>
				<td class="text-left"><input type="text" name="hall_time" id="hall_time"  class="form-control" /></td>
				<td class="text-left"><input type="text" name="hall_seatNum" id="hall_seatNum" class="form-control" /></td>
				<td class="text-left"><input type="text" name="hall_date" id="hall_date" class="form-control" /></td>
				<td class="text-left"><input type="text" name="hall_start" id="hall_start"  class="form-control" /></td>
				<td class="text-left"><input type="text" name="hall_end" id="hall_end" class="form-control" /></td>
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

