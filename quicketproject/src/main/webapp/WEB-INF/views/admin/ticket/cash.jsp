<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <script>
	    $(function(){
	        var IMP = window.IMP; 
	        IMP.init("imp57026378"); 
	    	
	        $("#requestBtn").click(function(){
	        	requestPay();
			});
	        $("#cancelBtn").click(function(){
	        	cancelPay();
			});
	        
	        function requestPay() {
	            IMP.request_pay({
	                pg : 'html5_inicis',
	                pay_method : 'card',
	                merchant_uid: "57008833-33003", 
	                name : '당근 10kg',
	                amount : 100,
	                buyer_email : 'Iamport@chai.finance',
	                buyer_name : '포트원 기술지원팀',
	                buyer_tel : '010-1234-5678',
	                buyer_addr : '서울특별시 강남구 삼성동',
	                buyer_postcode : '123-456'
	            }, function (rsp) { // callback
	                if (rsp.success) {
	                    console.log(rsp);
	                } else {
	                    console.log(rsp);
	                }
	            });
	        }
	    
        /* 결제취소 */
        function cancelPay() {
            jQuery.ajax({
              // 예: http://www.myservice.com/payments/cancel
              "url": "{환불정보를 수신할 가맹점 서비스 URL}", 
              "type": "POST",
              "contentType": "application/json",
              "data": JSON.stringify({
                "merchant_uid": "57008833-33004", // 예: ORD20180131-0000011
                "cancel_request_amount": 100, // 환불금액
                "reason": "테스트 결제 환불", // 환불사유
                // [가상계좌 환불시 필수입력] 환불 수령계좌 예금주
                "refund_holder": "홍길동", 
                // [가상계좌 환불시 필수입력] 환불 수령계좌 은행코드(예: KG이니시스의 경우 신한은행은 88번)
                "refund_bank": "04" ,
                // [가상계좌 환불시 필수입력] 환불 수령계좌 번호
                "refund_account": "94740200016308" 
              }),
              "dataType": "json"
            });
          }
	    })
    </script>
    <meta charset="UTF-8">
    <title>Sample Payment</title>
</head>
<body>
    <button id = "requestBtn" >결제하기</button> <!-- 결제하기 버튼 생성 -->
    <button id = "cancelBtn">환불하기</button>
</body>
</html>