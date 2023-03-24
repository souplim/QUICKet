<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"  %>
	<!-- 스크립트 정의 -->
	<script type="text/javascript" src="/resources/include/js/common.js"></script>
	<script type="text/javascript" src="/resources/include/js/adminInq.js"></script> <!-- 관리 편하게 하기 위해 js 파일 따로 생성 -->
	
	<!-- 값을 담는 것 JSP(코어태그와 표현언어로 해야 하기 때문에), 변수 사용하는 건 JS -> 처리 별도로 해야함
	     표현언어 jstl은 jsp에서 표현하기 때문에 따로 빼는 js 파일에 들어가면 javascript는 이를 텍스트로 인식한다. -->
	<script type="text/javascript">
		search = "<c:out value='${data.search}' />"; 
		search_detail = "<c:out value='${data.search_detail}' />"; 
		start_date = "<c:out value='${data.start_date}' />"; /* date -> controller에서 넘겨진 inqVO */
		end_date = "<c:out value='${data.end_date}' />";
		keyword = "<c:out value='${data.keyword}' />";
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
				<h1>1:1 문의 관리</h1>
			</div>
			
			<%-- ================= 검색 부분 출력 ================= --%>
			<div class="well text-center">
				<form class="form-inline" id="f_search">
					<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum}"> 
					<input type="hidden" name="amount" id="amount" value="${pageMaker.cvo.amount}">
					<%-- <input type="hidden" name="i_reply" id="i_reply" value="${inq.i_reply}"> --%>
					
					<div class="form-group">
						<label for="search" class="sr-only">검색조건</label>
						<select id="search" name="search" class="form-control">
							<option value="i_title">제목</option>
							<option value="u_id">작성자</option>
							<option value="i_content">내용</option>
							<option value="i_category">유형</option>
							<option value="i_reply">답변현황</option>
							<option value="i_regidate">작성일자</option>
						</select>
					</div>
					
					<div class="form-group">
						<label for="search_detail" class="sr-only">세부 검색조건</label>
						<select id="search_detail" name="search_detail" class="form-control">
							<option value="opt">---</option>
						</select>
					</div>
					
					<div class="form-group" id="textCheck"> <!-- 날짜 외 검색 선택 시 보이는 부분 -->
						<input type="text" name="keyword" id="keyword" class="form-control" placeholder="검색어를 입력하세요" />
					</div>
					<div class="form-group" id="dateCheck"> <!-- 날짜 검색 선택 시 보이는 부분 -->
						<input type="date" name="start_date" id="start_date" placeholder="시작일자" class="form-control">
						<input type="date" name="end_date" id="end_date" placeholder="종료일자" class="form-control">
					</div>
					<button type="button" class="btn btn-primary" id="searchBtn">Search</button>
					<button type="button" class="btn btn-primary" id="allSearchBtn">All Search</button> <!-- 전체 레코드 조회 -->
				</form>
			</div>
			
			<%-- ================= 리스트 시작 ================= --%>
			<div id="inqList" class="table-height">
				<table summary="게시판 리스트" class="table table-striped">
					<thead>
						<tr>
							<th data-value="i_num" class="order text-center col-md-1">글번호</th>
							<th class="text-center col-md-2">카테고리</th>
							<th class="text-center col-md-4">제목</th>
							<th data-value="i_regidate" class="order text-center col-md-2">작성일</th>
							<th class="text-center col-md-1">작성자</th>
							<th class="text-center col-md-1">답변현황</th>
							<th class="text-center col-md-1">삭제</th>
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
										<%-- <td>${count - status.index}</td>  --%>
										<td>${inq.i_num}</td> 
										<td>${inq.i_category} > ${inq.i_cate_detail}</td>
										<td class="text-center goDetail">${inq.i_title}</td>
										<td>${inq.i_regidate}</td>
										<td>${inq.u_id}</td>
										<td>
											<c:if test="${inq.i_reply==0}">답변 대기중</c:if>
											<c:if test="${inq.i_reply==1}">답변 완료</c:if>
										</td>
										<td><button type="button" class="delBtn btn-danger">삭제</button></td>
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
			
			<%-- ================= 상세정보 시작 ================= --%>		
			<jsp:include page="inqDetailReply.jsp" />
			
		</div>	
	</body>
</html>