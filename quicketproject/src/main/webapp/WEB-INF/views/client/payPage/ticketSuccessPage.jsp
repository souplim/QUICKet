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
		body{
			width:980px;
			height:915px;
			display:flex;
			flex-wrap:nowrap;
			justify-content:center;
			/* background: rgba(0, 0, 0, 0.50); */
			background:white;
		}
		/* side-------------------------------------------------------- */
		#side{
			margin-top:50px;
			width:400px;
			height:89%;/* 915px */
			background:white;
			border-radius:15px;
			border:5px solid gray;
			padding:5px;
		}
		.side_box{
			width:100%;
			display:flex;
			align-items:flex-start;
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
			margin-bottom:10px;
		}
		.side_table  tr td{
			padding-top:10px;
			color:black;
		}
		.side_box2{
			height:30%;
		}
		.side_table1{
		}
		.side_table1  tr td{
			padding-bottom:20px;
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
			background:white;
			margin:20px 0 0 30px;
			display:flex;
			align-items:center;
			justify-content: space-around;
		}
		/* -------------------------------------------------------- */
		
	</style>
	
	<script type="text/javascript">
	</script>

	</head>	
	
	
	<body>	
	<div id="side">
		<div class="side_box side_box1">
			<div id="side_box1_box1">
				<img src="/resources/images/20230315-45326.jpg"  style="width:90%;height:200px;margin:5px 0 0 5px">
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
					<tr><td>공연관</td>
						<td class="valTd">${ticketSuccessPage.hall_place}</td>
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