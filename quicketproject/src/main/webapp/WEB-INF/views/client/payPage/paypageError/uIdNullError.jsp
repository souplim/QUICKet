<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/ticket_common.jspf" %>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix= "fn" uri= "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix= "fmt" uri= "http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

	
	<script type="text/javascript">
	$(function(){
		swal('로그인 후 이용해주세요', "확인 버튼 클릭 시 창이 닫힙니다.", 'warning')
		.then(function(){
			window.close();                  
		})
	})
	</script>
	</head>	
	
	
	<body style="background:#303742;display:flex;align-items:center;justify-content:center;">
		<img src="/resources/image/ticket/loginError.png" style="width:600px;height:250px;margin:200px 0 0 0;">
	</body>
</html>