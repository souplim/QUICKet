<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/WEB-INF/views/common/common.jspf" %>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix= "fn" uri= "http://java.sun.com/jsp/jstl/functions" %>
	<script type="text/javascript">
	$(function(){
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
			    		alert("실패");
			    	}
			    	else{/* 성공 */
			    		alert("환불성공")
			    		
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
		
		//결제상태변경
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
					location.href="/admin/ticket/payCancelPage";
				});
			}).fail(function(){
				alert("결제 취소를 실패했습니다. 관리자에게 문의해주세요.")				
			})
		}
		/* 제목 클릭시 상세 페이지 이동을 위한 처리 이벤트 */		
		$(".goDetail").click(function(){
			let pay_num = $(this).parents("tr").attr("data-num");
			payToken(pay_num);
			/* requestCancel(pay_num); */
		})
	}); // $ 함수 종료문
	
	/* 검색을 위한 실질적인 처리 함수 */
</script>
</head>
<body>
<div class="contentContainer container">
<div class="contentTit page-header"><h3 class="text-center">결제 취소 페이지</h3></div>
	<div id="payList" class="table-height"> 
	<table summary="게시판 리스트" class="table table-striped">
		<thead>
			<tr>
				<th class="text-left col-md-3">예매번호</th>
				<th class="text-left col-md-2">공연명</th>
				<th class="text-left col-md-2">아이디</th>
				<th class="text-left col-md-3">예매날짜</th>
				<th class="text-left col-md-1">결제상태</th>
				<th class="text-left col-md-1"></th>
			</tr>
		</thead>
		<tbody id="list" class="table-striped">
			<!--데이터 출력 -->
			<c:choose>
				<c:when test="${not empty payList}">
					<c:forEach var="pay" items="${payList}" varStatus="status">
						<tr class="text-center" data-num="${pay.pay_num}">
							<td class="text-left">${pay.pay_num}</td>
							<td class="text-left">${pay.s_name}</td>
							<td class="text-left">${pay.u_id}</td>
							<td class="text-left">${pay.ti_date}</td>
							<td class="text-left">${pay.pay_status}</td>
							<td class="goDetail"><button>결제취소</button></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="4" class="tac text-center">등록된 게시글이 존재하지 않습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		
		</tbody>
	</table>
	
</div> 
</div>

		
		
</body>

