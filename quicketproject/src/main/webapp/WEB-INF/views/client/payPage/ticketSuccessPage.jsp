<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/ticket_common.jspf" %>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix= "fn" uri= "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix= "fmt" uri= "http://java.sun.com/jsp/jstl/fmt" %>

<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    
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
			width:100%;
			height:100%;
			display:flex;
			justify-content:center;
			align-items:center;
			background:#F1F3F4;
		}
		#side{
			width:400px;
			height:820px;
			background:#E8ECEE;
			margin-top:50px;
		}
		.side_box{
			width:100%;
			display:flex;
			align-items:flex-start;
		}
		.side_box1{
			margin-top:10px;
			height:28%;
			width:95%;
			display:flex;
		}
		#side_box1_box1{
			margin-left:20px;
			margin-top:10px;
			width:55%;
			height:100%;
			background:white;
		}
		#side_box1_box2{
			width:50%;
			height:100%;
			display:flex;
			justify-content:flex-start;
			align-items:flex-start;
			background:white;
			margin-top:10px;
		}
		.side_table  tr td{
			padding-top:10px;
			color:white;
			margin-bottom:10px;
		}
		.side_table  tr td{
			padding-top:10px;
			color:black;
		}
		.side_box2{
			margin:30px 0 0 20px;;
			height:470px;
			padding:10px;
			width:90%;
			background:white;
		}
		.side_table1{
			margin:0px 0 0 0px;
		}
		.side_table1  tr td{
			color:white;
			font-size:13px;
		}
		.side_table1  tr td:nth-child(1){
			color:#7F7F7F;
		}
		.side_table1  tr td{
			padding-bottom:12px;
			color:#404040;
		}
		.side_table1  tr td:nth-child(1){
			font-size:18px;
			font-weight:bold;
		}
		.side_table1  tr td:nth-child(2){
			text-align:right;
			width:300px;
			font-size:15px;
		}
		.side_table1  tr td:nth-child(1){
			color:#404040;
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
			background:white;
			margin:20px 0 0 30px;
			display:flex;
			align-items:center;
			justify-content: space-around;
		}
		/* -------------------------------------------------------- */
		
	</style>
	
	<script type="text/javascript">
	$(function(){
		let seatArr = new Array();
		let b = 1;
		for(let i = 0 ; i < 50; i++){
			if(i>=0 && i<=7){
				seatArr.push("a"+"-"+b);
				if(i==7){
					b = 0;
				}
			}else if(i>=8 && i<=15){
				seatArr.push("b"+"-"+b);
				if(i==15){
					b = 0;
				}
			}else if(i>=16 && i<=25){
				seatArr.push("c"+"-"+b);
				if(i==25){
					b = 0;
				}
			}else if(i>=26 && i<=35){
				seatArr.push("d"+"-"+b);
				if(i==35){
					b = 0;
				}
			}else if(i>=36 && i<=45){
				seatArr.push("e"+"-"+b);
				if(i==45){
					b = 0;
				}
			}else if(i>=46 && i<=50){
				seatArr.push("f"+"-"+b);
			}
			
			b++;
		}
		let seatValueString = "${ticketSuccessPage.seat_num}";
		let seatValue = seatValueString.split(',');
		let resultSeatVal = "";
		
		for(let i = 0 ; i < seatValue.length; i++){
			resultSeatVal += seatArr[Number(seatValue[i])+1]
			if(i!=seatValue.length-1){
				resultSeatVal += ", "
			}
		}
		$(".seatVal").text(resultSeatVal+" 석");
		
	})
	</script>

	</head>	
	
	
	<body>	
	<div id="side">
		<div style="background:white;height:60px;width:100%;">
		<img src="/resources/image/001.png" alt="QUICKet로고" width="90" height="35" style="position:relative;left:8px;top:13px;"/>
		<span style="position:relative;top:17px;left:65px;font-size:18px;font-weight:bold;">결제 완료</span>
		</div>
		<div class="side_box side_box1">
			<div id="side_box1_box1">
				<img src=
						<c:if test="${detailData.s_posterimg ne null}">
							"/uploadStorage${detailData.s_posterimg.img_dir}/${detailData.s_posterimg.img_name}.${detailData.s_posterimg.img_type}"
						</c:if>
						<c:if test="${detailData.s_posterimg eq null}">
							"/uploadStorage/show/poster_default.jpg"
						</c:if>
						style="width:80%;height:85%;margin:10px 0 0 10px"/>
			</div>
			<div id="side_box1_box2">
				<table class="side_table">
					<tr><td><h4>${ticketSuccessPage.s_name}</h4></td></tr>
					<tr><td style="font-size:14px;">${ticketSuccessPage.s_opendate}~${ticketSuccessPage.s_closedate}</td></tr>
					<tr><td style="font-size:14px;">${ticketSuccessPage.th_name}</td></tr>
				</table>
			</div>
		</div>
		<div class="side_box side_box2">
				<table class="side_table1">
					<tr><td><h3 style="color:black;font-weight:bold;width:200px;">예약내역</h3></td></tr>
					<tr><td>예매번호</td>
						<td class="valTd" style="color:purple;">${ticketSuccessPage.pay_num}</td>
					</tr>
					<tr><td>공연날짜</td>
						<td class="valTd">${ticketSuccessPage.hall_date}</td>
					</tr>
					<tr><td>공연회차</td>
						<td class="valTd">${ticketSuccessPage.hall_turn}</td>
					</tr>
					<tr><td>공연시간</td>
						<td class="valTd">${ticketSuccessPage.hall_time}</td>
					</tr>
					<tr><td>좌석</td>
						<td class="valTd seatVal"></td>
					</tr>
					<tr><td>이름</td>
						<td class="valTd">${ticketSuccessPage.pay_name}</td>
					</tr>
					<tr><td>공연가격</td>
						<td class="valTd">${ticketSuccessPage.s_price}원</td>
					</tr>
					<tr><td>예약날짜</td>
						<td class="valTd">${ticketSuccessPage.ti_date}</td>
					</tr>
					<tr><td>예약상태</td>
						<td class="valTd" style="color:purple;">예약완료</td>
					</tr>
					<tr><td>결제상태</td>
						<td class="valTd" style="color:purple;">결제완료</td>
					</tr>
					
				</table>
		</div>
		
	</div>
	</body>
</html>