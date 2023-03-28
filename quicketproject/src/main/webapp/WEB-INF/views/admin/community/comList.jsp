<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

	<style type="text/css">
		#comSearch { margin-bottom : 30px;}
		
		.pagination {display: inline-block; }
		.pagination>li>a, .pagination>li>span { color : #31708f; }
		.pagination a { float: left; padding: 8px 16px; text-decoration: none; }
		.pagination>.active>a { background-color: #5bc0de; color: white; border-color : #46b8da; }
		.pagination>.active>a:hover { background-color: #d9edf7; border-color : #bce8f1; color : #31708f; }
		.pagination a:hover:not(.active) {background-color: #bce8f; color : #31708f;} 

		img {width : 70px;}
		#order { width : 110px; }
		#orderDiv{width : 150px; float:left;}
		.contentBtn {margin-bottom: 20px; }
	</style>

	<script type="text/javascript">
	</script>
	
	
	</head>
	<body>
		<div class="contentContainer container">
			<!-- <div class="contentTit page-header"><h3 class="text-center">게시판 리스트</h3></div>  -->
			<form name="detailForm"id="detailForm">
				<input type="hidden"name="b_num"id="b_num"/>
			</form>

			
			<%-- ========== 검색 기능 시작 ========== --%>
			<div id="comSearch" class="text-right">
				
				<form id="f_search" name="f_search" class="form-inline">

					<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum }">
					<input type="hidden" name="amount" id="amount" value="${pageMaker.cvo.amount }">
					
					<span class="text-left" id="orderDiv">
				
						<select id="orderVal" name="orderVal" class="form-control">
								<option value="num" id="num">번호순</option>
								<option value="title" id="title">공연명순</option>
								<option value="expect" id="expect" >기대평순</option>
								<option value="review" id="review" >관람후기순</option>
								<option value="qna" id="qna" >QnA순</option>
						</select>	
					</span>
					
										
					<div class="form-group">						
						<input type="text" name="keyword" id="keyword" placeholder="검색어를 입력하세요." class="form-control"/>
						<button type="button" id="searchData" class="btn btn-info">검색</button>
					</div>
				</form>
			</div>
			<%-- ========== 검색 기능 종료 ========== --%>
			
			<%-- ========== 리스트 시작 ========== --%>
			<div id="boardList" class="table-height">
				<table summary="게시판 리스트" class="table table-striped">
					<thead>
						<tr>
							<th data-value="b_num" class="order text-center col-md-1">글번호</th>
							<th class="text-center col-md-4">글제목</th>
							<th class="text-center col-md-2">작성자</th>
							<th data-value="b_date" class="order col-md-1">작성일</th>
							<th class="text-center col-md-1">조회수</th>
							<th class="text-center col-md-2">이미지</th>
						</tr>
					</thead>
					<tbody id="list" class="table-striped">
						<!--  데이터 출력  -->
						<c:choose>
							<c:when test="${not empty boardList }">
								<c:forEach var="board" items="${boardList}" varStatus="status">
									<tr class="text-center" data-num="${board.b_num }">
										<td>${board.b_num }</td>
										<td class="goDetail text-left">
											${board.b_title }
											<c:if test="${board.r_cnt > 0 }">
												<span class="required"><small> [${board.r_cnt}]</small></span>
											</c:if>
										</td>
										<td class="name">${board.b_name }</td>
										<td class="text-left">${board.b_date }</td>
										<td class="text-center">${board.readcnt }</td>
										<td>
											<c:if test="${not empty board.b_thumb }">
												<img src="/uploadStorage/board/thumbnail/${board.b_thumb}" />
											</c:if>
											<c:if test="${empty board.b_thumb }">
												<img src="/resources/image/common/noimage.png" />
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="5" class="tac text-center">등록된 게시글이 존재하지 않습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>	
					</tbody>
				</table>
			</div>
			<%-- ========== 리스트 종료 ========== --%>
			<%-- ========== 페이징 출력 시작 ========== --%>
			<div class="text-center">
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">
						<li class="paginate_button previous">
							<a href="${pageMaker.startPage - 1}">&laquo;</a>
						</li>
					</c:if>
					<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
						<li class="paginate_button ${pageMaker.cvo.pageNum == num ? 'active':''}">
							<a href="${num}">${num}</a>
						</li>
					</c:forEach>
					<c:if test="${pageMaker.next}">
						<li class="paginate_button next">
							<a href="${pageMaker.endPage + 1}">&raquo;</a>
						</li>
					</c:if>
				</ul>
			</div>
			<%-- ========== 페이징 출력 종료 ========== --%>
			
		</div>
	</body>
</html>