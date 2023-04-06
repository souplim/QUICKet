<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/popup.jspf" %>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix= "fn" uri= "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix= "fmt" uri= "http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="/resources/include/js/common.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    
<link href="/resources/include/dist/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>

	<style>
		body{
			width:980px;
			height:915px;
			display:flex;
			flex-wrap:nowrap;
			border: 1px solid gray;
		}
		/* main-------------------------------------------------------- */
		#main{
			width:690px;
			height:100%;
		}
		/* header-------------------------------------------------------- */
		#main > #header{
			width:100%;
			height:100px;
			background:#4A4A4A;
			display:flex;
			justify-content:flex-end;
			align-items:flex-end;
		}
		#logo{
			width:127px;
			height:75px;
			background:gray;
			margin:0 10px 10px 0;
			
		}
		.step{
			width:135px;
			height:90px;
			display:flex;
			align-items:center;
		}
		/* subMain-------------------------------------------------------- */
		#main > #subMain{
			width:100%;
			height:585px;
		}
		#subMain_box{
			width:670px;
			height:565px;
			margin: 9px 0 0 8px;
			display:flex;
		}
		.subMain_box1{
			width:100%;
			height:100%;
			border:2px solid lightgray;
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
			width:668px;
			height:210px;
			border:2px solid lightgray;
			margin: 0 0 0 8px;
			display:flex;
		}
		#footer_box1{
			width:40px;
			height:100%;
			background:#7F7F7F;
		}
		#footer  ul ,li{
			list-style: none;
			margin: 5px 0 0 3px ;
			padding:0px;
			font-size: 12px;
		}
		/* side-------------------------------------------------------- */
		#side{
			width:290px;
			height:100%;/* 915px */
			background:#4A4A4A;
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
			height:25%;
		}
		.side_box4{
			height:15%;
			border-bottom:0px;
		}
		#side_box4_box1{
			border:1px solid #262626;
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
		
		// 이전단계 버튼
		$("#prevBtn").click(function(){
			window.history.back();
		})
		// 결제 메서드 (2.5번째 수행)
		var IMP = window.IMP; 
        IMP.init("imp57026378");
        function requestPay(pay_num, pay_name, pay_phone, pay_email, pay_amount, s_name) {
            IMP.request_pay({
                pg : 'html5_inicis',
                pay_method : 'card',
                merchant_uid: pay_num, 
                name : s_name,
                amount : pay_amount,
                buyer_email : pay_email,
                buyer_name : pay_name,
                buyer_tel : pay_phone,
            }, function (rsp) { // callback
            	
                if (rsp.success) {
                	$.ajax({
                        url: "/api/v1/payment/complete", // 예: https://www.myservice.com/payments/complete
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        data: {
                            imp_uid: rsp.imp_uid,
                            merchant_uid: rsp.merchant_uid
                        },success : function(result){
    				    	if(result == "payInsertFail"){
    				    		alert("결제테이블 insert 실패");
    				    	}
    				    	else{/* 성공 */
    	                    	const arr = result.split(",");
    	                    	imp_uid1 = arr[0];
    	                    	token1 = arr[1];
    	                     	// 결제 테이블 결제 상태 값 Update
    	                    	payStatusUpdate(pay_num, imp_uid1, token1);
    	                    	// 좌석 테이블 상태 값 Update
    	                    	seatStatusUpdate();
    	                    	// 쿠폰 테이블 상태값 Update
    	                    	couponStatusUpdate();
    	                    	// 예매 테이블 Insert
    	                    	ticketInsert(pay_num);
    	                    	// 예매 좌석 테이블 Insert
    	                    	ticketSeatInsert(pay_num);
    	                        alert("결제 완료되었습니다."); 
    	                        location.href="/client/payPage/ticketSuccessPage?pay_num="+pay_num+"&s_num="+"${detailData.s_num}";
    				    	}
    				    },
    					error 	: function(xhr, textStatus, errorThrown) {
    						alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
    				    }
                	
                	})
                } else {
                	//결제 중 창을 닫았을 때 취소 시 결제 테이블 데이터 삭제
                	payDelete(pay_num);
                	alert("결제를 취소하였습니다. 다시 시도해 주세요.");
                    
                }
                
            });
        }
        
        //결제버튼 클릭 시 결제 테이블 Insert (1번 수행)
        $(document).on("click", "#requestBtn", function(){
			 let insertUrl = "/client/payJson/payInsert";
			 /* JSON.stringify(): JAvaScript 값이나 객체를 JSON 문자열로 변환. */
			 let value= JSON.stringify({
				 u_id : "${pay_step4_UserData.u_id}",
				 pay_name : $("#pay_name").val(),
				 pay_phone : $("#pay_phone").val(),
				 pay_email : $("#pay_email").val(),
				 pay_amount : 100
				 /* pay_amount : $("#totalAmountTd").text() */
			 });
			 
			 $.ajax({
					url  : insertUrl,
					type : "post",
					headers : {
						"Content-Type":"application/json"
					},
					dataType:"text",
					data : value,
					error 	: function(xhr, textStatus, errorThrown) {
						alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
				    },
				    beforeSend	: function() {
				    	 if(!checkForm("#pay_name", "이름을")) return false;
				    	else if(!checkForm("#pay_phone", "전화번호를")) return false;
				    	else if(!checkForm("#pay_email", "이메일을")) return false; 
				    },
				    success : function(result){
				    	if(result == "payInsertFail"){
				    		alert("결제테이블 insert 실패");
				    	}
				    	else{/* 성공 */
				    		SelectPayInfo(result);
				    	}
				    }
				});
        });
			// 결제할 데이터 가져오기 (2번 수행)
				function SelectPayInfo(pay_num){
					let url = "/client/payJson/payInfo/"+pay_num; 
					$.ajaxSetup({
						async:false
					});
					$.getJSON(url, function(data){
						$(data).each(function(){
							let pay_num = this.pay_num;
							let pay_name = this.pay_name;
							let pay_phone = this.pay_phone;
							let pay_email = this.pay_email;
							let pay_amount = this.pay_amount;
							let s_name = "${pay_step4_list.s_name}";
							requestPay(pay_num,pay_name,pay_phone,pay_email,pay_amount,s_name);
						});
					}).fail(function(){
						alert("결제데이터 목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해 주세요.")				
					})
				}
		//결제 진행 중 취소할 시 결제 테이블 인서트 삭제 (3번 수행)
		 function payDelete(pay_num1){
				let DeleteUrl = "/client/payJson/payDelete";
				 /* JSON.stringify(): JAvaScript 값이나 객체를 JSON 문자열로 변환. */
				 let data_val = JSON.stringify({pay_num : pay_num1});
				 $.ajax({
						url  : DeleteUrl,
						type : "post",
						headers : {
							"Content-Type":"application/json"
						},
						dataType:"text",
						data : data_val,
						error 	: function(xhr, textStatus, errorThrown) {
							alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
					    },
					    success : function(result){
					    	if(result == "SUCCESS"){
					    		console.log("결제 테이블 delete 완료");
					    	}
					    }
					});
		 }
		//결제 테이블 결제 상태 1로 변경 (4번 수행)
		 function payStatusUpdate(pay_num1, imp_uid1, token1){
				let UpdateUrl = "/client/payJson/payStatusUpdate";
				 /* JSON.stringify(): JAvaScript 값이나 객체를 JSON 문자열로 변환. */
				 let data_val = JSON.stringify({pay_num : pay_num1,
					 							imp_uid : imp_uid1,
					 							token : token1});
				 $.ajax({
						url  : UpdateUrl,
						type : "post",
						headers : {
							"Content-Type":"application/json"
						},
						dataType:"text",
						data : data_val,
						error 	: function(xhr, textStatus, errorThrown) {
							alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
					    },
					    success : function(result){
					    	if(result == "SUCCESS"){
					    		console.log("결제 테이블 update 완료");
					    	}
					    }
					});
		 }
		 
		//좌석 테이블 결제 상태 1로 변경 (5번 수행)
		 function seatStatusUpdate(){
				let UpdateUrl = "/client/payJson/seatStatusUpdate";
				let data_val_arr = [];
				 /* JSON.stringify(): JAvaScript 값이나 객체를 JSON 문자열로 변환. */
					 <c:forEach var="list" items="${SeatMapData}" varStatus="status">
					 	data_val_arr.push("${list.seat_num}");
					 	data_val_arr.push("${list.seat_age}");
					 	data_val_arr.push("${pay_step4_list.hall_id}");
					</c:forEach>
					console.log(data_val_arr);
					console.log(JSON.stringify(data_val_arr));
				  $.ajax({
						url  : UpdateUrl,
						type : "post",
						headers : {
							"Content-Type":"application/json"
						},
						dataType:"text",
						data : JSON.stringify(data_val_arr),
						error 	: function(xhr, textStatus, errorThrown) {
							alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
					    },
					    success : function(result){
					    	if(result == "SUCCESS"){
					    		console.log("좌석 테이블 update 완료");
					    	}
					    }
					}); 
		 }
		
		//쿠폰 테이블 결제 상태 1로 변경 (6번 수행)
		 function couponStatusUpdate(){
				let UpdateUrl = "/client/payJson/couponStatusUpdate";
				let data_val = JSON.stringify({c_num : "${CouponVOData.c_num}",
												u_id : "${pay_step4_UserData.u_id}"
				});
				  $.ajax({
						url  : UpdateUrl,
						type : "post",
						headers : {
							"Content-Type":"application/json"
						},
						dataType:"text",
						data : data_val,
						error 	: function(xhr, textStatus, errorThrown) {
							alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
					    },
					    success : function(result){
					    	if(result == "SUCCESS"){
					    		console.log("쿠폰 테이블 update 완료");
					    	}
					    	else if(result == "NOCHOICE"){
					    		console.log("쿠폰을 선택하지 않음.");
					    	}
					    }
					}); 
		 }
		
		// 예매 테이블 Insert (7번 수행)
		 function ticketInsert(pay_num1){
				let UpdateUrl = "/client/payJson/ticketInsert";
				let data_val = JSON.stringify({pay_num : pay_num1,
												u_id : "${pay_step4_UserData.u_id}"
				});
				  $.ajax({
						url  : UpdateUrl,
						type : "post",
						headers : {
							"Content-Type":"application/json"
						},
						dataType:"text",
						data : data_val,
						error 	: function(xhr, textStatus, errorThrown) {
							alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
					    },
					    success : function(result){
					    	if(result == "SUCCESS"){
					    		console.log("예매 테이블 Insert 완료");
					    	}
					    }
					}); 
		 }
		
		// 예매좌석 테이블 INSERT (8번 수행)
		 function ticketSeatInsert(pay_num1){
				let InsertUrl = "/client/payJson/ticketSeatInsert";
				let data_val_arr = [];
				 /* JSON.stringify(): JAvaScript 값이나 객체를 JSON 문자열로 변환. */
					 <c:forEach var="list" items="${SeatMapData}" varStatus="status">
					 	data_val_arr.push("${list.seat_num}");
					 	data_val_arr.push("${pay_step4_list.hall_id}");
					 	data_val_arr.push(pay_num1);
					</c:forEach>
				  $.ajax({
						url  : InsertUrl,
						type : "post",
						headers : {
							"Content-Type":"application/json"
						},
						dataType:"text",
						data : JSON.stringify(data_val_arr),
						error 	: function(xhr, textStatus, errorThrown) {
							alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
					    },
					    success : function(result){
					    	if(result == "SUCCESS"){
					    		console.log("예매좌석 테이블 insert 완료");
					    	}
					    }
					}); 
		 }
        
        
	});
	</script>

	</head>	
	
	
	<body>	
	<form id="pay_step3_Form" name = "pay_step3_Form">
		<input type="hidden" name="hall_date" id="hall_date" value="${pay_step4_list.hall_date}">
		<input type="hidden" name="th_num" id="th_num" value="${pay_step4_list.th_num}">
		<input type="hidden" name="hall_id" id="hall_id" value="${pay_step4_list.hall_id}">
		<input type="hidden" name="c_num" id="c_num" value="${CouponVOData.c_num}">
		<input type="hidden" name="s_num" id="s_num" value="${detailData.s_num}">
		<c:set var="countSeatFormData" value="0"/>
		<c:set var="countSeatFormDataP" value="1"/>
		<c:forEach var="list" items="${SeatMapData}" varStatus="status">
			<input type="hidden" name="SeatList['+${countSeatFormData}+'].seat_num" value="${list.seat_num}">
			<input type="hidden" name="SeatList['+${countSeatFormData}+'].seat_age" value="${list.seat_age}">
			<input type="hidden" name="SeatList['+${countSeatFormData}+'].seat_name" value="${list.seat_name}">
			<c:set var="countSeatFormData" value="${countSeatFormData + countSeatFormDataP}"/>
		</c:forEach>
	</form>
	<div id="main">
		<div id="header">
			<div id="logo">
			
			</div>
			<div class="step step1" style="background:#D9D9D9;">
				<span style="margin:0 0 10px 5px;"><span style="color:#595959;font-size:12px;font-weight:bold;">step1</span><br>
				<span style="font-size:16px;color:white;font-weight:bold;">관람일/회차</span></span>
			</div>
			<div class="step step2" style="background:#BFBFBF;">
				<span style="margin:0 0 10px 5px;"><span style="color:#595959;font-size:12px;font-weight:bold;">step2</span><br>
				<span style="font-size:16px;color:white;font-weight:bold;">좌석선택</span></span>
			</div>
			<div class="step step3" style="background:#A6A6A6;">
				<span style="margin:0 0 10px 5px;"><span style="color:#595959;font-size:12px;font-weight:bold;">step3</span><br>
				<span style="font-size:16px;color:white;font-weight:bold;">할인/쿠폰</span></span>
			</div>
			<div class="step step4" style="background:white;">
				<span style="margin:0 0 10px 5px;"><span style="color:#00B0F0;font-size:12px;font-weight:bold;">step4</span><br>
				<span style="font-size:16px;font-weight:bold;">결제방법<span style="color:#00B0F0;">∨</span></span></span>
			</div>
		</div>
		<div id="subMain">
			<div id="subMain_box">
				<div class="subMain_box1">
					<div class="subMain_box2">
						<span style="font-size:14px;color:white;margin-left:5px;">결제</span>
					</div>
					<table class="table table-bordered">
					<tr>
						<td class="col-md-3">이름</td>
						<td class="col-md-3"><input type="text" id="pay_name" value="${pay_step4_UserData.u_name}"></td>
					</tr>
					<tr>
						<td class="col-md-3">전화번호</td>
						<td class="col-md-3"><input type="text" id="pay_phone" value="${pay_step4_UserData.u_phone}"></td>
					</tr>
					<tr>
						<td class="col-md-3">이메일</td>
						<td class="col-md-3"><input type="text" id="pay_email" value="${pay_step4_UserData.u_email}"></td>
					</tr>
					<tr>
						<td class="col-md-3"></td>
						<td><button id = "requestBtn" >결제하기</button></td>
					</tr>
					</table>
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
					<li>- 할인은 자동선택 되지 않으니, 적용 받고자 하는 할인이 있는 경우 직접 선택해주시기 바랍니다.</li>
					<li>- 쿠폰은 한 번에 1개씩만 적용 가능합니다.</li>
					<li style="color:red;">- 예매 취소 내용.</li>
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
						style="width:90%;height:85%;margin:10px 0 0 5px"/>			</div>
			<div id="side_box1_box2">
				<table class="side_table">
					<tr><td><h4>${pay_step4_list.s_name}</h4></td></tr>
					<tr><td style="font-size:14px;">${pay_step4_list.s_opendate}~${pay_step4_list.s_closedate}</td></tr>
					<tr><td style="font-size:14px;">${pay_step4_list.th_name}</td></tr>
				</table>
			</div>
		</div>
		<div class="side_box side_box2">
				<table class="side_table1">
					<tr><td><h3 style="color:white;">선택내역</h3></td></tr>
					<tr><td>날짜</td>
						<td>${pay_step4_list.hall_date}</td>
					</tr>
					<tr><td>관</td>
						<td>${pay_step4_list.hall_place}</td>
					</tr>
					<tr><td>시간</td>
						<td>[${pay_step4_list.hall_turn}]${pay_step4_list.hall_time}</td>
					</tr>
					<tr><td>매수</td>
						<td>
					
							
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
						<td id="totalTicketTd">${AmountVOData.ticketAmount}</td>
					</tr>
					<tr><td>할인(쿠폰)</td>
						<td id="discountCouponTd">${AmountVOData.discountCoupon}</td>
					</tr>
					<tr><td>할인(어린이)</td>
						<td>${AmountVOData.discountChildren}</td>
					</tr>
					<tr><td>할인금액</td>
						<td id="discountTotalTd">${AmountVOData.discountAmount}</td>
					</tr>
					<tr><td>결제금액</td>
						<td id="totalAmountTd">${AmountVOData.totalAmount1}</td>
					</tr>
				</table>
		</div>
		<div class="side_box side_box4">
			<div id="side_box4_box1">
				<h4 style="color:white;">최종 결제금액</h4>
				<!-- 금액 콤마 파싱 -->
				<span style="color:white;" id="totalAmount">${AmountVOData.totalAmount2}</span>
			</div>
			<div style="display:flex;">
			<button id ="prevBtn" style="background:#757bf6;border:0;width:90px;height:35px;color:white;
			margin:30px 0 0 35px;">이전단계</button>
			</div>
		</div>
	</div>
	</body>
</html>