<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
        <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
     <script>
	    
	    $(function(){
	    	
	    	var IMP = window.IMP; 
        IMP.init("imp57026378"); 
        $("#requestBtn").click(function(){
        	console.log("결제요청");
        	requestPay();
        	function requestPay() {
                
/*	ABCD1234
	ABCD1235 (위 두개는 취소됐을듯)
	ABCD1236 token: 56f57932a5828feeac1495ad5c7c573477373e72 
	{access_token=56f57932a5828feeac1495ad5c7c573477373e72, now=1.680705666E9, expired_at=1.680706302E9}
	imp_uid=imp_605643400552&merchant_uid=ABCD1236
	ABCD1237 token: 56f57932a5828feeac1495ad5c7c573477373e72
	imp_uid=imp_097768504325&merchant_uid=ABCD1237
	ABCD1238
	imp_uid : imp_uid=imp_149690787513&merchant_uid=ABCD1238
	{access_token=c1fef648085f974cc7c0ff608a95ed1687b1080c, now=1.680707723E9, expired_at=1.680709523E9}
	token : c1fef648085f974cc7c0ff608a95ed1687b1080c
	
*/
                IMP.request_pay({ // param
                	pg : 'html5_inicis',
                    pay_method : 'card',
                    merchant_uid: "ABCD1240",
                    amount: "100",
                    name: "길동"
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
                        	
                        })
                    } else {
                        alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
                    }
                });
            }
        });
        
        $("#cancelBtn").click(function(){
        	console.log("취소요청");
        	requestCancel();
        	function requestCancel() {
				let value= JSON.stringify({
					token : "c1fef648085f974cc7c0ff608a95ed1687b1080c",
					imp_uid : "imp_149690787513",
					amount : "100",
					reason : "그냥그냥.."
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
				    		alert("성공")
				    		console.log(result);
				    	}
				    }
				})
            }
        });
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