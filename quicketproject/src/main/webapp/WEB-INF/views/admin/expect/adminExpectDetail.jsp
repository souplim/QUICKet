<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

	<style type="text/css">
	tr.table-tr-height { height: 200px;}
	div.container{width: 700px;}
	</style>
	<script type="text/javascript">
			
			$(function(){
				
				/* 목록 버튼 클릭 시 처리 이벤트 */
				$("#expectListBtn").click(function(){
					history.back(); 
					//location.href = "/admin/expect/adminExpectList";
				});
				
			});
	</script>
	
	</head>
	<body>
		<div class="contentContainer container">
		
			<form name ="ex_data" id="ex_data" method="post">
				<input type="hidden" id="ex_no" name="ex_no" value="${detail.ex_no}"/>
				<input type="hidden" id="s_num" name="s_num" value="${s_num}"/>
			</form>
			
			
		
			
			<%-- 상세페이지 --%>
			<div class="contentTB text-center">
					<div class="text-right"><input type="button" value="목록" id="expectListBtn" class="btn btn-primary"/></div>	
				<table class="table table-bordered">
					<tbody>
						<tr>
							<td class="col-md-3">작성자</td>
							<td class="col-md-3 text-left">${detail.u_id}</td>
							<td class="col-md-3">작성일</td>
							<td class="col-md-3 text-left">${detail.ex_regdate}</td>
						</tr>
						<tr>
							<td class="col-md-4">제목</td>
							<td colspan="3" class="col-md-8 text-left">${detail.ex_title}</td>							
						</tr>
						<tr class="table-tr-height">
							<td class="col-md-4">내용</td>
							<td colspan="3" class="col-md-8 text-left">${detail.ex_content}</td>
						</tr>
					
					</tbody>
				</table>
				
				<div class="btnArea col-md-4 text-right">
					
				</div>
			</div>
			
		</div>