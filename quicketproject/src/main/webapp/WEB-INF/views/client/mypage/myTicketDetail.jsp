<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"  %>
	<style type="text/css">
		.flex { display: flex; }
		.margin-title {
			margin: 0 0 15px 0;
			padding: 10px 15px;
		}
		.gray { background-color: rgb(233, 233, 233); }
		#borderline { 
			border: 2px solid #286090; 
			margin-bottom: 30px;
		}
		#img { 
			margin: 0 10px; 
			width: 200px;
		}
		.table-ticket { width: 900px; }
		.contentBtn { margin: 10px; }
		
		#payment { margin-bottom: 30px; }
		
	</style>
	
	<script type="text/javascript">
		$(function(){
			/* 공연정보 버튼 클릭시 이벤트 처리 */
			$("#showInfoBtn").on("click", function(){
				location.href="";
			});
			
			/* 관심공연 담기 버튼 클릭시 이벤트 처리 */
  			$(".likes").on("click", function(){
				let likes = "";
				
				if($(this).hasClass("addLikes")){
					likes = "on";
				} else {
					likes = "off";
				}
				
				const data = {
					s_num : $("#s_num").val(),
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
							if(likes=="on"){
								/* 관심공연담기 버튼 클릭시 관심공연등록 처리후 관심공연페이지로 이동할지 물어보는 모달창 */
								$('#myLikesModal').on('shown.bs.modal', function () {
								  $('#myInput').focus();
								});
							} else {
								/* 관심공연 해제 버튼 클릭시 뜨는 모달창 */
								$('#myCancelLikesModal').on('shown.bs.modal', function () {
								  $('#myInput').focus();
								});
								
								// detail 페이지 post 방식으로 이동
								/* $("#dataForm").attr({
									"method" : "get",
									"action" : "/mypage/myTicketDetail"
								});
								$("#dataForm").submit(); */
							}
						}
					}
				});
			}); 
 			
			
			/* 나의관심공연 버튼 클릭시 이벤트 처리 */
			$("#myLikesBtn").on("click", function(){
				location.href="/mypage/myLikeList";
			});
			
			/* 나의 관심공연 버튼 클릭시 뜨는 모달창에서 닫기 버튼 클릭시 처리 이벤트 */
			$(".detailReload").on("click", function(){
				let ti_num = $(".dataNum").attr("data-num");
				console.log(ti_num);
				$("#ti_num").val(ti_num);
				
				// 디테일 페이지 리로드
				$("#dataForm").attr({
					"method" : "post", 
					"action" : "/mypage/myTicketDetail"
				});
				$("#dataForm").submit();
			});
			
			/* 예매내역 목록 버튼 클릭시 이벤트 처리 */
			$("#listBtn").on("click", function(){
				location.href="/mypage/myTicketList";
			});
			
			/* 예매취소 버튼 클릭시 이벤트 처리 */
			$('#myModal').on('shown.bs.modal', function () {
			  $('#myInput').focus();
			});
			
			/* 예매취소 -> 확인 버튼 클릭시 이벤트 처리 */
			$("#cancelConfirmBtn").on("click", function(){
				let ti_num = $(".dataNum").attr("data-num");
				location.href="/mypage/myTicketDelete?ti_num="+ti_num;
			});
			
		});
	</script>
	</head>
	<body>
		<%-- ================= 예매취소 버튼 클릭시 모달창 내용 ================= --%>
		<div class="modal fade" id="myModal">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title">QUICKet 예매취소 안내</h4>
		      </div>
		      <div class="modal-body">
		        <p>할인쿠폰 등 기타 결제수단의 사용기간이 지난 경우 복원되지 않습니다.<br/>취소하기 전 사용기간을 꼭 확인하세요.<br/><br/>주문을 취소하시겠습니까?</p>
		      </div>
		      <div class="modal-footer">
		      	<button type="button" class="btn btn-primary" id="cancelConfirmBtn">확인</button>
		        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
		      </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		
		<%-- ================= 관심공연 담기 버튼 클릭시 모달창 내용 ================= --%>
		<div class="modal fade" id="myLikesModal">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title">QUICKet 관심공연 담기</h4>
		      </div>
		      <div class="modal-body">
		        <p>관심공연에 담겼습니다.<br/>나의 관심공연에서 확인해주세요.<br/>바로확인하시겠습니까?</p>
		      </div>
		      <div class="modal-footer">
		      	<button type="button" class="btn btn-primary" id="myLikesBtn">나의관심공연</button>
		        <button type="button" class="btn btn-default detailReload">닫기</button>
		      </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		
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
		<form name="dataForm" id="dataForm">
			<input type="hidden" name="s_num" id="s_num" value="${ticketDetail.s_num}">
			<input type="hidden" name="ti_num" id="ti_num">
		</form>
			
		<%-- ================= 페이지 시작 ================= --%>
		<div class="contentContainer container">
			<div>
				<h1>예매확인/취소</h1>
				<p>예매한 티켓 확인/취소가 가능합니다.</p>
			</div>
		
			<%-- ================= 예매내역 ================= --%>
			<div>
				<h3>예매내역</h3>
			</div>
			
			<div id="borderline">
				<div class="bg-info margin-title">
					<h4 class="text-left">${ticketDetail.s_name}</h4>
				</div>
				<div class="contentTB text-center flex">
					<div id="img">
						${ticketDetail.img_dir}
					</div>
					<div>
						<table class="table table-bordered table-ticket">
							<tr class="dataNum" data-num="${ticketDetail.ti_num}">
								<td class="col-md-4 gray">예매번호</td>
								<td class="col-md-8 text-left">${ticketDetail.ti_num}</td>
							</tr>
							<tr>
								<td class="col-md-4 gray">예매자</td>
								<td class="col-md-8 text-left">${ticketDetail.pay_name}</td>
							</tr>
							<tr>
								<td class="col-md-4 gray">관람일시</td>
								<td class="col-md-8 text-left">${ticketDetail.seat_date}</td>
							</tr>
							<tr>
								<td class="col-md-4 gray">공연장</td>
								<td class="col-md-8  text-left">${ticketDetail.th_name}&nbsp;${ticketDetail.hall_id}</td>
							</tr>
							<tr>
								<td class="col-md-4 gray" style="vertical-align:middle">좌석번호</td>
								<td class="col-md-8 text-left">
									<c:choose>
										<c:when test="${not empty seatList}">
											<c:forEach var="seats" items="${seatList}" varStatus="status">
												<p>${seats.seat_num}번</p>
											</c:forEach>
										</c:when>
									</c:choose>
								</td>
							</tr>
						</table>
					</div>
				</div>
				
				<%-- ================= 공연정보, 관심공연 버튼 ================= --%>
				<div class="contentBtn text-left">
					<button type="button" id="showInfoBtn" class="btn btn-primary">공연정보</button>
					<!-- 관심공연 담기/해제 버튼 -->
					<c:choose>
						<c:when test="${ticketDetail.is_likes == 1}">
							<button type="button" class="btn btn-danger likes cancelLikes" data-toggle="modal" data-target="#myCancelLikesModal">
								<span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span> 
									관심공연 해제
							</button>
						</c:when>
						<c:otherwise>
							<button type="button" class="btn btn-default likes addLikes" data-toggle="modal" data-target="#myLikesModal">
								<span class="glyphicon glyphicon-heart" aria-hidden="true"></span> 
									관심공연 담기
							</button>
						</c:otherwise>
					</c:choose> 
				</div>
				
				<%-- ================= 공연 디테일 페이지에 들어갈 관심공연 버튼 ================= --%>
				<div class="contentBtn text-left">
					<c:choose>
						<c:when test="${ticketDetail.is_likes == 1}">
							<button type="button" class="btn btn-danger likes cancelLikes" data-toggle="modal" data-target="#myCancelLikesModal">
								<span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span> 
									<span class="badge">${mypageVO.likesCount}</span>
							</button>
						</c:when>
						<c:otherwise>
							<button type="button" class="btn btn-default likes addLikes" data-toggle="modal" data-target="#myLikesModal">
								<span class="glyphicon glyphicon-heart" aria-hidden="true"></span> 
									<span class="badge">${mypageVO.likesCount}</span>
							</button>
						</c:otherwise>
					</c:choose> 
				</div>
			</div>
			
			<%-- ================= 결제내역 ================= --%>
			<div>
				<h3>결제내역</h3>
			</div>
			<div class="contentTB text-center" id="payment">
				<table class="table table-bordered">
					<tr>
						<td class="col-md-4 gray">예매일</td>
						<td class="col-md-8 text-left">${ticketDetail.ti_regdate}</td>
					</tr>
					<tr>
						<td class="col-md-4 gray">예매상태</td>
						<td class="col-md-8 text-left text-danger">
							<c:if test="${ticketDetail.ti_status==0}">
								전체취소
							</c:if>
							<c:if test="${ticketDetail.ti_status==1}">
								예매완료
							</c:if>
						</td>
					</tr>
					<tr>
						<td class="col-md-4 gray" style="vertical-align:middle">총결제금액</td>
						<td class="col-md-8 text-left">
							<p class="text-danger">${ticketDetail.pay_amount}원</p>
							<p>티켓금액 ${ticketDetail.s_price}원</p>
						</td>
					</tr>
				</table>
			</div>
			
			<%-- ================= 예매취소 안내 ================= --%>
			
			<div class="contentTB text-center">
				<div class="margin-title text-left">
				<h4>예매취소 안내</h4>
					<div>
						- 취소일자에 따라서 취소수수료가 달라집니다.<br/>
						* 단, 예매당일 밤 12시 이전 취소시에는 취소수수료 없음(취소기한내에 한함)
					</div>
					<div class="cancelInfo">
						<table summary="게시판 리스트" class="table table-striped">
							<thead>
								<tr>
									<th class="text-center col-md-6">취소일</th>
									<th class="text-center col-md-6">취소수수료</th>
								</tr>
							</thead>
							<tbody id="list" class="table-striped text-center">
								<tr>
									<td>미부과 기간</td> 
									<td>없음</td>
								</tr>
								<tr>
									<td>예매후 8일 ~ 관람일 10일전까지</td> 
									<td>장당 4,000원(단, 티켓금액의 10% 이내)</td>
								</tr>
								<tr>
									<td>관람일 9일전 ~ 관람일 7일전까지</td> 
									<td>티켓금액의 10%</td>
								</tr>
								<tr>
									<td>관람일 6일전 ~ 관람일 3일전까지</td> 
									<td>티켓금액의 20%</td>
								</tr>
								<tr>
									<td>관람일 2일전 ~ 관람일 1일전까지</td> 
									<td>티켓금액의 30%</td>
								</tr>
							</tbody>
						</table>
								
					</div>
				</div>
			</div>
			
			<%-- ================= 공연정보, 관심공연 버튼 ================= --%>
			<div class="contentBtn text-right">
				<button type="button" id="listBtn" class="btn btn-default">예매내역 목록</button>
				<c:if test="${ticketDetail.ti_status==1}">
					<!-- Button trigger modal -->
					<button type="button" id="cancelBtn" class="btn btn-danger" data-toggle="modal" data-target="#myModal">예매취소</button>
				</c:if>
			</div>
			
		</div>
	</body>
</html>