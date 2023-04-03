<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	<script type="text/javascript">	
			$(function(){
				/* 목록 버튼 클릭 시 처리 이벤트 */
				$("#boardListBtn").click(function(){
					location.href="/faq/faqList"; 
				});			
			});				
	</script>
	</head>
	<body>
	    <h3 class="text-center">FAQ</h3>		
		<div class="contentContainer container"> 					 
			<!-- 
			 <form name="f_data" id="f_data">
				<input type="hidden" name="f_no" value="${detail.f_no}"/>		
			</form> 
			 -->		
	
			<%-- =============== 상세 정보 보여주기 시작 ============ --%>
			<div class="contentTB text-center">
				<table class="table table-bordered">
				
					<tbody>
						<tr>
							<td class="col-md-1">구분</td> 
							<td class="col-md-1 text-left">${detail.f_category}</td> 						
						</tr>	
						
						<tr class="table-tr-height">							
							<td colspan="3" class="col-md-8 text-center">${detail.f_title}</td>
						</tr>			
								
						<tr>								
							<td class="col-md-3">작성일</td>
							<td class="col-md-3 text-left">${detail.f_regdate}</td>							
							<td class="col-md-3">수정일</td>
							<td class="col-md-3 text-left">${detail.f_update}</td>
						</tr>
								
						<tr class="table-tr-height">
							<td class="col-md-4">글내용</td>
							<td colspan="3" class="col-md-10 text-left">${detail.f_content}</td>
						</tr>	
					</tbody>
					
				
				<!-- 
					<tbody>
						<tr>
							<td class="col-md-1">구분</td> 
							<td class="col-md-1 text-left">${detail.f_category}</td> 
							<td class="col-md-1">제목</td> 
							<td class="col-md-3 text-center">${detail.f_title}</td> 
						</tr>	
						<tr>								
							<td class="col-md-3">작성일</td>
							<td class="col-md-3 text-left">${detail.f_regdate}</td>							
							<td class="col-md-3">수정일</td>
							<td class="col-md-3 text-left">${detail.f_update}</td>
						</tr>
						<tr class="table-tr-height">							
							<td colspan="3" class="col-md-8 text-left">${detail.f_title}</td>
						</tr>			
											
						<tr class="table-tr-height">
							<td class="col-md-4">글내용</td>
							<td colspan="3" class="col-md-10 text-left">${detail.f_content}</td>
						</tr>	
					</tbody>
				 -->
				 	
				</table>			
			</div>			
	
							
			<%-- ========= 목록 버튼 ====== --%>	
			<div class="btnArea col-md-4 text-right">
				<input type="button" value="목록보기" id="boardListBtn" class="btn btn-primary" />
			</div>
		</div>	
	</body>
</html>
