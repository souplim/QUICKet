<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
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
			border: 1px solid gray;
			justify-content:center;
		}
		/* side-------------------------------------------------------- */
		#side{
			width:400px;
			height:100%;/* 915px */
			background:#4A4A4A;
		}
		.side_box{
			width:100%;
			border-top:1px solid #262626;
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
			padding-bottom:30px;
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
	}
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
					<tr><td><h3 style="color:white;">예약내역</h3></td></tr>
					<tr><td>예매번호</td>
						<td>${ticketSuccessPage.pay_num}</td>
					</tr>
					<tr><td>공연관</td>
						<td>${ticketSuccessPage.hall_place}</td>
					</tr>
					<tr><td>공연날짜</td>
						<td>${ticketSuccessPage.hall_date}</td>
					</tr>
					<tr><td>공연회차</td>
						<td>${ticketSuccessPage.hall_turn}</td>
					</tr>
					<tr><td>공연시간</td>
						<td>${ticketSuccessPage.hall_time}</td>
					</tr>
					<tr><td>이름</td>
						<td>${ticketSuccessPage.pay_name}</td>
					</tr>
					<tr><td>공연가격</td>
						<td>${ticketSuccessPage.s_price}</td>
					</tr>
					<tr><td>예약날짜</td>
						<td>${ticketSuccessPage.ti_date}</td>
					</tr>
				</table>
		</div>
		
	</div>
	</body>
</html>