<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/ticket_common.jspf" %>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix= "fn" uri= "http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix= "fmt" uri= "http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

	
	<script type="text/javascript">
	$(function(){
		swal('하위에 좌석테이블을 삭제한 후 이용해주세요', "확인 버튼 클릭 시 원래 창으로 돌아갑니다.", 'warning')
		.then(function(){
			location.href="/admin/ticket/seat_updateForm?hall_id="+"${svo.hall_id}"      
		})
	})
	</script>
	</head>	
	
	
	<body style="background:#303742;display:flex;align-items:center;justify-content:center;">
	</body>
</html>