<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"  %>

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
		
		<div class="contentContainer container">
			<div>
				<h1>관심공연 확인/취소</h1>
				<p>관심공연 해제 버튼을 클릭하면 관심공연을 취소할 수 있습니다.</p>
			</div>
			
			<%-- ================= 리스트 시작 ================= --%>
			<div id="likeList" class="table-height">
				<table summary="관심공연 리스트" class="table table-striped">
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
			
		</div>
	</body>
</html>