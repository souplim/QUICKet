<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    
    <script>
	    
	    $(function(){
	       /*   var IMP = window.IMP; 
	        IMP.init("imp57026378"); 
	    	
	        $("#requestBtn").click(function(){
	        	requestPay();
			}); */
	        $("#cancelBtn").click(function(){
	        	cancelPay();
			});
	        
	       /*  function requestPay() {
	            IMP.request_pay({
	                pg : 'html5_inicis',
	                pay_method : 'card',
	                merchant_uid: "merchant_" + new Data().getTime(), 
	                name : '당근 10kg',
	                amount : 100,
	                buyer_email : 'Iamport@chai.finance',
	                buyer_name : '포트원 기술지원팀',
	                buyer_tel : '010-1234-5678',
	                buyer_addr : '서울특별시 강남구 삼성동',
	                buyer_postcode : '123-456'
	            }, function (rsp) { // callback
	                if (rsp.success) {
	                    console.log(rsp.imp_uid);
	                    $.ajax({
	                    	type:"post",
	                    	url:"/admin/ticket/cash",
	                    	data:{
	                    		'imp_id':rsp.imp_uid
	                    	}
	                    }
	                } else {
	                    console.log(rsp);
	                }
	            });
	        }  */
	    
        /* 결제취소 */
        /* function cancelPay() {
            jQuery.ajax({
              // 예: http://www.myservice.com/payments/cancel
              "url": "https://api.iamport.kr/users/getToken"
              "type": "POST",
              "contentType": "application/json",
              "data": JSON.stringify({
					"imp_key":"0431672717846216",
					"imp_secret":"UJSeqJng4HP82G0pVr2sLQoDrghqOCKMHuopkIpppwLq9zcr6hCKUbg00kUbo0zroTnqRMPYdIVdUXt1"
              }),
              "dataType": "json",
			    success : function(result){
			    	console.log(result);
			    }
            });
          } */
     // 주문번호 만들기
       /*  function createOrderNum(){
        	const date = new Date();
        	const year = date.getFullYear();
        	const month = String(date.getMonth() + 1).padStart(2, "0");
        	const day = String(date.getDate()).padStart(2, "0");
        	
        	let orderNum = year + month + day;
        	for(let i=0;i<10;i++) {
        		orderNum += Math.floor(Math.random() * 8);	
        	}
        	return orderNum;
        } */
		var IMP = window.IMP; 
        IMP.init("imp57026378"); 
        $("#requestBtn").click(function(){
        	console.log("결제요청");
        	requestPay();
        	function requestPay() {
                

                IMP.request_pay({ // param
                	pg : 'html5_inicis',
                    pay_method : 'card',
                    merchant_uid: "ABCD1234",
                    amount: "100",
                    name: "길동홍"
/*                     m_redirect_url: "/order/payment-result"
 */
                }, function (rsp) { // callback
                    if (rsp.success) {

                        jQuery.ajax({
                            url: "/api/v1/payment/complete", // 예: https://www.myservice.com/payments/complete
                            method: "POST",
                            headers: { "Content-Type": "application/json" },
                            data: {
                                imp_uid: rsp.imp_uid,
                                merchant_uid: rsp.merchant_uid
                            }
                        }).done(function (data) {
                        	alert("성공");
                        	console.log(data);
                        	var obj = JSON.parse(data);
                        	console.log(obj);
                        	console.log(obj.token);
                        	
                        })
                    } else {
                        alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
                    }
                });
            }
        });
        // 계산 완료
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