<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<title>회원 관리</title>

<script type="text/javascript">
			search = "<c:out value='${data.search}' />";
			keyword = "<c:out value='${data.keyword}' />";
			
			
			$(function(){
				
				<!-- 회원 쿠폰내역 이동
				$(".couponBtn").click(function(){
					let num = $(this).parents("tr").attr("data-num");
					
					$("#u_num").val(num);
					$("#outForm").attr({
						"method" : "get",
						"action" : "/admin/user/userCouponList"
					});
					$("#outForm").submit();
				}); -->
				
				<!-- 회원 탈퇴 처리 -->
				$(".outBtn").click(function(){
					
					let num = $(this).parents("tr").attr("data-num");
					let email = $(this).parents("tr").attr("data-email");

					console.log(email);
					
					if(confirm(num+"번 회원을 탈퇴처리합니다.")) {
						$("#u_num").val(num);
						$("#outForm").attr({
							"method" : "get",
							"action" : "/admin/user/userDelete"
						});
						$("#outForm").submit();
						
						$.ajax({
							type:"POST",
							url:"/admin/user/mailDelete",
							data : {
								"email":email
							},
							success:function(data){
								console.log("탈퇴 처리 메일 전송 완료.");
							}
						});
					}

				});
				
				$("#searchBtn").click(function(){
					if($('#keyword').val() == ""){
						alert("검색어를 입력해주세요.");
					}
			
					$("#pageNum").val(1);
					goPage();
				});
				
				$("#allSearchBtn").click(function(){
					$("#search > option:selected").val("");
					$("#keyword").val("");
					//goPage();
					location.href="/admin/user/userList";
				});
				

				
				// 페이징 처리
				$(".paginate_button a").click(function(e) {
					 e.preventDefault();
					 $("#f_search").find("input[name='pageNum']").val($(this).attr("href"));
					 goPage();
				});

			}); /////////////
			
			function goPage() {
				if($("#search").val()=="all") {
					$("#keyword").val("");
				}
				
				$("#f_search").attr({
					"method" : "get",
					"action" : "/admin/user/userList"
				});
				$("#f_search").submit();
			}
	</script> 
</head>
<body>
	<form name="outForm" id="outForm">
				<input type="hidden"name="u_num"id="u_num"/>
				<input type="hidden"name="u_email" id="u_email"/>
	</form>
	
	<div  class="well">
			<form class="form-inline" id="f_search">
				<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum}">
				<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
							
				<h3 style="display: inline;"><span class="label label-success">검색조건</span></h3>
				<div class="form-group">
					<select id="search" name="search" class="form-control">
						<option value="u_num">회원번호</option>
						<option value="u_name">이름</option>
						<option value="u_id">아이디</option>
						<option value="u_email">이메일</option>	
					</select>
				</div>
				<div class="form-group" id="textCheck">
					<input type="text" name="keyword" id="keyword" class="form-control" placeholder="검색어를입력하세요" />
				</div>
				<button type="button" class="btn btn-primary" id="searchBtn">Search</button>
				<button type="button" class="btn btn-primary" id="allSearchBtn">All Search</button>
			</form>
		</div> 
			
	<div class="table-responsive table-height">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th class="text-center">번호</th>
						<th class="text-center">회원번호</th>
						<th class="text-center">이름</th>
						<th class="text-center">아이디</th>
						<th class="text-center">이메일</th>
						<th class="text-center">전화번호</th>
						<th class="text-center">성별</th>
						<th class="text-center">가입일</th>
						<th class="text-center">회원정보 수정일</th>
						<th class="text-center">비밀번호 변경일</th>
						<th class="text-center">회원상태</th>
						<th class="text-center">예매내역</th>
						<th class="text-center">쿠폰내역</th>
						<th class="text-center">상태변경</th>
					</tr>
				</thead>
				<tbody>
					<!-- 데이터 출력 -->
					<c:choose>
						<c:when test="${not empty userList}" >
							<c:forEach var="user" items="${userList}" varStatus="status">
								<tr class="text-center" data-num="${user.u_num}" data-email="${user.u_email}">
									<td>${count - status.index}</td>
									<td>${user.u_num}</td>
									<td>${user.u_name}</td>
									<td>${user.u_id}</td>
									<td>${user.u_email}</td>
									<td>${user.u_phone}</td>
									<c:choose>
										<c:when test="${user.u_gender == 'F'}">
											<td>여성</td>
										</c:when>
										<c:otherwise>
											<td>남성</td>
										</c:otherwise>
									</c:choose>
									<td>${user.u_regdate}</td>
									<td>${user.u_moddate}</td>
									<td>${user.u_pwddate}</td>
									<c:choose>
										<c:when test="${user.u_state == 1}">
											<td>일반회원</td>
										</c:when>
										<c:otherwise>
											<td>탈퇴회원</td>
										</c:otherwise>
									</c:choose>
									<td><button type="button" class="btn btn-primary ticketBtn">예매내역</button></td>
									<td><button type="button" class="btn btn-primary couponBtn">쿠폰내역</button></td>
									<c:choose>
										<c:when test="${user.u_state == 1}">
											<td><button type="button" class="btn btn-danger outBtn">탈퇴</button></td>
										</c:when>
										<c:otherwise>
											<td><button type="button" class="btn">탈퇴</button></td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="13" class="text-center">등록된 회원이 없습니다.</td>
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