<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>


<script type="text/javascript">	
		let keyword = "", search = "", start_date = "", end_date = "";
		search = "<c:out value='${data.search}' />";
		start_date = "<c:out value='${data.start_date}' />";	
		end_date = "<c:out value='${data.end_date}' />";
		keyword = "<c:out value='${data.keyword}' />";
		

		$(function(){
			
			
			if(search!="r_regdate"){
				$("#dateCheck").hide();
				var date = getDateFormat(new Date())
				$('#start_date').val(date);
				$('#end_date').val(date);
			}else{
				$("#search").val(search);
				$("#textCheck").hide();
				$('#start_date').val(start_date);
				$('#end_date').val(end_date);
			}
			
			if(keyword!=""){
				$("#search").val(search);
				$("#keyword").val(keyword);
			}
			
			/* 제목 클릭시 상세 페이지 이동을 위한 처리 이벤트 */	
			$(".goDetail").click(function(){
				let r_no =  $(this).parents("tr").attr("data-num");	
				$("#r_no").val(r_no);
				console.log("글번호 : "+r_no);
				// 상세 페이지로 이동하기 위해 form 추가 (id : detailForm) 
				$("#detailForm").attr({
					"method":"get",
					"action":"/admin/review/adminreviewDetail"
			//		"action":"/review/adminreviewDetail"

				});
				$("#detailForm").submit(); 
			});
		
			/* 검색 버튼 클릭 시 처리 이벤트 */
			$("#searchBtn").click(function(){
				if($("#search").val()!="r_regdate"){
					if(!chkSubmit($('#keyword'),"검색어를")) return;
				}else if($("#search").val()=="r_regdate"){
					if(!chkSubmit($('#start_date'),"시작날자를")) return;
					else if(!chkSubmit($('#end_date'),"종료날자를")) return;
					else if($('#start_date').val()>$('#end_date').val()){
						alert("시작날자가 종료날자보다 더 클 수 없습니다.");
						return;
					}
				}
				$("#pageNum").val(1);
				goPage();
			});
			
			$("#allSearchBtn").click(function(){
				$("#search > option:selected").val("");
				$("#keyword").val("");
				$("#start_date").val("");
				$("#end_date").val("");
				goPage();
				//location.href="/admin/review/adminreviewList";
			});
			
			/* 검색 대상이 변경될 때마다 처리 이벤트 */
			$("#search").change(function() {
				if($("#search").val()!="r_regdate"){
					$("#dateCheck").hide();						
					$("#textCheck").show();	
				}if($("#search").val()=="r_regdate"){
					$("#textCheck").hide();
					$("#dateCheck").show();
				}
			});
			
			$(".paginate_button a").click(function(e) {
				e.preventDefault();
				$("#f_search").find("input[name='pageNum']").val($(this).attr("href"));
				goPage();
			});
		});
		
		function goPage(){
			$("#f_search").attr({
				"method":"get",
				"action":"/admin/review/adminreviewList"
			});
			$("#f_search").submit();
		}
		


</script> 
</head>
<body>
<body>
<!-- 	<h2 class="sub-header" >FAQ 관리</h2>  -->
	<div class="contentTit page-header"><h3 class="text-center">관람후기 관리</h3></div> 

	<form id="detailForm">
			<input type="hidden" id="r_no" name="r_no" />
	</form>


	 		
	<%-- 검색부분 정의 --%>
	<div  class="well">
		<form class="form-inline" id="f_search">
			<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum}">
			<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
			<input type="hidden" name="s_num" id="s_num" value="${s_num}"/>
	<!-- 		<h3><span class="label label-success">검색조건</span></h3> -->
			<div class="form-group">
				<select id="search" name="search" class="form-control">
					<option value="r_title">관람후기 제목</option>				
					<option value="r_content">관람후기 내용</option>
					<option value="r_regdate">작성일자</option>	
				</select>		
			</div>
			<div class="form-group" id="textCheck">
				<input type="text" name="keyword" id="keyword" class="form-control" placeholder="검색어를입력하세요" />
			</div>
			<div class="form-group" id="dateCheck">
				<input type="date" name="start_date" id="start_date" placeholder="시작일자" class="form-control">
				<input type="date" name="end_date" id="end_date" placeholder="종료일자" class="form-control">
			</div>
			<button type="button" class="btn btn-primary" id="searchBtn">Search</button>
			<button type="button" class="btn btn-primary" id="allSearchBtn">All Search</button>
		</form>
	</div> 
	
	<%-- 게시판 리스트 --%>
	<div class="table-responsive table-height">
		<table class="table table-bordered">
			<thead>
				<tr>
					<th class="text-center">공연번호</th>
			 		<th class="text-center">공연명</th>  
					<th class="text-center">아이디</th>
					<th class="text-center">고객명</th>
					<th class="text-center">제목</th>
					<th class="text-center">등록일</th>
				</tr>
			</thead>
			<tbody>
				<!-- 데이터 출력 -->
				<c:choose>
					<c:when test="${not empty adminreviewList}" >
						<c:forEach var="review" items="${adminreviewList}" varStatus="status">
							<tr class="text-center" data-num="${review.r_no}">
							<%--<td>${count - status.index}</td>--%>								
								<td>${review.s_num}</td> 								
								<td>${review.s_name}</td> 
								<td class="name">${review.u_id}</td>
								<td>${review.u_name}</td> 								
								<td class="goDetail tal">${review.r_title}</td>
								<td>${review.r_regdate}</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="4" class="text-center">등록된 게시물이 존재하지 않습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
	
	<%-- =================== 페이징 출력 시작 (클라이언트 페이징 소스 그대로 가져오기) ============== --%>
	<div class="text-center">
		<ul class="pagination">
			<!-- 이전 바로가기 10개 존재 여부를 prev 필드의 값으로 확인. -->
			<c:if test="${pageMaker.prev}">
				<li class="paginate_button previous">
					<a href="${pageMaker.startPage - 1}">Previous</a>
				</li>
			</c:if>
					
			<!-- 바로가기 번호 출력 -->
			<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
				<li class="paginate_button  ${pageMaker.cvo.pageNum == num ? 'active':''}">
					<a href="${num}">${num}</a>
				</li>
			</c:forEach>
	
			<!-- 다음 바로가기 10개 존재 여부를 next 필드의 값으로 확인. -->
			<c:if test="${pageMaker.next}">
				<li class="paginate_button next">
					<a href="${pageMaker.endPage + 1 }">Next</a>
				</li>
			</c:if> 
		</ul>
	</div>	

</body>
</html>


