<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>


	<script type="text/javascript">
		$(function(){
			/* 검색 후 검색 대상과 검색 단어 출력 그래돌 단어가 남는다 */
			let word="<c:out value='${faqVO.keyword}' />";
			let value="";
			if(word!=""){
				$("#keyword").val("<c:out value='${faqVO.keyword}' />");
				$("#search").val("<c:out value='${faqVO.search}' />");
				
			
				/*if($("#search").val()!='f_content'){
					//:contains()는 특정 텍스트를 포함한 요소반환 	
					if($("#search").val()=='f_title') value = "#list tr td.goDetail";
					else if($("#search").val()=='f_content') value="#list tr td.name";
					console.log($(value+":contains('"+word+"')").html());
					//$("#list tr td.goDetail:contains('노력')").html() => <span class='required'>노력</span>에 대한 명언
			    	$(value+":contains('"+word+"')").each(function () {
						let regex = new RegExp(word,'gi');
						$(this).html($(this).html().replace(regex,"<span class='required'>"+word+"</span>"));
			    	});
				}*/
			}
			
			/* 입력 양식 enter 제거 */
			$("#keyword").bind("keydown", function(event){
				 if (event.keyCode == 13) {
				        event.preventDefault();
				    }
			});
			
			/* 검색 대상이 변경될 때마다 처리 이벤트 */
			$("#search").change(function() {
				if($("#search").val()=="all"){
					$("#keyword").val("전체 데이터 조회합니다.");
				}else if($("#search").val()!="all"){
					$("#keyword").val("");
					$("#keyword").focus();
				}
			});

			

			/* 검색 버튼 클릭 시 처리 이벤트 */
			$("#searchData").click(function(){
				if($("#search").val()!="all"){ // 제목/내용/작성자 선택시 검색어 유효성 체크
					if(!chkData("#keyword","검색어를")) return;
				}
				$("#pageNum").val(1);
				goPage();
			});
			
		
			/* 제목 클릭시 상세 페이지 이동을 위한 처리 이벤트 	 */
			
			$(".goDetail").click(function(){
				let f_no =  $(this).parents("tr").attr("data-num");	
				$("#f_no").val(f_no);
				console.log("글번호 : "+f_no);
				// 상세 페이지로 이동하기 위해 form 추가 (id : detailForm) 
				$("#detailForm").attr({
					"method":"get",
					"action":"/faq/faqDetail"
				});
				$("#detailForm").submit(); 
			});
			
			
			
			//페이지 처리 위해 처리
			$(".paginate_button a").click(function(e) {
				 e.preventDefault();
				 $("#f_search").find("input[name='pageNum']").val($(this).attr("href"));
				 goPage();
			});
			
			
			
		}); // $ 함수 종료문*/
		
		/* 검색을 위한 실질적인 처리 함수 */
		function goPage(){
			if($("#search").val()=="all"){
				$("#keyword").val("");
			} 

			$("#f_search").attr({
				"method":"get",
				"action":"/faq/faqList"
			});
			$("#f_search").submit();
		}
				
		
		function chkData(item, msg){
			if($(item).val().replace(/\s/g,"")==""){
				alert(msg+" 입력해 주세요.");
				$(item).val("");
				$(item).focus();
				return false;
			}else{
				return true;
			}
		}
	</script>
</head>
<body>
	<div class="contentContainer container">
	<div class="contentTit page-header"><h3 class="text-center">FAQ 리스트</h3></div>  
	
		
		<form id="detailForm">
			<input type="hidden" id="f_no" name="f_no" />
		</form>
		
		 
		<%-- ============== 검색기능 시작 ====================  --%>
		<div id="faqSearch" class="text-right">
			<form id="f_search" name="f_search" class="form-inline">
			<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum}">
 			<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
				<div class="form-group">
					<label>검색조건</label>
					<select id="search" name="search"  class="form-control">
						<option value="all">전체</option>
						<option value="f_category">카테고리</option>
						<option value="f_title">제목</option>
						<option value="f_content">글내용</option> 
				<!-- 		<option value="f_regdate">등록일</option> -->
					</select>
					<input type="text" name="keyword" id="keyword" value="검색어를 입력하세요" class="form-control" /> <!-- placeholder도가능 -->
			<!-- 	<button type="button" id="searchData" class="btn btn-success">검색</button>  -->	
					<button type="button" id="searchData" class="btn btn-primary">검색</button>
					
				</div>
			</form>
		</div>
		<%--================== 검색기능 종료 ===================  --%>
		
		
		<%-- =================== 리스트 시작  ================= --%>
		<div id="faqList" class="table-height">
			<table summary="faq 리스트" class="table table-striped" >
				<thead>
					<tr>
						<th data-value="f_no" class="order text-center col-md-1" >글번호</th>
						<th class="text-center col-md-1">카테고리</th>
						<th class="text-center col-md-4">제목</th>
		<!-- 			<th class="text-center col-md-4">내용</th> -->	
						<th data-value="f_regdate" class="order col-md-1">등록일</th>
					</tr>
				</thead>
		 		<tbody id="list" class="table-striped" >
					<!-- 데이터 출력 -->
					<c:choose>
						<c:when test="${not empty faqList}" >
							<c:forEach var="faq" items="${faqList}" varStatus="status">
								<tr class="text-center" data-num="${faq.f_no}">
									<td>${faq.f_no}</td>
									<td class="goDetail text-center">${faq.f_category}</td>
									<td class="goDetail text-center">${faq.f_title}</td>									
				<!-- 					<td class="name">${faq.f_content}</td> -->
									<td class="text-left">${faq.f_regdate}</td>	
									<!--존재할때    db에 파일명만 들어감  							
									<td>								
										<c:if test="${not empty board.b_thumb}">
											<img src="/uploadStorage/board/thumbnail/${board.b_thumb}" />
										</c:if>
									<!--존재하지 않을때  
										<c:if test="${empty board.b_thumb}">
											<img src="/resources/images/common/noimage.png" />
										</c:if>
									</td>  -->	
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="6" class="tac text-center">등록된 게시글이 존재하지 않습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody> 
			</table>
		</div>
		<%-- =================== 리스트 종료  ================= --%>
		
		 <%-- ============== 페이징 출력 시작 =========== --%>
		 <div class="text-center">
			<ul class="pagination">
			
			 <c:if test="${pageMaker.prev}">
			 <li class="paginate_button previous">
			 <a href="${pageMaker.startPage -1}">Previous</a>
			 </li>
			 </c:if>
			 <c:forEach var="num" begin="${pageMaker.startPage}" 
			end="${pageMaker.endPage}">
			 <li class="paginate_button ${pageMaker.cvo.pageNum == num ? 'active':''}">
			 <a href="${num}">${num}</a>
			 </li>
			 </c:forEach>
			 <c:if test="${pageMaker.next}">
			<li class="paginate_button next">
			<a href="${pageMaker.endPage +1 }">Next</a>
			</li>
			</c:if> 
			 </ul>
		 </div> 
 		<%-- ============== 페이징 출력 종료 ============= --%>

		<%-- ================== 글쓰기 버튼 출력 시작 ============= 
		<div class="contentBtn  text-right">
			<input type="button" value="글쓰기" id="insertFormBtn" class="btn btn-success">
		</div>
		<%-- ================== 글쓰기 버튼 출력 종료 ============= --%>
	</div>
</body>
</html>