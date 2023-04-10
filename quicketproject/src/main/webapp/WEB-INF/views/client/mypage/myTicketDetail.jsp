<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<style type="text/css">
		.flex { display: flex; }
		.margin-title {
			margin: 0 0 15px 0;
			padding: 10px 15px;
		}
		.gray { background-color: rgb(233, 233, 233); }
		#borderline { 
			border: 2px solid dodgerblue; 
			margin-bottom: 30px;
		}
		#img { 
			margin: 0 10px; 
			width: 200px;
		}
		#img img {
			height: 200px;
			weith: 150px;
		}
		.btn-blue {
			background-color: dodgerblue;
			color: #fff;
		}
		.table-ticket { width: 900px; }
		.contentBtn { margin: 5px 20px 10px 30px; }
		
		#payment { margin-bottom: 30px; }
		
	</style>
	
	<script type="text/javascript">
		$(function(){
			/* 공연정보 버튼 클릭시 이벤트 처리 */
			$("#showInfoBtn").on("click", function(){
				let s_num = $("#s_num").val();
				location.href="/showDetail?s_num="+s_num;
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
				let pay_num = $(".tiNum").text();
				console.log(pay_num);
				$("#pay_num").val(pay_num);
				
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
				let pay_num = $(".dataNum").attr("data-num");
				payToken(pay_num);
			});
			/* 예매 취소 메서드 */
			function requestCancel(imp_uid, token, amount) {
				let value= JSON.stringify({
					token : token,
					imp_uid : imp_uid,
					amount : amount,
					reason : "사유"
					});
				$.ajax({
	                url: "/api/v1/payment/cancel", // 예: https://www.myservice.com/payments/complete
	                method: "POST",
	                headers: { "Content-Type": "application/json" },
	                data: value,
	                error 	: function(xhr, textStatus, errorThrown) {
						alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
				    },
				    success : function(result){
				    	if(result != "hello"){
				    		console.log("환불실패");
				    	}
				    	else{/* 성공 */
				    		console.log("환불성공");
				    		
				    	}
				    }
				})
	        }
			//결제상태변경
			function payStatus(pay_num1) {
				$.ajax({
	                url: "/admin/payJson2/payStatus", // 예: https://www.myservice.com/payments/complete
	                method: "POST",
	                headers: { "Content-Type": "application/json" },
	                data: String(pay_num1),
	                error 	: function(xhr, textStatus, errorThrown) {
						alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
				    },
				    success : function(result){
				    	if(result == "SUCCESS"){
				    		console.log("결제상태변경 성공");
				    	}
				    	else{/* 성공 */
				    		console.log("결제상태변경 실패");
				    		
				    	}
				    }
				})
	        }
			
			//예매상태변경
			function ticketStatus(pay_num1) {
				$.ajax({
	                url: "/admin/payJson2/ticketStatus", // 예: https://www.myservice.com/payments/complete
	                method: "POST",
	                headers: { "Content-Type": "application/json" },
	                data: String(pay_num1),
	                error 	: function(xhr, textStatus, errorThrown) {
						alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
				    },
				    success : function(result){
				    	if(result == "SUCCESS"){
				    		console.log("예매상태변경 성공");
				    	}
				    	else{
				    		console.log("예매상태변경 실패");
				    		
				    	}
				    }
				})
	        }
			
			function payToken(pay_num){
				let url = "/admin/payJson2/payToken/"+pay_num; 
				$.ajaxSetup({
					async:false
				});
				$.getJSON(url, function(data){
					$(data).each(function(){
						let pay_num = this.pay_num;
						let imp_uid = this.imp_uid;
						let token = this.token;
						let amount = this.pay_amount;
						requestCancel(imp_uid, token, amount);
						payStatus(pay_num);
						ticketStatus(pay_num);
						location.href="/mypage/myTicketDelete?pay_num="+pay_num;
					});
				}).fail(function(){
					alert("결제 취소를 실패했습니다. 관리자에게 문의해주세요.")				
				})
			}
			/* 예매 취소 메서드 끝 */
			
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
		      	<button type="button" class="btn btn-blue" id="cancelConfirmBtn">확인</button>
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
		        <button type="button" class="btn btn-blue detailReload">확인</button>
		      </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
	
	
	
		<%-- ================= 데이터 전달 폼 ================= --%>
		<form name="dataForm" id="dataForm">
			<input type="hidden" name="s_num" id="s_num" value="${ticketDetail.s_num}">
			<input type="hidden" name="pay_num" id="pay_num">
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
				<div class="margin-title gray">
					<h4 class="text-left">${ticketDetail.s_name}</h4>
				</div>
				<div class="contentTB text-center flex">
					<div id="img">
						<c:if test="${ticketDetail.img_dir ne null}">
							<img class="poster" src="/uploadStorage/${ticketDetail.img_dir}/${ticketDetail.img_name}.${ticketDetail.img_type}"/>
						</c:if>
					</div>
					<div>
						<table class="table table-bordered table-ticket">
							<tr class="dataNum" data-num="${ticketDetail.pay_num}">
								<td class="col-md-4 gray">예매번호</td>
								<td class="col-md-8 text-left tiNum">${ticketDetail.pay_num}</td>
							</tr>
							<tr>
								<td class="col-md-4 gray">예매자</td>
								<td class="col-md-8 text-left">${ticketDetail.pay_name}</td>
							</tr>
							<tr>
								<td class="col-md-4 gray">관람일시</td>
								<td class="col-md-8 text-left">${ticketDetail.hall_date}&nbsp;&nbsp;${ticketDetail.hall_turn}&nbsp;&nbsp;${ticketDetail.hall_time}</td>
							</tr>
							<tr>
								<td class="col-md-4 gray">공연장</td>
								<td class="col-md-8  text-left">${ticketDetail.th_name}&nbsp;${ticketDetail.hall_id}</td>
							</tr>
							<tr>
								<td class="col-md-4 gray" style="vertical-align:middle">좌석번호</td>
								<td class="col-md-8 text-left">
									${ticketDetail.seat_nums}번
									<%-- <c:choose>
										<c:when test="${not empty seatList}">
											<c:forEach var="seats" items="${seatList}" varStatus="status">
												<p>${seats.seat_num}번</p>
											</c:forEach>
										</c:when>
									</c:choose> --%>
									(${ticketDetail.seat_ages})
								</td>
							</tr>
						</table>
					</div>
				</div>
				
				<%-- ================= 공연정보, 관심공연 버튼 ================= --%>
				<div class="contentBtn text-left">
					<button type="button" id="showInfoBtn" class="btn btn-blue">공연정보</button>
					<!-- 관심공연 담기/해제 버튼 -->
					<c:choose>
						<c:when test="${ticketDetail.is_likes == 1}">
							<button type="button" class="btn btn-danger likes cancelLikes" data-toggle="modal" data-target="#myCancelLikesModal">
								<span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span> 
									해제
							</button>
						</c:when>
						<c:otherwise>
							<button type="button" class="btn btn-default likes addLikes" data-toggle="modal" data-target="#myLikesModal">
								<span class="glyphicon glyphicon-heart" aria-hidden="true"></span> 
									관심
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
							<p class="text-danger">
								${ticketDetail.pay_amount}원
							</p>
							<p>
								티켓금액 
								<c:forEach var="seatAge" items="${seatAgeList}" varStatus="status">
									<c:if test="${seatAge.seat_age eq '성인'}">
										성인 ${ticketDetail.s_price}원
									</c:if>
									<c:if test="${seatAge.seat_age eq '아동'}">
										아동 
										<c:set var="child" value="${ticketDetail.s_price*0.3}"/>
										<fmt:formatNumber value="${child+(1-(child%1))%1}" type="number" />원
										<c:if test="${!status.last}">,</c:if>
									</c:if>
									<br/>
								</c:forEach> 
								<c:if test="${not empty ticketDetail.c_num}">
									- 할인금액 
									<c:set var="discount" value="${ticketDetail.c_discount*0.01*ticketDetail.s_price}"/>
									<fmt:formatNumber value="${discount+(1-(discount%1))%1}" type="number" />원
									(${ticketDetail.c_name})
								</c:if>
							</p>
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
						<table summary="예매취소안내 리스트" class="table">
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