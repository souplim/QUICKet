<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"  %>
	
	<style type="text/css">
		.contentBtn { margin-bottom: 20px; }
		.btn-blue {
			background-color: dodgerblue;
			color: #fff;
		}
	</style>
	
	<script type="text/javascript">
		$(function(){
			/* 1대1문의하기 버튼 클릭시 처리 이벤트 */
			$("#insertFormBtn").on("click",function(){
				location.href="/inq/inqWriteForm";
			});
			
			/* 제목 마우스오버 시 밑줄 */
			$(".goDetail").hover(function(){
				$(this).css("textDecoration","underline");
			}, function(){
				$(this).css("textDecoration","none");
			});
			
			/* 제목 클릭시 상세 페이지 이동을 위한 처리 이벤트 */
			$(".goDetail").click(function(){
				let i_num = $(this).parents("tr").attr("data-num");
				$("#i_num").val(i_num);
				console.log("글번호:"+i_num);
				// 상세 페이지로 이동하기 위해 form 추가(id: dataForm)
				$("#dataForm").attr({
					"method" : "get", 
					"action" : "/inq/inqDetail"
				});
				$("#dataForm").submit();
				
			});
			
			/* 페이징 처리 이벤트 */
			$(".paginate_button a").click(function(e){
				e.preventDefault(); // a태그 -> href로 이동하는 성격 해제
				// dataForm 폼 하위 pageNum을 이름으로 가지는 input의 값을 클릭한 번호
				$("#pageForm").find("input[name='pageNum']").val($(this).attr("href"));
				
				// pageNum을 들고 다시 페이지 list 부르기
				$("#pageForm").attr({
					"method" : "get",
					"action" : "/inq/inqList"
				});
				$("#pageForm").submit();
			});
			
		});
	</script>
	</head>
	<body>
		<div class="contentContainer container">
			<%-- ================= 데이터 전달 폼 ================= --%>
			<form name="dataForm" id="dataForm">
				<input type="hidden" name="i_num" id="i_num">
			</form>
			
			<form name="pageForm" id="pageForm">
				<!-- 페이징 처리를 위한 파라미터 -->
				<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum}"/>
				<input type="hidden" name="amount" id="amount" value="${pageMaker.cvo.amount}"/>
			</form>
			
			
			<div>
				<h1>1:1 문의내역</h1>
				<p>고객님이 문의하신 질문과 답변내용을 확인하실 수 있습니다.</p>
			</div>
			
			<%-- ================= 1대1문의하기 버튼 시작 ================= --%>
			<div class="contentBtn text-right">
				<button type="button" id="insertFormBtn" class="btn btn-blue">1대1 문의하기</button>
			</div>
			
			<%-- ================= 리스트 시작 ================= --%>
			<div id="inqList" class="table-height">
				<table summary="게시판 리스트" class="table">
					<thead>
						<tr>
							<th data-value="i_num" class="order text-center col-md-1">글번호</th>
							<th class="text-center col-md-2">카테고리</th>
							<th class="text-center col-md-5">제목</th>
							<th data-value="i_regidate" class="order text-center col-md-2">작성일</th>
							<th class="text-center col-md-2">답변현황</th>
						</tr>
					</thead>
					<tbody id="list" class="table-striped">
						<!-- 데이터 출력 -->
						<!-- <c:if test=""></c:if> ${inq.u_id} 세션아이디와 작성자아이디가 같을 경우 출력 -->
						<c:choose>
							<c:when test="${not empty inqList}">
								<c:forEach var="inq" items="${inqList}" varStatus="status">
									<tr class="text-center" data-num="${inq.i_num}">
										<!-- 새로 번호 부여 상태변수.index: 0부터 시작-->
										<td>${count - status.index}</td> 
										<%-- <td>${inq.i_num}</td> --%>
										<td>${inq.i_category} > ${inq.i_cate_detail}</td>
										<td class="text-center goDetail">${inq.i_title}</td>
										<td>${inq.i_regidate}</td>
										<td>
											<c:if test="${inq.i_reply==0}">답변 대기중</c:if>
											<c:if test="${inq.i_reply==1}">답변 완료</c:if>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="6" class="tac text-center">등록된 문의글이 존재하지 않습니다.</td>
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