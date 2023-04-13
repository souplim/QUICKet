<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<!-- 달력 부트스트랩 -->
<link rel="stylesheet" href="/resources/include/css/client/ticket/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link type="text/css" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
<link rel="stylesheet" href="/resources/include/css/client/ticket/ticket_calender2.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<!-- 달력 부트스트랩 끝 -->
	<style>
	#body{
		display:flex;
		width:100%;
		height:400px;
		justify-content:center;
		align-items:center;
	}
	#ticket_container{
		width:700px;
		height:400px;
		/* border:1px solid lightgray; */
		display: flex;
		align-items:center;
		justify-content: space-around;
		flex-wrap:wrap;
	}
	#ticket_container  hr{
		border:1px solid lightgray;
	}
	.ticket_info{
		width:320px;
		height:340px;
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
		font-size:15px;
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
	/* 배경 어둡게 */
	.shadow{position: fixed;left: 0;top: 0;background: rgba(0, 0, 0, 0.52);width: 100%;height: 100vh;display: none}
	/* 팝업 기본디자인 */
	.popup{border: 1px solid #dcdcdc;position: fixed;width: 500px;left: 50%;top: 50%;transform: translate(-50%,-50%);padding: 10px;display: none;background: #fff}
	.popup .close{background: none;border: 0;position: absolute;right: 10px;top: 10px;font-size: 20px;}
			
	</style>
	
	<script type="text/javascript">
	$(function(){
		//hall 리스트 정보 받기
		let th_num = ${hall_list.th_num};
		returnData = listAll(th_num);
		var popup;
		function listAll(th_num){
			let returnData = null;
			let url = "/client/ticket/all/"+th_num; 
			$.ajaxSetup({
				async:false
			});
			$.getJSON(url, function(data){
				$(data).each(function(){
					returnData = data;
				});
				return returnData;
			}).fail(function(){
				alert("공연 목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해 주세요.")				
			})
			return returnData;
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
		function dayRestrict(){
			  var date = new Date();
			  var Today = new Date(date.getFullYear() + "-" + (date.getMonth()+1) + "-" + date.getDate());
			  var StartDate = new Date(returnData[0].hall_start);
			  
			  return Today > StartDate;
			}
		
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
			var hall_turn_div = "<button class='hall_div hall_turn_div'>"+ returnData[num].hall_turn +"</button>";
           	$(".info2").children(".hall_turn_div").remove();
           	$(".info2").append(hall_turn_div);
		})
		
		$(document).on("click",".hall_turn_div",function(){
			let num = $(".hidden_div").val();
			var hall_seat_div = "<button class='hall_div hall_seat_div'>"+returnData[num].remaining_seatNum+"석</button>";
           	$(".info3").children(".hall_seat_div").remove();
           	$(".info3").append(hall_seat_div);
		})
		// 캘린더 클릭 시 관 시간 회차 선택 끝
		$("#ticketBtn").click(function(){
			if($(".hall_turn_div").length != 0){
				openPopup();
			}else{
				swal('',"관람일/관/회차를 선택해주세요.",'warning');
			}
				
			});
		function openPopup() {
			href='/client/payPage/pay_step1?th_num='+${hall_list.th_num};
			w=1150;
			h=855;
			var xPos = (window.outerWidth/2) - (w/2); // 가운데 정렬
			xPos += window.screenLeft; // 듀얼 모니터일 때
			var yPos = (window.outerHeight/2) - (h/2);
			var popup = window.open(href, "pop_name", "width="+w+", height="+h+", left="+xPos+", top="+yPos+", menubar=yes, status=yes, titlebar=yes, resizable=yes");
			// 새로고침과 닫기를 구분하지 못함.
			/* popup.onload = function () {
				 popup.onunload = function () {
			        if(!popup.closed){    // 닫기한 경우 - 윈도우창 닫기, self.close() 
			        	$(".shadow").hide(); // 배경 어둡게 
			        }
			    };
			}; */
			
			}
		});
	</script>

	</head>	
	
	
	<body>	
	<div id="body">
	  <div id="ticket_container">
	  
	  	<div class = "ticket_info">
		  	<div style="width:100%;height:5%;">
			  	<span style="margin-left:10px;">관람일</span>
			  	<hr style="width:90%;">
		  	</div>
	       	<div class = "datepicker">
       		</div>
        		
    	</div>
    	
       	<div class = "ticket_info">
       		<div class="info_box info1" style="width:100%;">
			  	<span style="margin-left:10px;">관</span>
			  	<hr style="width:90%;">
		  	</div>
		  	<div class="info_box info2" style="width:100%;">
			  	<span style="margin-left:10px;">회차</span>
			  	<hr style="width:90%;">
		  	</div>
		  	<div class="info_box info3" style="width:100%;">
			  	<span style="margin-left:10px;">예매 가능 좌석</span>
			  	<hr style="width:90%;">
		  	</div>
    	</div>
    	<button id = "ticketBtn">예매하기</button>
      </div> 
      <!-- 배경 어둡게 -->
      <div class="shadow"></div>
      </div>
	</body>
</html>