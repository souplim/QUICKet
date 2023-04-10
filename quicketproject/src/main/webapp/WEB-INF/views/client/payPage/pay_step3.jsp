<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/popup.jspf" %>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix= "fn" uri= "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix= "fmt" uri= "http://java.sun.com/jsp/jstl/fmt" %>

<link href="/resources/include/dist/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>

	<style>
		@font-face {
		    font-family: 'LeferiBaseType-RegularA';
		    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2201-2@1.0/LeferiBaseType-RegularA.woff') format('woff');
		    font-weight: normal;
		    font-style: normal;
		}
		
		.container-fluid { 
			background-color: #fff;
			font-family: 'LeferiBaseType-RegularA';
			font-size: 17px;
		}
		body{
			font-family: 'LeferiBaseType-RegularA';
			margin:10px 0 0 15px;
			padding:10px;
			width:1125px;
			height:750px;
			display:flex;
			flex-wrap:nowrap;
		}
		/* main-------------------------------------------------------- */
		#main{
			width:815px;
			height:100%;
		}
		/* header-------------------------------------------------------- */
		#main > #header{
			width:99%;
			height:80px;
			background:white;
			display:flex;
			justify-content:flex-end;
			align-items:flex-end;
		}
/* 		#logo{
			width:127px;
			height:75px;
			background:gray;
			margin:0 10px 10px 0;
			
		}
 */		.step{
 			border-radius:10px;
 			margin-right:2px;
			width:160px;
			height:70px;
			display:flex;
			align-items:center;
		}
		/* subMain-------------------------------------------------------- */
		#main > #subMain{
			width:100%;
			height:430px;
		}
		#subMain_box{
			width:790px;
			height:565px;
			margin: 9px 0 0 8px;
			display:flex;
		}
		.subMain_box1{
			width:100%;
			height:100%;
		}
		.subMain_box2{
			width:100%;
			height:40px;
			background: #757bf6;
			display:flex;
			align-items:center;
		}
		.subMain_box3{
			display:flex;
			align-items:center;
			justify-content:center;
			margin-top:100px;
		}
		/* footer-------------------------------------------------------- */
		#main > #footer{
			width:790px;
			height:230px;
			border:2px solid #676767;
			border-radius:5px;
			margin: 0 10p 0 8px;
			display:flex;
		}
		#footer_box1{
			width:40px;
			height:100%;
			background:#686868;
		}
		#footer  ul ,li{
			list-style: none;
			margin: 5px 0 0 3px ;
			padding:0px;
			font-size: 12px;
		}
		/* side-------------------------------------------------------- */
		#side{
			padding:15px;
			border-radius:10px;
			width:310px;
			height:800px;/* 915px */
			margin-top:10px;
			background:#353535;
		}
		.side_box{
		
			width:100%;
			border-bottom:1px solid #262626;
		}
		.side_box1{
			height:30%;
			display:flex;
		}
		#side_box1_box1{
			width:55%;
			height:100%;
		}
		#side_box1_box2{
			width:50%;
			height:100%;
			display:flex;
			justify-content:flex-start;
			align-items:flex-start;
		}
		
		.side_table  tr td{
			padding-top:10px;
			color:white;
		}
		.side_box2{
			height:30%;
		}
		.side_table1{
			margin:0px 0 0 0px;
		}
		.side_table1  tr td{
			padding-bottom:10px;
			color:white;
			font-size:13px;
		}
		.side_table1  tr td:nth-child(1){
			color:#7F7F7F;
		}
		.side_box3{
			height:27%;
		}
		.side_box4{
			height:15%;
			border-bottom:0px;
		}
		#side_box4_box1{
			border:1px solid #262626;
			border-radius:3px;
			width:80%;
			height:40px;
			background:#404040;
			margin:20px 0 0 30px;
			display:flex;
			align-items:center;
			justify-content: space-around;
		}
		/* -------------------------------------------------------- */
		
	</style>
	
	<script type="text/javascript">
	$(function(){
		console.log("plz");
		console.log("${pay_step3_coupon}");
		console.log("${pay_step3_list}");
		// 이전단계 버튼
		$("#prevBtn").click(function(){
			window.history.back();
			}) 
		// 다음단계 버튼
		$("#nextBtn").click(function(){
				payForm();
				$("#pay_step3_Form").attr({
					"method":"post",
					"action":"/client/payPage/pay_step4"
				});
				$("#pay_step3_Form").submit();
			})
			
		//결제내역 method
		let discountChildren = $("#discountChildrenTd").text();
		let totalAmountFirst = $("#totalAmountTd").text();
		let discountCoupon = "";
		//결제내역 값 폼 데이터 설정
		function payForm(){
			$("#ticketAmount").val($("#totalTicketTd").text());
			$("#discountCoupon").val($("#discountCouponTd").text());
			$("#discountChildren").val($("#discountChildrenTd").text());
			$("#discountAmount").val($("#discountTotalTd").text());
			$("#totalAmount1").val($("#totalAmountTd").text());
			$("#totalAmount2").val($("#totalAmount").text());
		}
		
		
		function priceList(c_discount_val){
			let totalTicket = $("#totalTicketTd").text();	
			let discountCoupon = totalTicket * (Number(c_discount_val)/100);
			$("#discountCouponTd").text(discountCoupon);
			let discountTotal = $("#discountTotalTd").text(0);
			discountTotal = $("#discountTotalTd").text();
			$("#discountTotalTd").text(Number(discountChildren) + Number(discountCoupon));
			$("#totalAmount").text();
			let totalAmount = totalAmountFirst;
			$("#totalAmountTd").text(Number(totalAmount) - Number(discountCoupon));
			
			var totalAmountFormat = /\B(?=(\d{3})+(?!\d))/g;
			var totalAmountNum = Number(totalAmount) - Number(discountCoupon);
			var totalAmountFormating = totalAmountNum.toString().replace(totalAmountFormat,',');
			$("#totalAmount").text(totalAmountFormating+"원");
		}
		//결제내역 method 끝
		
		// 전체해제 버튼
		 $("#radioCancelBtn").click(function(){
			$('.coupon_radio').prop('checked',false);
			priceList(0);
			$("#couponDiv").children("#c_num").remove();
		}) 
		// 쿠폰 리스트 선택
		$(document).on("click",".coupon_radio",function(){
			let c_discount_val = $(this).parents().siblings(".c_discount").text();
			let c_num_val = $(this).parents().siblings(".c_num").text();
			let couponForm = "<input type='hidden' name='c_num' id='c_num' value='"+c_num_val+"'>";
			$("#couponDiv").children("#c_num").remove();
			$("#couponDiv").append(couponForm);
			
			 if($(".coupon_radio").prop("checked",true)){
				$('.coupon_radio').prop('checked',false);
			    $(this).prop('checked',true);
			    priceList(c_discount_val);
			}else{
			} 
		})
		
		// 
	});
	</script>

	</head>	
	
	
	<body>	
	<form id="pay_step3_Form" name = "pay_step3_Form">
		<input type="hidden" name="hall_date" id="hall_date" value="${pay_step3_list.hall_date}">
		<input type="hidden" name="th_num" id="th_num" value="${pay_step3_list.th_num}">
		<input type="hidden" name="hall_id" id="hall_id" value="${pay_step3_list.hall_id}">
		<input type="hidden" name="s_num" id="s_num" value="${detailData.s_num}">
	
		<div id="couponDiv"></div>
		<c:set var="countSeatFormData" value="0"/>
		<c:set var="countSeatFormDataP" value="1"/>
		<c:forEach var="list" items="${SeatMapData}" varStatus="status">
			<input type="hidden" name="SeatList['${countSeatFormData}'].seat_num" value="${list.seat_num}">
			<input type="hidden" name="SeatList['${countSeatFormData}'].seat_age" value="${list.seat_age}">
			<input type="hidden" name="SeatList['${countSeatFormData}'].seat_name" value="${list.seat_name}">
			<c:set var="countSeatFormData" value="${countSeatFormData + countSeatFormDataP}"/>
		</c:forEach>
		<!-- 결제내역리스트 -->
		<input type="hidden" name="ticketAmount" id="ticketAmount">
		<input type="hidden" name="discountCoupon" id="discountCoupon">
		<input type="hidden" name="discountChildren" id="discountChildren">
		<input type="hidden" name="discountAmount" id="discountAmount">
		<input type="hidden" name="totalAmount1" id="totalAmount1">
		<input type="hidden" name="totalAmount2" id="totalAmount2">
	</form>
	<div id="main">
		<div id="header">
			<img src="/resources/image/001.png" alt="QUICKet로고" width="120" height="45" style="position:relative;bottom:10px;right:18px;"/>
			<div class="step step1" style="background:#7A7A7B">
				<span style="margin:0 0 10px 5px;"><span style="color:#B3B3B3;font-size:12px;font-weight:bold;">step1</span><br>
				<span style="font-size:16px;color:white;font-weight:bold;">관람일/회차</span></span>
			</div>
			<div class="step step2" style="background:#676767;">
				<span style="margin:0 0 10px 5px;"><span style="color:#B3B3B3;font-size:12px;font-weight:bold;">step2</span><br>
				<span style="font-size:16px;color:white;font-weight:bold;">좌석선택</span></span>
			</div>
			<div class="step step3" style="background:white;border:3px solid #666666"><!-- #666666 -->
				<span style="margin:0 0 10px 5px;"><span style="color:#3A85C7;font-size:12px;font-weight:bold;">step3</span><br>
				<span style="font-size:16px;font-weight:bold;">할인/쿠폰<span style="color:#00B0F0;">∨</span></span></span>
			</div>
			<div class="step step4" style="background:#535354;">
				<span style="margin:0 0 10px 5px;"><span style="color:#B3B3B3;font-size:12px;font-weight:bold;">step4</span><br>
				<span style="font-size:16px;color:white;font-weight:bold;">결제방법</span></span>
			</div>
		</div>
		<div id="subMain">
			<div id="subMain_box">
				<div class="subMain_box1" style="width:90%;margin:10px 0 0 30px;">
					<div class="subMain_box2">
						<span style="font-size:14px;color:white;margin-left:5px;">쿠폰</span>
					</div>
						<%-- ==========리스트시작================== --%>
						<div id="pay_step3_coupon" class="table-height" > 
							<table summary="게시판 리스트" class="couponTable table table-striped">
								<thead>
									<tr>
										<th class="text-center col-md-2">쿠폰 번호</th>
										<th class="text-center col-md-4">쿠폰 이름</th>
										<th class="text-center col-md-2">할인율</th>
										<th class="text-center col-md-3">유효기간</th>
										<th class="text-center col-md-1">선택</th>
									</tr>
								</thead>
								<tbody id="list" class="table-striped">
								
									<!--데이터 출력 -->
									<c:choose>
										<c:when test="${not empty pay_step3_coupon}">
											
											<c:forEach var="coupon" items="${pay_step3_coupon}" varStatus="status">
												<tr class="text-center" data-num="${coupon.c_num}">
													<td class="c_num">${coupon.c_num}</td>
													<td class="text-center">${coupon.c_name}</td>
													<td class="text-center c_discount">${coupon.c_discount}</td>
													<td class="text-center">${coupon.c_enddate}</td>
													<td class="text-center"><input type="checkbox" class="coupon_radio"></td>
												</tr>
											</c:forEach>
											<tr>
												<td ></td>
												<td ></td>
												<td ></td>
												<td ></td>
												<td ><input type="button" id="radioCancelBtn" value="전체해제"></td>
											</tr>
										</c:when>
										<c:otherwise>
											<tr>
												<td colspan="4" class="tac text-center">보유하신 쿠폰이 없습니다.</td>
											</tr>
										</c:otherwise>
									</c:choose>
								
								</tbody>
							</table>
						</div>	 
				</div>
			</div>
		</div>
		<div id="footer">
			<div id="footer_box1">
				<span style="writing-mode:vertical-rl; color:white; margin:60px 0 0 8px; font-size:18px;">
				유 의 사 항
				</span>
			</div>
			<div id="footer_box2">
				<ul>
					<li>- 안내되어 있는 잔여석은 결제 진행 중인 좌석을 포함하고 있어 예매 가능 좌석과 다를 수 있습니다.</li>
					<li>- 어린이 할인 등 증빙서류가 필요한 경우 현장수령만 가능하며, 현장에서 증빙서류 미지참 시 차액 지불하셔야 합니다.</li>
					<li>- 7세 이하 아동의 어린이 할인은 30% 입니다.</li>
					<li style="color:red;">- 할인은 자동선택 되지 않으니, 적용 받고자 하는 할인이 있는 경우 직접 선택해주시기 바랍니다.</li>
					<li style="color:red;">- 쿠폰은 한 번에 1개씩만 적용 가능합니다.</li>
					<li>- 예매 취소 내용.</li>
				</ul>
			</div>
		</div>
	</div>
	<div id="side">
		<div class="side_box side_box1">
			<div id="side_box1_box1">
				<img src=
						<c:if test="${detailData.s_posterimg ne null}">
							"/uploadStorage${detailData.s_posterimg.img_dir}/${detailData.s_posterimg.img_name}.${detailData.s_posterimg.img_type}"
						</c:if>
						<c:if test="${detailData.s_posterimg eq null}">
							"/uploadStorage/show/poster_default.jpg"
						</c:if>
						style="width:90%;height:85%;margin:10px 0 0 5px"/>
			</div>
			<div id="side_box1_box2">
				<table class="side_table">
					<tr><td><h4>${pay_step3_list.s_name}</h4></td></tr>
					<tr><td style="font-size:14px;">${pay_step3_list.s_opendate}~${pay_step3_list.s_closedate}</td></tr>
					<tr><td style="font-size:14px;">${pay_step3_list.th_name}</td></tr>
				</table>
			</div>
		</div>
		<div class="side_box side_box2">
				<table class="side_table1">
					<tr><td><h3 style="color:white;">선택내역</h3></td></tr>
					<tr><td>날짜</td>
						<td>${pay_step3_list.hall_date}</td>
					</tr>
					<tr><td>관</td>
						<td>${pay_step3_list.hall_place}</td>
					</tr>
					<tr><td>시간</td>
						<td>[${pay_step3_list.hall_turn}]${pay_step3_list.hall_time}</td>
					</tr>
					<tr><td>매수</td>
						<td>
					
							<c:set var="countAdult" value="0"/>
							<c:set var="countChildren" value="0"/>
							<c:set var="totalTicket" value="0"/>
							<c:set var="ticketAmount" value="${pay_step3_list.s_price}"/>
							<c:set var="discountChildren" value="0"/>
							<c:set var="discountCoupon" value="0"/>
							<c:set var="discountTotal" value="0"/>
							<c:set var="totalAmount" value="0"/>
							
							<c:choose>
								<c:when test="${not empty SeatMapData}">
									<c:forEach var="list" items="${SeatMapData}" varStatus="status">
										<!-- 성인 어린이 매수 카운트 -->
										<c:choose>
											<c:when test="${fn:contains(list.seat_age,'성인')}">
												<c:set var="countAdult" value="${countAdult + 1}"/>
											</c:when>
											<c:when test="${fn:contains(list.seat_age,'어린이')}">
												<c:set var="countChildren" value="${countChildren + 1}"/>
											</c:when>
										</c:choose>
										<!-- 총금액 -->
										<c:set var="totalTicket" value="${totalTicket + ticketAmount}"/>
									</c:forEach>
										<!-- 어린이 할인 -->
										<c:set var="discountChildren" value="${ticketAmount*countChildren*(30/100)}"/>
										<!-- 어린이 할인 소수점 제거 -->
										<fmt:parseNumber var="discountChildren" value="${discountChildren}" integerOnly="true"/>
										<!-- 쿠폰 할인 -->
										<!-- 총할인 -->
										<c:set var="discountTotal" value="${discountChildren + discountCoupon}"/>
										<!-- 총금액 - 할인금액 -->
										<c:set var="totalAmount" value="${totalTicket - discountTotal}"/>
										
										<!-- 매수 출력 -->
									성인 <c:out value="${countAdult}"/>  어린이 <c:out value="${countChildren}"/>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="4" class="tac text-center">등록된 좌석이 존재하지 않습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
							
						</td>
					</tr>
					<tr><td>좌석</td>
						<td>
							<div class="seat_div" style="overflow:auto;width:50px;height:50px;">
								<c:choose>
									<c:when test="${not empty SeatMapData}">
										<c:forEach var="list" items="${SeatMapData}" varStatus="status">
										${list.seat_name}
											<br />
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="4" class="tac text-center">등록된 좌석이 존재하지 않습니다.</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</div>
						</td>
					</tr>
				</table>
		</div>
		
		<div class="side_box side_box3">
			<table class="side_table1">
					<tr><td><h3 style="color:white;">결제내역</h3></td></tr>
					<tr><td>티켓금액</td>
						<!-- 금액 콤마 파싱 -->
						<td id="totalTicketTd"><c:out value="${totalTicket}"/></td>
					</tr>
					<tr><td>할인(쿠폰)</td>
						<td id="discountCouponTd">0</td>
					</tr>
					<tr><td>할인(어린이)</td>
						<td id="discountChildrenTd"><c:out value="${discountChildren}"/></td>
					</tr>
					<tr><td>할인금액</td>
						<td id="discountTotalTd"><c:out value="${discountTotal}"/></td>
					</tr>
					<tr><td>결제금액</td>
						<td id="totalAmountTd"><c:out value="${totalAmount}"/></td>
					</tr>
				</table>
		</div>
		<div class="side_box side_box4">
			<div id="side_box4_box1">
				<h4 style="color:white;font-size:15px;">최종 결제금액</h4>
				<!-- 금액 콤마 파싱 -->
				<fmt:formatNumber var="totalAmount" value="${totalAmount}" pattern="#,###"/>
				<span style="color:white;" id="totalAmount"><c:out value="${totalAmount}"/>원</span>
			</div>
			<div style="display:flex;">
			<button id ="prevBtn" style="background:#7F9CB7;border:0;width:160px;height:30px;color:white;
			margin:17px 0 0 5px;">이전단계</button>
			<button id ="nextBtn" style="background:#7F9CB7;border:0;width:160px;height:30px;color:white;
			margin:17px 0 0 25px;">다음단계</button>
			</div>
		</div>
	</div>
	</body>
</html>