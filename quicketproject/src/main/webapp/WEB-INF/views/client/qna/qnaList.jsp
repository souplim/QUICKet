<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

<style type="text/css">
	div.qnaNotice{height: 150px; background-color: #EAEAEA; margin-top: 10px;}
	div.topArea{display:flex;}
	div.countArea{margin-top: 30px;}
	div.insertBtn{margin-top: 15px; margin-botton:0px;}
</style>


<script type = "text/javascript">
		$(function(){
			/* 글쓰기 버튼 클릭시 처리 이벤트 */
			$("#q_insertBtn").click(function(){
				let id ="${userLogin.u_id}";
				if(id != ""){
					location.href = "/qna/qnaWriteForm"; 
					
				} else{
					alert("로그인 후 서비스를 이용하실 수 있습니다.");
					location.href = "/user/login"; 
				}
				
				//location.href = "/qna/qnaWriteForm"; 
				
				});
			
			/* 제목 클릭시 상세 페이지 이동을 위한 처리 이벤트 */
			$(".goDetail").click(function(){
				let q_no = $(this).parents("tr").attr("data-num");
				$("#q_no").val(q_no);
				console.log("글번호 : "+q_no);
				
				$("#q_detailForm").attr({
					"method":"get",
					"action":"/qna/qnaDetail"
				});
				$("#q_detailForm").submit();
			});
			
			
			$(".paginate_button a").click(function(e){
				e.preventDefault();
				$("#page_form").find("input[name='pageNum']").val($(this).attr("href"));
				goPage();
			});

		}); // $함수 종료문	
		
		function goPage(){
			$("#page_form").attr({
				"method":"get",
				"action":"/qna/qnaList"
			});
			$("#page_form").submit();
		}
	</script>

	</head>
	<body>

	<div class="contentContainer container">

		<form id="q_detailForm">
			<input type="hidden" id="q_no" name="q_no"/>
		</form>
		
		<form id= "page_form" name="page_form">
			<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum}">
			<input type="hidden" name="amount" id="amount" value="${pageMaker.cvo.amount }">
		</form>
	
		<%-- ================= 리스트 시작 ================ --%>
		<div id="qnaList" class="table-height">
			<div class="qnaNotice">
				<div id="noticeText">
				게시판 운영 규정에 어긋난다고 판단되는 게시글은 사전 통보없이 블라인드 처리될 수 있습니다. <br/>
				특히 티켓 매매 및 양도의 글은 발견 즉시 임의 삭제되며 전화번호, 이메일 등의 개인정보는 악용될 우려가 있으므로 게시를 삼가 주시기 바랍니다. <br/>
				사전 경고에도 불구하고 불량 게시물을 계속적으로 게재한 게시자의 경우 인터파크 티켓 게시판 작성 권한이 제한됩니다. </div>
			</div>
			<%-- 글쓰기 버튼 --%>
				<div class="topArea">
					<div class="countArea col-md-8">총 ${count}개의 문의글이 등록되었습니다.</div>
					<div class="insertBtn text-right col-md-4"> <input type="button" value="글쓰기" id="q_insertBtn" class= "btn btn-primary"></div>
				</div>
			
			<table summary="게시판 리스트" class="table table-striped table-hover active table-condensed">
				<thead>
					<tr>
						<th data-value="q_no" class="order text-center col-md-2"></th>
						<th class="text-center col-md-5"></th>
						<th class="text-center col-md-1"></th>
						<th data-value="q_regdate" class="order col-md-1"></th>	
					</tr>
				</thead>
				<tbody id="list" class="table-striped">
					<!-- 데이터 출력 -->
					<c:choose>
						<c:when test="${not empty qnaList}">
							<c:forEach var="qna" items="${qnaList}" varStatus="status">
								<tr class="text-center" data-num="${qna.q_no }">
									<td>${qna.q_no}</td>
									<td class="goDetail text-left">${qna.q_title }
										<c:if test="${qna.q_cnt > 0}">
											<span class="reply_count">[${qna.q_cnt}]</span>
										</c:if>
									</td>  
									<td class="id text-right">${qna.u_id }</td>
									<td class="text-center">${qna.q_regdate}</td>
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
		
			
			<%-- 페이징 --%>
			<div class="text-center">
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">
						<li class="paginate_button previous">
							<a href="${pageMaker.startPage - 1 }">Previous</a>
						</li>
					</c:if>	
					<c:forEach var="num" begin="${pageMaker.startPage}"
										 end = "${pageMaker.endPage}">
						<li class="paginate_button ${pageMaker.cvo.pageNum == num ? 'active':''}">  
						<!-- pageMaker의 cvo의 pageNum이 반복문의 num과 일치하는가? true : 'active', false: ' ' -->
							<a href="${num}">${num}</a>
						</li>
					</c:forEach>
					<c:if test="${pageMaker.next}">
						<li class="paginate_button next">
							<a href = "${pageMaker.endPage + 1 }">Next</a>
						</li>		
					</c:if>
				</ul>
			</div>
			
		</div>
		
 	</body>
</html>
