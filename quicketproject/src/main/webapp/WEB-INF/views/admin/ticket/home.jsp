<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<script type="text/javascript">
		$(function(){
			
			/* 관리자 예매등록 페이지 */
			$("#admin_ticketWrite").click(function(){
				location.href="/admin/ticket/ticketWrite";
			});
			/* 결제 테스트 페이지 */
			$("#cash").click(function(){
				location.href="/admin/ticket/cash";
			});
			/* 공연상세페이지 */
			$("#showDetail").click(function(){
				location.href="/client/ticket/showDetail";
			});
			/* 관리자공연등록리스트 */
			$("#hall_list_admin").click(function(){
				location.href="/admin/ticket/hall_list";
			});
		});
	</script>
</head>
<body>
	<div class="contentContainer container">
		<div class="contentTB text-center">
			<div class="text-left">
				<input type="button" value="관리자 예매등록 페이지" id="admin_ticketWrite" class="btn btn-success" />
				<input type="button" value="결제 테스트 페이지" id="cash" class="btn btn-success" />
				<input type="button" value="공연상세페이지" id="showDetail" class="btn btn-success" />
				<input type="button" value="관리자공연등록리스트" id="hall_list_admin" class="btn btn-success" />
			</div>
		</div>
</div>
</body>
</html>
