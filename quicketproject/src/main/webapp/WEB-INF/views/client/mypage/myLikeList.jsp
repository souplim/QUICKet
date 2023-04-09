<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"  %>

	<style>
		.title {margin-bottom: 30px;}
	</style>
	
	<script type="text/javascript">
		$(function(){
			/* 공연제목 클릭시 이벤트 처리 */
			$(".goDetail").on("click", function(){
				location.href="";
			});
			
			/* 제목 마우스 오버시 밑줄 */
			$(".goDetail").hover(function(){
				$(this).css("textDecoration","underline");
			}, function(){
				$(this).css("textDecoration","none");
			});
			
			/* 관심공연 해제 버튼 클릭시 이벤트 처리 */
  			$(".cancelLikes").on("click", function(){
				let likes = "off";
				
				const data = {
					s_num : $(this).parents("tr").attr("data-num"),
					likes : likes
				}
				
				$.ajax({
					url : "/mypage/likes",
					type : "POST",
					data : data,
					error : function(xhr, textStatus, errorThrown){
						alert("시스템에 문제가 있어 잠시 후 다시 진행해주세요.");
					},
					success : function(result){
						console.log(result);
						if(result=="SUCCESS"){
							/* 관심공연 해제 버튼 클릭시 뜨는 모달창 */
							$('#myCancelLikesModal').on('shown.bs.modal', function () {
							  $('#myInput').focus();
							});
							
						}
					}
				});
			}); 
			
  			/* 나의 관심공연 버튼 클릭시 뜨는 모달창에서 닫기 버튼 클릭시 처리 이벤트 */
			$(".detailReload").on("click", function(){
				location.href="/mypage/myLikeList";
			});
  			
			/* 페이징 처리 이벤트 */
			$(".paginate_button a").click(function(e){
				e.preventDefault(); // a태그 -> href로 이동하는 성격 해제
				// dataForm 폼 하위 pageNum을 이름으로 가지는 input의 값을 클릭한 번호
				$("#pageForm").find("input[name='pageNum']").val($(this).attr("href"));
				
				// 폼태그 안 데이터 들고 다시 페이지 list 부르기
				$("#pageForm").attr({
					"method" : "get",
					"action" : "/mypage/myLikeList"
				});
				$("#pageForm").submit();
			});
			
		});
	</script>
	</head>
	<body>
		<%-- ================= 관심공연 해제 버튼 클릭시 모달창 내용 ================= --%>
		<div class="modal fade" id="myCancelLikesModal">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title">QUICKet 관심공연 해제</h4>
		      </div>
		      <div class="modal-body">
		        <p>관심공연에서 해제되었습니다.</p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-primary detailReload">확인</button>
		      </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		
		<%-- ================= 데이터 전달 폼 ================= --%>
		<form name="pageForm" id="pageForm">
			<!-- 페이징 처리를 위한 파라미터 -->
			<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum}"/>
			<input type="hidden" name="amount" id="amount" value="${pageMaker.cvo.amount}"/>
		</form>
		
		
		<div class="contentContainer container">
			<div class="title">
				<h1>관심공연 확인/취소</h1>
				<p>관심공연 해제 버튼을 클릭하면 관심공연을 취소할 수 있습니다.</p>
			</div>
			
			<%-- ================= 리스트 시작 ================= --%>
			<div id="likeList" class="table-height">
				<table summary="관심공연 리스트" class="table">
					<thead>
						<tr>
							<th class="text-center col-md-5">공연명</th>
							<th class="text-center col-md-2">공연시작일</th>
							<th class="text-center col-md-2">공연종료일</th>
							<th class="text-center col-md-2">등록일</th>
							<th class="text-center col-md-1">관심공연</th>
						</tr>
					</thead>
					<tbody id="list" class="table-striped">
						<!-- 데이터 출력 -->
						<!-- <c:if test=""></c:if> ${inq.u_id} 세션아이디와 작성자아이디가 같을 경우 출력 -->
						<c:choose>
							<c:when test="${not empty likeList}">
								<c:forEach var="like" items="${likeList}" varStatus="status">
									<tr class="text-center" data-num="${like.s_num}">
										<!-- 새로 번호 부여 상태변수.index: 0부터 시작-->
										<%-- <td>${count - status.index}</td>  --%>
										<td class="text-left goDetail" style="vertical-align:middle">${like.s_name}</td>
										<td class="text-center" style="vertical-align:middle">${like.s_opendate}</td>
										<td class="text-center" style="vertical-align:middle">${like.s_closedate}</td>
										<td class="text-center" style="vertical-align:middle">${like.b_regidate}</td>
										<td>
											<button type="button" class="btn btn-danger likes cancelLikes" data-toggle="modal" data-target="#myCancelLikesModal">
												<span class="glyphicon glyphicon-heart" aria-hidden="true"></span> 
													해제
											</button>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="6" class="tac text-center">등록된 관심공연이 존재하지 않습니다.</td>
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