<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

	<script type="text/javascript">
		$(function(){
			/* 수정 버튼 클릭 시 처리 이벤트 */
			$("#faqUpdateBtn").click(function(){
				//입력값 체크
				if (!chkData("#f_title","제목을"))	 return;
				else if (!chkData("#f_content","작성할 내용을"))	return;
				else{							
					$("#f_updateForm").attr({
						"method":"post",
						"enctype":"multipart/form-data", // enctype 속성의 기본 값은 "application/x-www-form-urlcencoded". POST방식 폼 전송에 기본 값으로 사용
						"action":"/admin/faq/adminfaqUpdate"
						
						
					});
					$("#f_updateForm").submit();
				}
			});
			
			/* 취소 버튼 클릭 시 처리 이벤트 */
			$("#faqCancelBtn").click(function(){
				$("#f_updateForm").each(function(){
					this.reset();
				});
			});				
			
			/* 목록 버튼 클릭 시 처리 이벤트 */
			$("#faqListBtn").click(function(){
				location.href="/admin/faq/adminfaqList"; 
			});
		});
	</script>
	</head>
	<body>
	    <h3 class="text-center">FAQ 관리</h3>		
		<div class="contentContainer container">
			<!-- <div class="contentTit page-header"><h3 class="text-center">게시판 글수정</h3></div> -->
				
			<div class="contentTB text-center">
				<form id="f_updateForm" name="f_updateForm">
					<input type="hidden" id="f_no" name="f_no" value="${updateData.f_no}" />
										
					<table class="table table-bordered">
						<tbody>
							<tr>
								<td class="col-md-3">글번호</td> 
								<td class="text-left col-md-3">${updateData.f_no}</td>
								<td class="col-md-3">작성일</td> 
								<td class="text-left col-md-3">${updateData.f_regdate}</td> 
							</tr>
							<tr>
							 	<td>카테고리</td>
								<td colspan="3" class="text-left">
									<input type="text" name="f_category" id="f_category" value="${updateData.f_category}" class="form-control" />
								</td>
							</tr>
							<tr>
								<td>글제목</td>
								<td colspan="3" class="text-left">
									<input type="text" name="f_title" id="f_title" value="${updateData.f_title}" class="form-control" />
								</td>
							</tr>
							<tr class="table-tr-height">
								<td>내용</td>
								<td colspan="3" class="text-left">
									<textarea name="f_content" id="f_content" class="form-control" rows="8">${updateData.f_content}</textarea>
								</td>
							</tr>							
						</tbody>	
					</table>
				</form>
			</div>	
			
			<div class="contentBtn text-right">
				<input type="button" value="수정" id="faqUpdateBtn" class="btn btn-primary" />
				<input type="button" value="취소" id="faqCancelBtn" class="btn btn-primary" />				
				<input type="button" value="목록" id="faqListBtn" class="btn btn-primary" />
			</div>
		</div>
	</body>
</html>