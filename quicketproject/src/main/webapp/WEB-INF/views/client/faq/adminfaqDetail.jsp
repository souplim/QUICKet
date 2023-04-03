<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

	<script type="text/javascript">
		let buttonCheck = 0; // 수정버튼과 삭제버튼을 구별하기 위한 변수
		$(function(){

			/* 수정 버튼 클릭 시 처리 이벤트 */
			$("#updateFormBtn").click(function(){
				goUrl = "adminfaqupdateForm";
				
				$("#f_data").attr("action",goUrl);
				$("#f_data").submit();				
				
			});
			
			/* 삭제 버튼 클릭 시 처리 이벤트  "f_no="+$("#f_no").val(),  쿼리 스트링이기 때문에 공백 들어가면 안된다.*/
			
			$("#faqDeleteBtn").click(function(){
				if(confirm("정말 삭제하시겠습니까?")){
					goUrl = "/faq/adminfaqDelete";
					$("#f_data").attr("action",goUrl);
					$("#f_data").submit();
				}
			});
								
			
			/* 글쓰기 버튼 클릭 시 처리 이벤트 */
			$("#insertFormBtn").click(function(){
				location.href = "/faq/adminfaqwriteForm"; 				
			});			
			
			/* 목록 버튼 클릭 시 처리 이벤트 */
			$("#faqListBtn").click(function(){
				location.href="/faq/adminfaqList"; 
			});
			
		});	
	</script>
	</head>
	<body>
	    <h3 class="text-center">FAQ 관리</h3>	
		<div class="contentContainer container"> 					 
			
			 <form name="f_data" id="f_data">
				<input type="hidden" name="f_no" value="${detail.f_no}"/>		
			</form> 
			
	
			<%-- =============== 상세 정보 보여주기 시작 ============ --%>
			<div class="contentTB text-center">
				<table class="table table-bordered">
				
					<tbody>
						<tr>
							<td class="col-md-1">카테고리</td> 
							<td class="col-md-1 text-left">${detail.f_category}</td> 						
						</tr>	
						
						<tr class="table-tr-height">	
							<td class="col-md-1">제목</td> 						
							<td colspan="3" class="col-md-8 text-left">${detail.f_title}</td>
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
				<input type="button" value="글수정" id="updateFormBtn" class="btn btn-primary" />
				<input type="button" value="글삭제" id="faqDeleteBtn" class="btn btn-primary" />
				<input type="button" value="글쓰기" id="insertFormBtn" class="btn btn-primary" />
				<input type="button" value="목록" id="faqListBtn" class="btn btn-primary" />
			</div>
		</div>	
	</body>
</html>
