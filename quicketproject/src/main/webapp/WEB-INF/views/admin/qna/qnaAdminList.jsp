<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

	<script type="text/javascript">
		$(function(){
			/* 검색 후 검색 대상과 검색 단어출력*/
			let word = "<c:out value='${qnaVO.keyword}' />";	// qnaVO는 컨트롤러에서 받아온것. 처음에 modelAttribute에 "data"라고 이름을 줘서 못 받아옴 (이경우 ${data.keyword}라고 했어야)
			let value = "";
			let search = "<c:out value='${qnaVO.search}' />";
			let start_date = "<c:out value='${qnaVO.start_date}' />";
			let end_date = "<c:out value='${qnaVO.end_date}' />";
			
			if(word != ""){
				$("#keyword").val("<c:out value='${qnaVO.keyword}' />");	//keyword 입력창에 입력한 qnaVo.keyword 단어가 출력
				$("#search").val("<c:out value='${qnaVO.search}' />");
				
				/* if($("#search").val()!='q_content'){	// q_content는 리스트 화면에서 보여지지 않으므로 제외
					if($("#search").val()=='q_title') value = "#list tr td.goDetail";	//"#list tr td.goDetail"라는 공간을 value에 담음
					else if($("#search").val()=='u_id') value="#list tr td.id";
					console.log($(value+":contains('"+word+"')").html());
					
					$(value+":contains('"+word+"')").each(function(){	// value+":contains('"+word+"')" : value,word는 변수라 밖으로 뺌. :contains(함수) value(공간)에 word가 포함되어 있을때 함수 각각 반복실행
						let regex = new RegExp(word, 'gi');	// g: 발생할 모든 패턴에 대한 전역검색, i:대소문자 구분X
						$(this).html($(this).html().replace(regex, "<span class='required'>"+word+"</span>"));
						// common.jspf -> default.css에 .required:빨간색표시 정의해놨음. word 앞뒤에 <span class='required'></span> : word에 .required 적용시키겠다
						});
					} */
				}
			
			if(search!="q_regdate"){
				console.log("textCheck 검색");
				$("#dateCheck").hide();
				var date = getDateFormat(new Date());
				$("#start_date").val(date);
				$("#end_date").val(date);
			} else {
				console.log("dateCheck 검색");
				$('#search').val(search);
				$('#textCheck').hide();
				$('#start_date').val(start_date);
				$("#end_date").val(end_date);
			}
			
			
				
				/* 입력 양식 enter 제거 */
				$("#keyword").bind("keydown", function(event){
					if(event.keyCode === 13) {
						event.preventDefault();
					}
				});
				
				/* 검색 대상 변경될 때마다 처리 이벤트 */
				$("#search").change(function(){
					if($('#search').val()!="q_regdate"){
						$('#dateCheck').hide();
						$('#textCheck').show();
						
						if($("#search").val()=="all"){
							$("#keyword").val("전체 데이터를 조회합니다.");
						} else if($("#search").val()!="all"){
							$("#keyword").val("");
							$("#keyword").focus();
							}
					}
					if($('#search').val()=="q_regdate"){
						$('#textCheck').hide();
						$('#dateCheck').show();
						}

				});
				
				/* 검색 버튼 클릭시 처리 이벤트 */
				$("#searchBtn").click(function(){
					if($("#search").val() != "q_regdate"){
						if(!chkData("#keyword", "검색어를")) return;
					} else if($('#search').val()=="q_regdate"){
						if(!chkSubmit($('#start_date'),"시작날짜를")) return;
						else if(!chkSubmit($('#end_date'),"종료날짜를")) return;
						else if($('#start_date').val()>$('#end_date').val()){
							alert('시작날짜가 종료날짜보다 더 클 수 없습니다.');
							return;
						}	
					}
					$("#pageNum").val(1);	// ex) 5페이지에서 검색하고 있었을 경우 첫페이지에 떠야하므로 페이지번호를 1로 설정
					goPage();
				});
				
				/* 제목 클릭시 상세페이지로 이동  
				$(".goDetail").click(function(){
					let q_no = $(this).parents("tr").attr("data-no");
					$("#q_no").val(q_no);
					console.log("글번호 : "+q_no);
					
					$("#q_detailForm").attr({
						"method":"get",
						"action":"/admin/qnaAdminDetail"
					});
					$("#q_detailForm").submit();
				}); */
				
				/* 조회 클릭 시 상세페이지로 이동 */
				$(".detailBtn").click(function(){
					let q_no = $(this).parents("tr").attr("data-no");
					$("#q_no").val(q_no);
					console.log("글번호 : "+q_no);
					
					$("#q_detailForm").attr({
						"method":"get",
						"action":"/admin/qna/qnaAdminDetail"
					});
					$("#q_detailForm").submit();
				}); 
				
				/* 삭제 클릭시 게시글 삭제  */
				$(".delBtn").click(function(){
					let q_no = $(this).parents("tr").attr("data-no");
					$("#q_no").val(q_no);
					
					$("#q_detailForm").attr({
						"method":"get",
						"action":"/admin/qna/qnaDelete"
					});
					//console.log("q_no :"+$("#q_no").val());
					$("#q_detailForm").submit();
				}) 
				
				$(".paginate_button a").click(function(e){
					e.preventDefault();
					$("#q_search").find("input[name='pageNum']").val($(this).attr("href"));
					goPage();
				});
		});
		
		/* 검색을 위한 함수 */
		function goPage(){
			if($("#search").val()=="all"){
				$("#keyword").val("");
			}
			
			
			$("#q_search").attr({
				"method":"get",
				"action":"/admin/qna/qnaAdminList"
			});
			$("#q_search").submit();
		}
	</script>

</head>
<body>
	<div class="contentContainer container">

		<form id="q_detailForm">
			<input type="hidden" id="q_no" name="q_no"/>
		</form>
		
		
		<%-- 검색 기능 시작 --%> <%-- 검색시 페이지번호도 필요하기 때문에 같은 form에 넣고 같이 가져가는게 좋아서 같이 넣었음 --%>
		<div id="boardSearch" class="text-right">
			<form id="q_search" name="q_search" class="form-inline">
				<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum}">
				<input type="hidden" name="amount" id="amount" value="${pageMaker.cvo.amount }">
				<div class="form-group">
					<label>검색조건</label>
					<select id="search" name="search" class="form-control">
						<option value="all">전체</option>
						<option value="q_title">제목</option>
						<option value="q_content">내용</option>
						<option value="u_id">작성자</option>
						<option value="q_regdate">작성일자</option>
					</select>

				</div>
				<div class="form-group" id="textCheck">
					<input type="text" name="keyword" id="keyword" value="검색어를 입력하세요" class="form-control"/>	
				</div>
				<div class="form-group" id="dateCheck">
					<input type="date" name="start_date" id="start_date" class="form-control" placeholder="시작일자"/>
					<input type="date" name="end_date" id="end_date" class="form-control" placeholder="종료일자"/>
				</div>
				<button type="button" id="searchBtn" class="btn btn-primary">검색</button>
				<!-- <button type="button" id="allSearchBtn" class="btn btn-primary">전체검색</button>  -->
			</form>
		</div>
		
		<%-- ================= 리스트 시작 ================ --%>
		<div id="qnaList" class="table-height">
	
			<div>총 문의글 개수는 ${count}개 입니다. </div>
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
								<tr class="text-center" data-no="${qna.q_no }">
									<td>${qna.q_no }</td>
									<td class="goDetail text-left">${qna.q_title }
										<c:if test="${qna.q_cnt > 0}">
											<span class="reply_count">[${qna.q_cnt}]</span>
										</c:if>
									</td>  
									<td class="id text-right">${qna.u_id }</td>
									<td class="date text-right">${qna.q_regdate}</td>
									<td>
										<button type="button" id="detailBtn" name="detailBtn" class="detailBtn btn btn-danger btn-sm">조회</button>
										<button type="button" id="delBtn" name="delBtn" class="delBtn btn btn-danger btn-sm">삭제</button>
									</td>
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
		</div>
 	</body>
</html>