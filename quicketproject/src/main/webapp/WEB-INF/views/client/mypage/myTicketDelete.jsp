<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"  %>

	<style type="text/css">
		#borderline { 
			border: 2px solid rgb(245, 100, 98); 
			c
		}
		.bg-danger { padding: 30px; }
		.margin-title {
			margin: 0 0 15px 0;
			padding: 3px 10px;
		}
		.contentBtn { margin-bottom: 30px; }
		.gray { background-color: rgb(233, 233, 233); }
		.btn-blue {
			background-color: dodgerblue;
			color: #fff;
		}
	</style>
	
	<script type="text/javascript">
		$(function(){
			/* 예매내역 목록 버튼 클릭시 이벤트 처리 */
			$("#listBtn").on("click", function(){
				
				location.href="/mypage/myTicketList";
			});
		});
	</script>
	</head>
	<body>
		<div class="contentContainer container">
			<div id="borderline" class="bg-danger">
				<h3>
					<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>&nbsp;
					예매취소가 정상적으로 완료되었습니다.
				</h3>
			</div>
			
			<%-- ================= 예매내역 ================= --%>
			<div>
				<h3>환불내역</h3>
			</div>

			<div class="bg-info margin-title">
				<h4 class="text-left">${ticketDelete.s_name}</h4>
			</div>
			
			<div class="contentTB text-center" id="payment">
				<table class="table table-bordered">
					<tr>
						<td class="col-md-4 gray">예매일</td>
						<td class="col-md-8 text-left">${ticketDelete.hall_date}</td>
					</tr>
					<tr>
						<td class="col-md-4 gray">예매상태</td>
						<td class="col-md-8 text-left">
							<c:if test="${ticketDelete.ti_status==0}">
								전체취소
							</c:if>
							<c:if test="${ticketDelete.ti_status==1}">
								예매완료
							</c:if>
						</td>
					</tr>
					<tr>
						<td class="col-md-4 gray" style="vertical-align:middle">환불금액</td>
						<td class="col-md-8 text-left">
							<p class="text-danger">${ticketDelete.pay_amount}원</p>
							<p>티켓금액 ${ticketDelete.s_price}원</p>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="text-left">
							취소 후 고객님의 계좌로 입금까지 대략 5~7일 정도가 소요됩니다. (주말, 공휴일 제외한 영업일 기준)
						</td>
					</tr>
				</table>
			</div>
			
			<%-- ================= 예매내역 목록, 취소내역 버튼 ================= --%>
			<div class="contentBtn text-center">
				<button type="button" id="listBtn" class="btn btn-blue">예매내역 목록</button>
			</div>
			
			<%-- ================= 티켓취소 안내 ================= --%>
			<div class="contentTB text-center">
				<div class="gray margin-title">
					<h4 class="text-left">유의사항</h4>
					<div class="text-left">
						<ul>
							<li>예매수수료는 예매일 이후 취소시에는 환불되지 않습니다.</li>
							<li>동일 상품에 대해서 날짜, 시간, 좌석, 가격 등급, 결제 등의 일부 변경을 원하시는 경우, 기존 예매 건을 취소하시고 재예매 하셔야 합니다.</li>
							<li>단, 취소 시점에 따라 예매수수료가 환불 되지 않으며,취소수수료가 부과될 수 있습니다.<br/>
								(할인선택은 재예매 시점에 적용되는 할인률로만 적용 가능합니다.)</li>
							<li>이미 배송이 시작된 티켓의 경우 인터넷 및 전화로 취소할 수 없습니다.</li>
							<li>반드시 취소마감 시간 이전에 티켓이 퀵켓 고객센터로 반송되어야 취소가능하며, 취소수수료는 도착일자 기준으로 부과됩니다.<br/>
								(* 단, 배송료는 환불되지 않으며 일괄배송 상품의 경우 취소에 대한 자세한 문의는 고객센터로 문의해주시기 바랍니다.)</li>
							<li>예매취소시점과 해당 카드사의 환불 처리기준에 따라 취소금액의 환급방법과 환급일은 다소 차이가 있을 수 있습니다.</li>
							<li>예매 취소 시 최초 결제 동일카드로 예매 시점에 따라 취소 수수료와 배송료를 재승인합니다.</li>
							<li>관람일 전일 오후 5시 이후(토요일은 오전 11시) 또는 관람일 당일 예매하신 건에 대해서는 예매후 취소/변경/환불이 불가합니다.</li>
							<li>티켓 부분 취소 시 할부 결제는 티켓 예매 시점으로 적용됩니다.<br/>
								(무이자할부 행사기간이 지날 경우 혜택받지 못하실 수 있으니 유의하시기 바랍니다)</li>
							<li>기타 문의사항은 [이용안내]를 참조하시거나, [고객센터]를 이용하시기 바랍니다.</li>
						</ul>
					</div>
				</div>
			</div>
			
		</div>
	</body>
</html>