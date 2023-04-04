<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/popup.jspf" %>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix= "fn" uri= "http://java.sun.com/jsp/jstl/functions" %>

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
			width:70%;
			height:100%;
			border:2px solid lightgray;
			display:flex;
			flex-wrap:wrap;
			justify-content:center;
		}
		#subMain_seatBox{
			width:300px;
			height:250px;
			border:5px solid gray;
			display:flex;
			flex-wrap:nowrap;
			border-radius:10px;
			padding:5px;
		}
		#seatBox_name{
			width:40px;
			height:200px;
			display:flex;
			justify-content:space-around;
			flex-direction: column;
			}
		.seat_rowName{
			width:20px;
			height:20px;
			background:black;
			color:white;
		}
		.lineBox{
			width:250px; 
			height:300px;
			display:flex;
			justify-content:space-around;
			flex-direction: column;
		}	
		.line{
			display:flex;
			justify-content:center;
			align-items:center;
		}
		.goDetail{
			width:15px;height:15px;background:#00c3c1;margin-right:5px;border-radius:5px;text-align:center;font-size:12px;color:white;
		}
		.status_1{
			background:gray;
		}
		.subMain_box1_1{
			width:30%;
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
		.ticket_info{
			width:320px;
			height:340px;
			display:flex;
			align-items:flex_start;
			justify-content: center;
			flex-wrap:wrap;
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
		.seatColor{
			background:gray;
		}
		.seatColor2{
			background:red;
		}
		
		/* -------------------------------------------------------- */
		
	</style>
	
	<script type="text/javascript">
	$(function(){
		$(document).ready(function() {
			
			for(let i =1; i <= ${pay_step2_list.hall_seatNum}; i++){
				if(i < 7){
					$(".lineA").append($('.'+i));
				}else if(i >= 7 & i < 13){
					$(".lineB").append($('.'+i));
				}else if(i >= 13 & i < 23){
					$(".lineC").append($('.'+i));
				}else if(i >= 23 & i < 33){
					$(".lineD").append($('.'+i));
				}else if(i >= 33 & i < 43){
					$(".lineE").append($('.'+i));
				}else if(i >= 43 & i < 53){
					$(".lineF").append($('.'+i));
				}
			}			
		});
		
		// Map 선언
		Map = function(){
			 this.map = new Object();
			};  
			Map.prototype = {  
			    put : function(key, value){  
			        this.map[key] = value;
			    },  
			    get : function(key){  
			        return this.map[key];
			    },
			    containsKey : function(key){   
			     return key in this.map;
			    },
			    containsValue : function(value){   
			     for(var prop in this.map){
			      if(this.map[prop] == value) return true;
			     }
			     return false;
			    },
			    isEmpty : function(key){   
			     return (this.size() == 0);
			    },
			    clear : function(){  
			     for(var prop in this.map){
			      delete this.map[prop];
			     }
			    },
			    remove : function(key){   
			     delete this.map[key];
			    },
			    keys : function(){  
			        var keys = new Array();  
			        for(var prop in this.map){  
			            keys.push(prop);
			        }  
			        return keys;
			    },
			    values : function(){  
			     var values = new Array();  
			        for(var prop in this.map){  
			         values.push(this.map[prop]);
			        }  
			        return values;
			    },
			    size : function(){
			      var count = 0;
			      for (var prop in this.map) {
			        count++;
			      }
			      return count;
			    }
			};
		// 좌석도
		var seatMap = new Map();
		let adult_count = 0;
		let children_count = 0;
		let ageTrue = false;
		
		let countSeatFormData = 0;
		// 좌석 선택
		function seatMapInput(seatNum){
			let checked_val = "";
			for(let i =0; i < $(".adult_children").length; i++){
				if($(".adult_children")[i].checked == true){
					checked_val = $(".adult_children")[i].value;
					ageTrue = true;
				}else if(!($(".adult_children")[0].checked) && !($(".adult_children")[1].checked)){
					alert("연령을 선택해주세요.");
					ageTrue = false;
					return;
				}
			}
			seatMap.put(seatNum,checked_val);
			countPeple();
			// -- seatNum + 1에 대한 설명: 좌석의 나열은 index(0부터 시작) 좌석 번호는 1부터 시작하기 때문에 
			let seatFormData = "<input type='hidden' name='SeatList["+countSeatFormData+"].seat_num' value='"+(seatNum+1)+"'>"+
								"<input type='hidden' name='SeatList["+countSeatFormData+"].seat_age' value='"+checked_val+"'>"+
								"<input type='hidden' name='SeatList["+countSeatFormData+"].seat_name' value='"+$('.choiceSeatDiv').text()+"'>";
			$("#pay_step2_Form").append(seatFormData);
			countSeatFormData++;
			
			
			/* 결제내역 */
			$("#totalTicketTd").text(${pay_step2_list.s_price}*countSeatFormData);
			let totalTicket = $("#totalTicketTd").text();	
			$("#discountChildren").text(${pay_step2_list.s_price}*children_count*(30/100));
			$("#discountTotalTd").text(${pay_step2_list.s_price}*children_count*(30/100));
			let discountTotalTd = $("#discountChildren").text();
			
			$("#totalAmountTd").text(Number(totalTicket) - Number(discountTotalTd));
			let totalAmount = $("#totalAmountTd").text();
			
			var totalAmountFormat = /\B(?=(\d{3})+(?!\d))/g;
			var totalAmountNum = Number(totalAmount);
			var totalAmountFormating = totalAmountNum.toString().replace(totalAmountFormat,',');
			$("#totalAmount").text(totalAmountFormating+"원");
				
			
		}
		function countPeple(){
			adult_count = 0;
			children_count = 0;
			for(let i =0; i < seatMap.size(); i++){
				if(seatMap.values()[i] == "성인"){
					adult_count++;
				}else if(seatMap.values()[i] == "어린이"){
					children_count++;
				}
			}
		}
		let seatNVal = "";
		$("#seatSelectBtn").on("click",function(){
			let i = 0;
			
			$(".goDetail").each(function(index){
				if($(this).children("span").text() == "✓"){
					i = index;
					seatMapInput(i);
					if(!ageTrue){
						return;
					}
					$(this).toggleClass("seatColor");
					$(this).toggleClass("seatColor2");
					$(this).children("span").text("");
					seatNVal = "<p>"+$(this).children(".seatN").val()+"<p>";
					$(".seat_div").append(seatNVal);
				}
			})
			
			countPeple();
			$(".count_div").text("성인: "+ adult_count + "어린이: "+ children_count);
			
			
			
		})
		$(document).on("click",".goDetail",function(e){
			
			// 좌석 상태가 1이면 클릭 안됨.
			if($(this).children(".seatN").val() == 1){
				return;
			}
			// 좌석 체크 색 변경, 토글, 하나만 선택
			$(".goDetail").each(function(index){
				if($(this).children("span").text() == "✓"){
					$(this).toggleClass("seatColor");
					$(this).children("span").text("");
				}
				return;
			})
			
			if($(this).children("span").text() == "✓"){
				$(this).toggleClass("seatColor");
				$(this).children("span").text("");
			}else{
				$(this).toggleClass("seatColor");
				$(this).children("span").text("✓");
			}
			
			let adult_div = "<input type='radio' class='adult_children' name = 'adult' value='성인'/><span>성인</span>";    	
			let children_div = "<input type='radio' class='adult_children' name = 'children'  value='어린이'/><span>어린이</span>";
			// 선택막기
			$(document).on("click","input[type='radio'][name='adult']",function(){
					$('input[type="radio"][name="children"]').prop('checked',false);
				})
				$(document).on("click","input[type='radio'][name='children']",function(){
					$('input[type="radio"][name="adult"]').prop('checked',false);
				})
			
	            
			$(".info1_innerDiv").children(".adult_children").next().text("");
			$(".info1_innerDiv").children(".adult_children").remove();
			 
			/* $(".info1").children(".adult_children").val("");  */
			$(".info1_innerDiv").prepend(children_div);
           	$(".info1_innerDiv").prepend(adult_div);/* $(this).children(".seatN").val() */
           	
           	let choiceSeatDiv = "<p style='font-size=15px;font-weight:bold;margin-left:15px;color:gray;' class='choiceSeatDiv'>"+$(this).children(".seatN").val()+"</p>";
        	$(".info2").children(".choiceSeatDiv").remove();
           	$(".info2").append(choiceSeatDiv);
           	
		})	
		// 다시선택 (새로고침)
		$("#reloadBtn").on("click",function(){
			location.reload(true);
		})
		// 이전단계 버튼
		$("#prevBtn").click(function(){
				window.history.back();
			})
		// 다음단계 버튼
		$("#nextBtn").click(function(){
				$("#seatMap").val(JSON.stringify(seatMap.map));
				
				$("#pay_step2_Form").attr({
					"method":"post",
					"action":"/client/payPage/pay_step3"
				});
				$("#pay_step2_Form").submit();
			})
			
			});
		
	</script>

	</head>	
	
	
	<body>	
	<form id="pay_step2_Form" name = "pay_step2_Form">
		<input type="hidden" name="hall_date" id="hall_date" value="${pay_step2_list.hall_date}">
		<input type="hidden" name="th_num" id="th_num" value="${pay_step2_list.th_num}">
		<input type="hidden" name="hall_id" id="hall_id" value="${pay_step2_list.hall_id}">
	
	</form>
	<div id="main">
		<div id="header">
			<div id="logo">
			
			</div>
			<div class="step step1" style="background:#D9D9D9;">
				<span style="margin:0 0 10px 5px;"><span style="color:#595959;font-size:12px;font-weight:bold;">step1</span><br>
				<span style="font-size:16px;color:white;font-weight:bold;">관람일/회차</span></span>
			</div>
			<div class="step step2" style="background:white;">
				<span style="margin:0 0 10px 5px;"><span style="color:#00B0F0;font-size:12px;font-weight:bold;">step2</span><br>
				<span style="font-size:16px;font-weight:bold;">좌석선택<span style="color:#00B0F0;">∨</span></span></span>
			</div>
			<div class="step step3" style="background:#A6A6A6;">
				<span style="margin:0 0 10px 5px;"><span style="color:#595959;font-size:12px;font-weight:bold;">step3</span><br>
				<span style="font-size:16px;color:white;font-weight:bold;">할인/쿠폰</span></span>
			</div>
			<div class="step step4" style="background:#7F7F7F;">
				<span style="margin:0 0 10px 5px;"><span style="color:#595959;font-size:12px;font-weight:bold;">step4</span><br>
				<span style="font-size:16px;color:white;font-weight:bold;">결제방법</span></span>
			</div>
		</div>
		<div id="subMain">
			<div id="subMain_box">
				<div class="subMain_box1" style="border-right:0px;">
					<div class="subMain_box2">
						<span style="font-size:14px;color:white;margin-left:5px;">좌석도</span>
					</div>
					<div style="width:300px;height:35px;background:gray;color:white;text-align:center;padding-top:10px;border-radius:5px;font-weight:bold;font-size:20px;">STAGE</div>
					<div id="subMain_seatBox">
					<div id="seatBox_name">
						<div class="seat_rowName" style="text-align:center;border-radius:5px;margin-left:3px;">A</div>
						<div class="seat_rowName" style="text-align:center;border-radius:5px;margin-left:3px;">B</div>
						<div class="seat_rowName" style="text-align:center;border-radius:5px;margin-left:3px;">C</div>
						<div class="seat_rowName" style="text-align:center;border-radius:5px;margin-left:3px;">D</div>
						<div class="seat_rowName" style="text-align:center;border-radius:5px;margin-left:3px;">E</div>
						<div class="seat_rowName" style="text-align:center;border-radius:5px;margin-left:3px;">F</div>
					</div>
						<div class="lineBox" style="width:250px; height:200px;">
						<div class ="line lineA" style="width:250px; height:20px;"></div>
						<div class ="line lineB" style="width:250px; height:20px;"></div>
						<div class ="line lineC" style="width:250px; height:20px;"></div>
						<div class ="line lineD" style="width:250px; height:20px;"></div>
						<div class ="line lineE" style="width:250px; height:20px;"></div>
						<div class ="line lineF" style="width:250px; height:20px;"></div>
					</div>
					
					
					<!--데이터 출력 -->
					<c:choose>
						<c:when test="${not empty pay_step2_seat}">
							<c:forEach var="paypage" items="${pay_step2_seat}" varStatus="status">
							
								<c:choose>
									<c:when test="${fn:contains(pay_step2_seat[status.index].seat_name,'a') and pay_step2_seat[status.index].seat_status==0}">
										<div class="goDetail ${paypage.seat_num}" data-num="${paypage.seat_num}"
										><span></span><input type="hidden" class="seatN" value="${paypage.seat_name}"/></div>
									</c:when>
									<c:when test="${fn:contains(pay_step2_seat[status.index].seat_name,'a') and pay_step2_seat[status.index].seat_status!=0}">
										<div class="goDetail status_1 ${paypage.seat_num}" data-num="${paypage.seat_num}"
										><span></span><input type="hidden" class="seatN" value="${paypage.seat_status}"/></div>
									</c:when>
									
									<c:when test="${fn:contains(pay_step2_seat[status.index].seat_name,'b') and pay_step2_seat[status.index].seat_status==0}">
										<div class="goDetail ${paypage.seat_num}" data-num="${paypage.seat_num}"
										><span></span><input type="hidden" class="seatN" value="${paypage.seat_name}"/></div>
									</c:when>
									<c:when test="${fn:contains(pay_step2_seat[status.index].seat_name,'b') and pay_step2_seat[status.index].seat_status!=0}">
										<div class="goDetail status_1 ${paypage.seat_num}" data-num="${paypage.seat_num}"
										><span></span><input type="hidden" class="seatN" value="${paypage.seat_status}"/></div>
									</c:when>
									
									<c:when test="${fn:contains(pay_step2_seat[status.index].seat_name,'c') and pay_step2_seat[status.index].seat_status==0}">
										<div class="goDetail ${paypage.seat_num}" data-num="${paypage.seat_num}"
										><span></span><input type="hidden" class="seatN" value="${paypage.seat_name}"/></div>
									</c:when>
									<c:when test="${fn:contains(pay_step2_seat[status.index].seat_name,'c') and pay_step2_seat[status.index].seat_status!=0}">
										<div class="goDetail status_1 ${paypage.seat_num}" data-num="${paypage.seat_num}"
										><span></span><input type="hidden" class="seatN" value="${paypage.seat_status}"/></div>
									</c:when>
									
									<c:when test="${fn:contains(pay_step2_seat[status.index].seat_name,'d') and pay_step2_seat[status.index].seat_status==0}">
										<div class="goDetail ${paypage.seat_num}" data-num="${paypage.seat_num}"
										><span></span><input type="hidden" class="seatN" value="${paypage.seat_name}"/></div>
									</c:when>
									<c:when test="${fn:contains(pay_step2_seat[status.index].seat_name,'d') and pay_step2_seat[status.index].seat_status!=0}">
										<div class="goDetail status_1 ${paypage.seat_num}" data-num="${paypage.seat_num}"
										><span></span><input type="hidden" class="seatN" value="${paypage.seat_status}"/></div>
									</c:when>
									
									<c:when test="${fn:contains(pay_step2_seat[status.index].seat_name,'e') and pay_step2_seat[status.index].seat_status==0}">
										<div class="goDetail ${paypage.seat_num}" data-num="${paypage.seat_num}"
										><span></span><input type="hidden" class="seatN" value="${paypage.seat_name}"/></div>
									</c:when>
									<c:when test="${fn:contains(pay_step2_seat[status.index].seat_name,'e') and pay_step2_seat[status.index].seat_status!=0}">
										<div class="goDetail status_1 ${paypage.seat_num}" data-num="${paypage.seat_num}"
										><span></span><input type="hidden" class="seatN" value="${paypage.seat_status}"/></div>
									</c:when>
								
									<c:otherwise>
										
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="4" class="tac text-center">등록된 좌석이 존재하지 않습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
					</div>
				</div>
				<div class="subMain_box1_1">
					<div class="subMain_box2">
						<span style="font-size:14px;color:white;margin-left:5px;">티켓정보</span>
					</div>
						<div class="subMain_box3">
							<div class = "ticket_info">
					       		<div class="info_box info1" style="width:100%;height:200px;">
								  	<span style="margin-left:10px;">연령</span>
								  	<hr style="width:90%;">
								  	<div class="info1_innerDiv"></div>
								  	
							  	</div>
							  	<div class="info_box info2" style="width:100%;height:160px;">
								  	<span style="margin-left:10px;">선택한좌석</span>
								  	<hr style="width:90%;">
							  	</div>
							  	<div style="display:flex;">
								  	<button id="seatSelectBtn" style="background:gray;color:white;width:45px;height:30px;border:0px;">선택</button>
								  	<button id="reloadBtn" style="background:gray;color:white;width:75px;height:30px;border:0px;margin-left:30px;">다시 선택</button>
							  	</div>
					    	</div>
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
					<li style="color:red;">- 어린이 할인 등 증빙서류가 필요한 경우 현장수령만 가능하며, 현장에서 증빙서류 미지참 시 차액 지불하셔야 합니다.</li>
					<li style="color:red;">- 7세 이하 아동의 어린이 할인은 30% 입니다.</li>
					<li>- 할인은 자동선택 되지 않으니, 적용 받고자 하는 할인이 있는 경우 직접 선택해주시기 바랍니다.</li>
					<li>- 쿠폰은 한 번에 1개씩만 적용 가능합니다.</li>
					<li>- 예매 취소 내용.</li>
				</ul>
			</div>
		</div>
	</div>
	<div id="side">
		<div class="side_box side_box1">
			<div id="side_box1_box1">
				<img src="/resources/images/20230315-45326.jpg"  style="width:90%;height:200px;margin:5px 0 0 5px">
			</div>
			<div id="side_box1_box2">
				<table class="side_table">
					<tr><td><h4>${pay_step2_list.s_name}</h4></td></tr>
					<tr><td style="font-size:14px;">${pay_step2_list.s_opendate}~${pay_step2_list.s_closedate}</td></tr>
					<tr><td style="font-size:14px;">${pay_step2_list.th_name}</td></tr>
				</table>
			</div>
		</div>
		<div class="side_box side_box2">
				<table class="side_table1">
					<tr><td><h3 style="color:white;">선택내역</h3></td></tr>
					<tr><td>날짜</td>
						<td>${pay_step2_list.hall_date}</td>
					</tr>
					<tr><td>관</td>
						<td>${pay_step2_list.hall_place}</td>
					</tr>
					<tr><td>시간</td>
						<td>[${pay_step2_list.hall_turn}]${pay_step2_list.hall_time}</td>
					</tr>
					<tr><td>매수</td>
						<td><div class="count_div"></div>
							
						</td>
					</tr>
					<tr><td>좌석</td>
						<td><div class="seat_div" style="overflow:auto;width:50px;height:50px;"></div></td>
					</tr>
				</table>
		</div>
		<div class="side_box side_box3">
			<table class="side_table1">
					<tr><td><h3 style="color:white;">결제내역</h3></td></tr>
					<tr><td>티켓금액</td>
						<td id="totalTicketTd">0</td>
					</tr>
					<tr><td>할인(쿠폰)</td>
						<td id="discountCouponTd">0</td>
					</tr>
					<tr><td>할인(어린이)</td>
						<td id="discountChildren">0</td>
					</tr>
					<tr><td>할인금액</td>
						<td id="discountTotalTd">0</td>
					</tr>
					<tr><td>결제금액</td>
						<td id="totalAmountTd">0</td>
					</tr>
				</table>
		</div>
		<div class="side_box side_box4">
			<div id="side_box4_box1">
				<h4 style="color:white;">최종 결제금액</h4>
				<span id="totalAmount" style="color:white;">0원</span>
			</div>
			<div style="display:flex;">
			<button id ="prevBtn" style="background:#757bf6;border:0;width:90px;height:35px;color:white;
			margin:30px 0 0 35px;">이전단계</button>
			<button id ="nextBtn" style="background:#757bf6;border:0;width:90px;height:35px;color:white;
			margin:30px 0 0 25px;">다음단계</button>
			</div>
		</div>
	</div>
	</body>
</html>