<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/WEB-INF/views/common/common.jspf" %>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix= "fn" uri= "http://java.sun.com/jsp/jstl/functions" %>
	<script type="text/javascript">
	$(function(){
		
		/* 글쓰기 버튼 클릭 시 처리 이벤트 */		
		$("#insertFormBtn").click(function(){
			location.href = "/admin/ticket/hall_writeForm"; 
		});
		
		/* 제목 클릭시 상세 페이지 이동을 위한 처리 이벤트 */		
		$(".goDetail").click(function(){
			//let num = $(this).parents("tr").children().eq(0).html();
			// 이벤트가 발생한 자기 자신. 자신을 포함한 부모 요소중 tr을 찾아 trdㅢ 속성인 data-num의 값을 읽ㅇ옴
			let th_num = $(this).parents("tr").attr("data-num");
			$("#th_num").val(th_num);
			console.log("글번호 : "+th_num);
			$("#detailForm").attr({
				"method":"get",
				"action":"/admin/ticket/hall_updateForm"
			});
			$("#detailForm").submit();
		})
	
		
	}); // $ 함수 종료문
	
	/* 검색을 위한 실질적인 처리 함수 */
</script>
</head>
<body>
	<div class="contentContainer container">
	<form id="detailForm">
		<input type="hidden" id="th_num" name="th_num"/>
	</form>
		<div class="contentTit page-header"><h3 class="text-center">공연 리스트</h3></div>
		<%-- ============== 검색기능 시작 ====================  --%>
		<%--================== 검색기능 종료 ===================  --%>	
		<%-- ==========리스트시작================== --%>
		<div id="hall_list" class="table-height"> 
			<table summary="게시판 리스트" class="table table-striped">
				<thead>
					<tr>
						<th data-value="th_num" class="order text-left col-md-1">ID</th>
						<th class="text-left col-md-2">공연명</th>
						<th class="text-left col-md-3">공연장</th>
						<th class="text-left col-md-2">관람시작날짜</th>
						<th class="text-left col-md-2">관람종료날짜</th>
						<th class="text-left col-md-1">일차이</th>
						<th class="text-left col-md-1">데이터 개수</th>
					</tr>
				</thead>
				<tbody id="list" class="table-striped">
					<!--데이터 출력 -->
					<c:choose>
						<c:when test="${not empty hall_list}">
							<c:forEach var="hall" items="${hall_list}" varStatus="status">
								<tr class="text-center" data-num="${hall.th_num}">
									<td>${hall.th_num}</td>
									<td class="goDetail text-left">${hall.s_name}</td>
									<td class="text-left">${hall.th_name}</td>
									<td class="text-left">${hall.hall_start}</td>
									<td class="text-left">${hall.hall_end}</td>
									<td class="text-left">${hall.date_gap}</td>
									<td class="text-left">${hall.data_num}</td>
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
		<!-- ========리스트 종료 ==================== -->
		<!-- ========페이징 출력 시작==================== -->
<%-- 		<div class="text-center">
			<ul class="pagination">
				<c:if test="${pageMaker.prev}">
					<li class="paginate_button previous">
						<a href="${pageMaker.startPage - 1}">Previous</a>
					</li>
				</c:if>
				<c:forEach var="num" begin="${pageMaker.startPage}"
									  end="${pageMaker.endPage}">
					<li class="paginate_button ${pageMaker.cvo.pageNum == num ? 'active':''}">
						<a href="${num}" > ${num}</a>
					</li>
				</c:forEach>
				
				<!-- 다음 바로가기 10개 존재 여부를 next 필드의 값으로 확인 -->
				<c:if test="${pageMaker.next}">
					<li class="paginate_button next">
						<a href="${pageMaker.endPage + 1}">Next</a>
					</li>
				</c:if>
			</ul>
		</div> --%>
		<!-- ========페이징 출력 종료================== -->
		
		<!-- ========글쓰기 버튼 출력 시작==================== -->
		<!-- <div class="contentBtn text-right"==>	
			<input type="button" value="글쓰기" id="insertFormBtn" class="btn btn btn-info"/>
		</div> -->
	</div>
</body>

