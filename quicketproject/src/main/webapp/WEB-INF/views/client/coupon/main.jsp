<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<title>쿠폰</title>

<script>

	$(function(){
		
		let errorMsg = "${errorMsg}";
		if(errorMsg!="") {
			alert(errorMsg);
			errorMsg = "";
		}
		
		
		$(".couponBtn").click(function(){
			let num = $(this).parent("div").attr("data-num");

			// 이미 갖고있는 쿠폰인지 확인
			if($("#u_id").val() == "") {
				alert("로그인이 필요합니다.");
			} else {
				$.ajax({
					type:"POST",
					url:"/user/coupon/couponChk",
					data:{
						"c_num" : num, "u_id" : $("#u_id").val()
					},
					success:function(data){
						console.log(data);
						if(data == 1) {
							alert("이미 발급받은 쿠폰입니다.\n쿠폰은 한 번만 발급 받을 수 있습니다.");
						} else {

							$("#c_num").val(num);
							$("#couponForm").attr({
								"method" : "post",
								"action" : "/user/coupon/getCoupon"
							});
							$("#couponForm").submit();
						}
					}
				});	
			}
			
		});
	});
</script>

<style>
	img {width : 100%;}
	.caption{height:110px;}
	
</style>
</head>
<body>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />

<div class="container">


<div class="row">
	<form name="couponForm"id="couponForm">
		<input type="hidden" name="c_num" id="c_num"/>
		<input type="hidden" name="u_id" id="u_id" value="${userLogin.u_id}"/>
	</form>
	<br>
	<h3 class=""><b>쿠폰</b></h3>
	<br>
<c:choose>
	<c:when test="${not empty couponList}" >
		<c:forEach var="coupon" items="${couponList}" varStatus="status">
				<div class="col-md-4 coupon">
				    <div class="thumbnail">
				        <img src="/uploadStorage/coupon/${coupon.c_img}"/>
				        <div class="caption">
				          <p><span>[${coupon.c_discount}%]</span>&nbsp;${coupon.c_name}</p>
				          <p><small>발급기간 : <span>${coupon.c_startissue}</span>~<span>${coupon.c_endissue }</span></small><br>
						  <small>유효기간 : <span>${coupon.c_startdate}</span>~<span>${coupon.c_enddate }</span></small></p>
				        </div>
				        <div class="btnArea" data-num="${coupon.c_num}">
				        	<button type="button" class="w-btn-outline w-btn-indigo-outline btn-block btn couponBtn" 
				        	<c:if test="${coupon.c_startissue > today || coupon.c_endissue < today}">
				        		disabled="disabled" style="background-color: lightgray; cursor: no-drop;"
				        	</c:if>
				        	>발급 받기</button>
				        </div>
				    </div>
				 </div>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<span>등록된 쿠폰이 없습니다.</span>
	</c:otherwise>
</c:choose>




</div>

</div>

</body>
</html>