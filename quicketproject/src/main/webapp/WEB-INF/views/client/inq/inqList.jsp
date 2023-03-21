<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"  %>

	<script type="text/javascript">
		$(function(){
			/* 1대1문의하기 버튼 클릭시 처리 이벤트 */
			$("#insertFormBtn").on("click",function(){
				location.href="/inq/inqWriteForm";
			});
		});
	</script>
	</head>
	<body>
		<div class="contentContainer container">
			
			<form name="dataForm" id="dataForm">
				<input type="hidden" name="i_num" id="i_num">
			</form>
			
			<div>
				<h1>1:1 문의내역</h1>
				<p>고객님이 문의하신 질문과 답변내용을 확인하실 수 있습니다.</p>
			</div>
			
			<%-- ================= 1대1문의하기 버튼 시작 ================= --%>
			<div class="contentBtn text-right">
				<button type="button" id="insertFormBtn" class="btn btn-primary">1대1 문의하기</button>
			</div>
			
			<%-- ================= 리스트 시작 ================= --%>
			<div id="inqList" class="table-height">
				<table summary="게시판 리스트" class="table table-striped">
					<thead>
						<tr>
							<th data-value="i_num" class="order text-center col-md-1">글번호</th>
							<th data-value="b_date" class="order col-md-2">작성일</th>
							<th class="text-center col-md-2">카테고리</th>
							<th class="text-center col-md-4">제목</th>
							<th class="text-center col-md-2">작성자</th>
							<th class="text-center col-md-1">답변현황</th>
						</tr>
					</thead>
					<tbody id="list" class="table-striped">
						<!-- 데이터 출력 -->
						<%-- <c:choose>
							<c:when test="${not empty boardList}">
								<c:forEach var="board" items="${boardList}" varStatus="status">
									<tr class="text-center" data-num="${board.b_num}">
										<td>${board.b_num}</td>
										<td class="goDetail text-left">${board.b_title}
											<c:if test="${board.r_cnt > 0}"> <!-- 댓글 수 1 초과일 때만 출력 -->
												<span class="reply_count">&nbsp;[${board.r_cnt}]</span>
											</c:if>
										</td>
										<td class="name">${board.b_name}</td>
										<td class="text-left">${board.b_date}</td>
										<td class="text-center">${board.readcnt}</td>
										<td>
											<c:if test="${not empty board.b_thumb}">
												<img src="/uploadStorage/board/thumbnail/${board.b_thumb}" />
											</c:if>
											<c:if test="${empty board.b_thumb}">
												<img src="/resources/images/common/noimage.png" />
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="6" class="tac text-center">등록된 게시글이 존재하지 않습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose> --%>
					</tbody>
				</table>
			</div>
			
			<%-- ================= 페이징 출력 시작 ================= --%>
			<%-- <div class="text-center">
				<ul class="pagination">
					<!-- 이전 바로가기 10개 존재 여부를 prev 필드의 값으로 확인 -->
					<c:if test="${pageMaker.prev}">
						<li class="paginate_button previous">
							<a href="${pageMaker.startPage -1}">Previous</a>
						</li>
					</c:if>
					
					<!-- 바로가기 번호 출력 -->
					<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
						<!-- 현재 페이지 색깔 : 현재 보고 있는 페이지와 for문으로 돌리고 있는 페이지가 일치하면 class='active' 적용 -->
						<li class="paginate_button ${pageMaker.cvo.pageNum == num ? 'active':''}">
							<a href="${num}">${num}</a>
						</li>
					</c:forEach>
					
					<!-- 다음 바로가기 10개 존재 여부를 next 필드의 값으로 확인 -->
					<c:if test="${pageMaker.next}">
						<li class="paginate_button next">
							<a href="${pageMaker.endPage+1}">Next</a>
						</li>
					</c:if>
				</ul>
			</div> --%>
			
		</div>	
	</body>
</html>