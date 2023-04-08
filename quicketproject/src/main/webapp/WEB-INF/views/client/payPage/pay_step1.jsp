<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/popup.jspf" %>

<!-- 달력 부트스트랩 -->

<link type="text/css" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
<link rel="stylesheet" href="/resources/include/css/client/ticket/ticket_calender2.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

		
 
<!-- 달력 부트스트랩 끝 -->

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
			height:400px;
			
			margin: 40px 10px 0 0;
			display:flex;
		}
		.subMain_box1{
			width:50%;
			height:100%;
			/* border:2px solid #676767;
			border-radius:5px; */
		}
		.subMain_box2{
			width:100%;
			height:40px;
			background: ;
			display:flex;
			align-items:center;
		}
		.subMain_box3{
			width:100%;
			height:100%;
			display:flex;
			align-items:center;
			justify-content:center;
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
		#ticket_container  hr{
			border:1px solid lightgray;
		}
		.ticket_info{
			width:320px;
			height:370px;
			display:flex;
			align-items:flex_start;
			justify-content: center;
			flex-wrap:wrap;
		}
		.info_box{
			/* border:1px solid lightgray; */
			height:113px;
		}
		#ticketBtn{
			width:100px;
			height:25px;
			border:0;
			background-color: #EE2D00;
			color: white;
		}
		.hall_div{
			width:100px;
			height:25px;
			border:0;
			border-radius:2px;
			background-color: #EB4956;
			color: white;
			margin:2px 5px 2px 10px;
			text-align:center;
		}
	</style>
	
	<script type="text/javascript">
	$(function(){
		//hall 리스트 정보 받기
		let th_num = ${hall_list.th_num};
		returnData = listAll(th_num);
		var popup;
		function listAll(th_num){
			let returnData = null;
			let url = "/client/payPage/all/"+th_num; 
			$.ajaxSetup({
				async:false
			});
			$.getJSON(url, function(data){
				$(data).each(function(){
					/* let remaining_seatNum = this.remaining_seatNum; */ // 예시로 그냥 쓴거
					returnData = data;
				});
				return returnData;
			}).fail(function(){
				alert("공연예매 목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해 주세요.")				
			})
			return returnData;
		}
		function dayRestrict(){
			  var date = new Date();
			  var Today = new Date(date.getFullYear() + "-" + (date.getMonth()+1) + "-" + date.getDate());
			  var StartDate = new Date(returnData[0].hall_start);
			  
			  return Today > StartDate;
			}
		$.datepicker.setDefaults({
		      closeText: "닫기",
		      prevText: "이전달",
		      nextText: "다음달",
		      currentText: "오늘",
		      monthNames: ["1월", "2월", "3월", "4월", "5월", "6월",
		        "7월", "8월", "9월", "10월", "11월", "12월"
		      ],
		      monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월",
		        "7월", "8월", "9월", "10월", "11월", "12월"
		      ],
		      dayNames: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"],
		      dayNamesShort: ["일", "월", "화", "수", "목", "금", "토"],
		      dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
		      weekHeader: "주",
		      isRTL: false,
		      showMonthAfterYear: true,
		      yearSuffix: "년"
		    })
		if(dayRestrict() == true){
			// 캘린더
			$('.datepicker').datepicker({
			    format: 'dd-mm-yyyy',
			    minDate: 0,
			    maxDate: new Date(returnData[0].hall_end),
			    onSelect:function(d){
			    	
			    	var arr=d.split("/");
			    	var day1=arr[0];
			    	var day2=arr[1];
			    	var day3=arr[2];
			    	var Date = arr[2]+"-"+arr[0]+"-"+arr[1];
			    	let num = equalsValue(Date);
			    	
					if(num == -1){
						var hidden_div = "<input type='text' class='hall_div hidden_div' value='서비스 준비중' readonly>";
					}else{
						$("#hall_date").text(returnData[num].hall_date);
						var hidden_div = "<input type='hidden' class='hall_div hidden_div' value="+num+">";
				    	var hall_place_div = "<button class='hall_div hall_place_div'>"+returnData[num].hall_place+"</button>";
					}
			    	
		           	$(".info1").children(".hidden_div").remove();
		           	$(".info1").children(".hall_place_div").remove();
		           	$(".info2").children(".hall_turn_div").remove();
		           	$(".info3").children(".hall_seat_div").remove();
		           	$(".info1").append(hall_place_div);
		           	$(".info1").append(hidden_div);
			    }
			})
			
			// 캘린더 끝
			// 캘린더 클릭 시 관 시간 회차 선택
		}else{
			// 캘린더
			$('.datepicker').datepicker({
			    format: 'dd-mm-yyyy',
			    minDate: new Date(returnData[0].hall_start),
			    maxDate: new Date(returnData[0].hall_end),
			    onSelect:function(d){
			    	
			    	var arr=d.split("/");
			    	var day1=arr[0];
			    	var day2=arr[1];
			    	var day3=arr[2];
			    	var Date = arr[2]+"-"+arr[0]+"-"+arr[1];
			    	let num = equalsValue(Date);
					if(num == -1){
						var hidden_div = "<input type='text' class='hall_div hidden_div' value='서비스 준비중' readonly>";
					}else{
						$("#hall_date").text(returnData[num].hall_date);
						var hidden_div = "<input type='hidden' class='hall_div hidden_div' value="+num+">";
				    	var hall_place_div = "<button class='hall_div hall_place_div'>"+returnData[num].hall_place+"</button>";
					}
			    	
		           	$(".info1").children(".hidden_div").remove();
		           	$(".info1").children(".hall_place_div").remove();
		           	$(".info2").children(".hall_turn_div").remove();
		           	$(".info3").children(".hall_seat_div").remove();
		           	$(".info1").append(hall_place_div);
		           	$(".info1").append(hidden_div);
			    }
			})
			// 캘린더 끝
			// 캘린더 클릭 시 관 시간 회차 선택
		}
		
		function equalsValue(Date){
			let num = -1;
			for(let i = 0; i < returnData.length; i++){
				if(returnData[i].hall_date == Date){
					let num = i;
					return num;
				}
			}
			return num;
		}
		$(document).on("click",".hall_place_div",function(){
			let num = $(".hidden_div").val();
			var hall_turn_div = "<button class='hall_div hall_turn_div'>"+ "["+returnData[num].hall_turn+"]"+returnData[num].hall_time +"</button>";    	
			$(".info2").children(".hall_turn_div").remove();
           	$(".info2").append(hall_turn_div);
           	$("#hall_place").text(returnData[num].hall_place);
		})
		
		$(document).on("click",".hall_turn_div",function(){
			let num = $(".hidden_div").val();
			var hall_seat_div = "<button class='hall_div hall_seat_div'>"+returnData[num].remaining_seatNum+"석</button>";
           	$(".info3").children(".hall_seat_div").remove();
           	$(".info3").append(hall_seat_div);
           	$("#hall_time").text("["+returnData[num].hall_turn+"]"+returnData[num].hall_time);
		})
		// 캘린더 클릭 시 관 시간 회차 선택 끝
		$("#nextBtn").click(function(){
			let num = $(".hidden_div").val();
			if($(".hall_turn_div").length != 0){
				location.href="/client/payPage/pay_step2?hall_date="+returnData[num].hall_date+
						"&th_num="+${hall_list.th_num}+"&hall_id="+returnData[num].hall_id+"&s_num="+"${detailData.s_num}";
			}else{
				alert("관람일/관/회차를 선택해주세요.");
			}
				
			});
		
		});
	</script>

	</head>	
	
	
	<body>	
	<div id="main">
		<div id="header">
			<img src="/resources/image/001.png" alt="QUICKet로고" width="120" height="45" style="position:relative;bottom:10px;right:18px;"/>
			<div class="step step1" style="background:white;border:3px solid #666666"><!-- #666666 -->
				<span style="margin:0 0 10px 5px;"><span style="color:#3A85C7;font-size:12px;font-weight:bold;">step1</span><br>
				<span style="font-size:16px;font-weight:bold;">관람일/회차<span style="color:#00B0F0;">∨</span></span></span>
			</div>
			<div class="step step2" style="background:#676767;">
				<span style="margin:0 0 10px 5px;"><span style="color:#B3B3B3;font-size:12px;font-weight:bold;">step2</span><br>
				<span style="font-size:16px;color:white;font-weight:bold;">좌석선택</span></span>
			</div>
			<div class="step step3" style="background:#5C5C5C">
				<span style="margin:0 0 10px 5px;"><span style="color:#B3B3B3;font-size:12px;font-weight:bold;">step3</span><br>
				<span style="font-size:16px;color:white;font-weight:bold;">할인/쿠폰</span></span>
			</div>
			<div class="step step4" style="background:#535354;">
				<span style="margin:0 0 10px 5px;"><span style="color:#B3B3B3;font-size:12px;font-weight:bold;">step4</span><br>
				<span style="font-size:16px;color:white;font-weight:bold;">결제방법</span></span>
			</div>
		</div>
		<div id="subMain">
			<div id="subMain_box">
				<div class="subMain_box1" style="margin-right:10px;">
					<div class="subMain_box2">
						<span style="font-size:13px;color:white; width:90px;height:25px;text-align:center;line-height: 30px;vertical-align: middle;;margin:10px 0 0 10px;border-radius:12px 0 0 12px;background:#f9e000;">관람일 선택</span>
					</div>
					<div class="subMain_box3">
						<div class = "datepicker" style="margin-bottom:40px;">
       					</div>
					</div>
					
				</div>
				<div class="subMain_box1">
					<div class="subMain_box2">
						<span style="font-size:13px;color:white; width:90px;height:25px;text-align:center;line-height: 30px;vertical-align: middle;;margin:10px 0 0 10px;border-radius:12px 0 0 12px;background:#f9e000;">회차 선택</span>
					</div>
					<div class="subMain_box3">
						<div class = "ticket_info">
				       		<div class="info_box info1" style="width:100%;height:80px;">
							  	<span style="margin-left:10px;font-size:14px;font-weight:bold;">관</span>
							  	<hr style="width:90%;border:1px solid #4A4A4A;">
						  	</div>
						  	<div class="info_box info2" style="width:100%;height:80px;">
							  	<span style="margin-left:10px;font-size:14px;font-weight:bold;">회차</span>
							  	<hr style="width:90%;border:1px solid #4A4A4A;">
						  	</div>
						  	<div class="info_box info3" style="width:100%;">
							  	<span style="margin-left:10px;font-size:14x;font-weight:bold;">예매 가능 좌석</span>
							  	<hr style="width:90%;border:1px solid #4A4A4A;">
						  	</div>
				    	</div>
					</div>
				</div>
			</div>
		</div>
		<div id="footer">
			<div id="footer_box1">
				<span style="writing-mode:vertical-rl; color:white; margin:60px 0 0 8px; font-size:15px;">
				유 의 사 항
				</span>
			</div>
			<div id="footer_box2" style="padding:10px;">
				<ul>
					<li style="color:red;">- 안내되어 있는 잔여석은 결제 진행 중인 좌석을 포함하고 있어 예매 가능 좌석과 다를 수 있습니다.</li>
					<li>- 어린이 할인 등 증빙서류가 필요한 경우 현장수령만 가능하며, 현장에서 증빙서류 미지참 시 차액 지불하셔야 합니다.</li>
					<li>- 7세 이하 아동의 어린이 할인은 30% 입니다.</li>
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
					<tr><td><h4>${hall_list.s_name}</h4></td></tr>
					<tr><td style="font-size:14px;">${hall_list.s_opendate}~${hall_list.s_closedate}</td></tr>
					<tr><td style="font-size:14px;">${hall_list.th_name}</td></tr>
				</table>
			</div>
		</div>
		<div class="side_box side_box2">
				<table class="side_table1">
					<tr><td><h3 style="color:white;font-size:17px;">선택내역</h3></td></tr>
					<tr><td>날짜</td>
						<td id="hall_date"></td>
					</tr>
					<tr><td>관</td>
						<td id="hall_place"></td>
					</tr>
					<tr><td>시간</td>
						<td id="hall_time"></td>
					</tr>
					<tr><td>매수</td>
						<td></td>
					</tr>
					<tr><td>좌석</td>
						<td></td>
					</tr>
				</table>
		</div>
		<div class="side_box side_box3">
			<table class="side_table1">
					<tr><td><h3 style="color:white;font-size:17px;">결제내역</h3></td></tr>
					<tr><td>티켓금액</td>
						<td>0</td>
					</tr>
					<tr><td>할인쿠폰</td>
						<td>0</td>
					</tr>
					<tr><td>할인금액</td>
						<td>0</td>
					</tr>
				</table>
		</div>
		<div class="side_box side_box4">
			<div id="side_box4_box1">
				<h4 style="color:white;font-size:15px;">최종 결제금액</h4>
				<span style="color:white;">0원</span>
			</div>
			
			<button id="nextBtn"style="background:#7F9CB7;border:0;width:160px;height:30px;color:white;
			margin:10px 0 0 55px;">다음단계</button>
		</div>
	</div>
	</body>
</html>