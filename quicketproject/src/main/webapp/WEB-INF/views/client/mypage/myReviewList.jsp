<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"  %>

	<style type="text/css">
		.communityTitle { margin-bottom: 30px; }
	</style>
	
	<script type="text/javascript">
		$(function(){
			
			/* 페이징 처리 이벤트 */
			$(".paginate_button a").click(function(e){
				e.preventDefault(); // a태그 -> href로 이동하는 성격 해제
				// dataForm 폼 하위 pageNum을 이름으로 가지는 input의 값을 클릭한 번호
				$("#pageForm").find("input[name='pageNum']").val($(this).attr("href"));
				
				// 폼태그 안 데이터 들고 다시 페이지 list 부르기
				$("#pageForm").attr({
					"method" : "get",
					"action" : "/mypage/myReviewList"
				});
				$("#pageForm").submit();
			});
		});
	</script>
	</head>
	<body>
		<div class="contentContainer container">
			<%-- ================= 데이터 전달 폼 ================= --%>
			<form name="pageForm" id="pageForm">
				<!-- 페이징 처리를 위한 파라미터 -->
				<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum}"/>
				<input type="hidden" name="amount" id="amount" value="${pageMaker.cvo.amount}"/>
			</form>
			
			<div class="communityTitle">
				<h1>관람후기 모음</h1>
				<p>
					고객님께서 남겨주신 관람후기를 확인할 수 있습니다.<br/>
					QUICKet 운영정책에 위반되거나, 관람후기의 성격에 맞지 않는 글은 고객님께 사전통보 없이 삭제될 수 있습니다.
				</p>
			</div>
			
			<%-- ================= 리스트 시작 ================= --%>
			<div id="qnaList" class="table-height">
				<table summary="Q&A 리스트" class="table">
					<thead>
						<tr>
							<th class="text-center col-md-4">공연명</th>
							<th class="text-center col-md-4">제목</th>
							<th class="text-center col-md-2">별점</th>
							<th data-value="i_regidate" class="order text-center col-md-2">작성일</th>
						</tr>
					</thead>
					<tbody id="list">
						<!-- 데이터 출력 -->
						<!-- <c:if test=""></c:if> ${inq.u_id} 세션아이디와 작성자아이디가 같을 경우 출력 -> 컨트롤러에서 제어 -->
						<c:choose>
							<c:when test="${not empty reviewList}">
								<c:forEach var="review" items="${reviewList}" varStatus="status">
									<tr class="text-center" data-num="${review.r_no}" data-snum="${review.s_num}">
										<!-- 새로 번호 부여 상태변수.index: 0부터 시작-->
										<%-- <td>${count - status.index}</td>  --%>
										<td class="text-center">${review.s_name}</td>
										<td class="goDetail">
											<a href="/showDetail?s_num=${review.s_num}#reviewBox">${review.r_title}</a>
										</td>
										<td>
											<c:forEach var="i" begin="0" end="${review.r_point-1}">
												<span class="glyphicon glyphicon-star" aria-hidden="true"></span>
											</c:forEach>
											<c:if test="${review.r_point < 5}">
												
												<c:forEach var="i" begin="0" end="${4-review.r_point}">
													<span class="glyphicon glyphicon-star-empty" aria-hidden="true"></span>
												</c:forEach>
											</c:if>
										</td>
										<td>${review.r_regdate}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="3" class="tac text-center">등록된 관람후기가 존재하지 않습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			
			<%-- ================= 페이징 출력 시작 ================= --%>
			<div class="text-center">
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
			</div>
		
		</div>
	</body>
</html>