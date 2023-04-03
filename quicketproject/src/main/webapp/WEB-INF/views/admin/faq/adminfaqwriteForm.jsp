<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

	<script type="text/javascript">
		$(function(){
					
			
			/* 저장 버튼 클릭 시 처리 이벤트 */
			$("#faqInsertBtn").click(function(){
				//입력값 체크
				if (!chkData("#f_category","카테고리"))	return;
				else if (!chkData("#f_title","제목을"))	return;
				else if (!chkData("#f_content","작성할 내용을"))	return;
				else {
									
					$("#f_writeForm").attr({
						"method":"post",
						"enctype":"multipart/form-data", // enctype 속성의 기본 값은 "application/x-www-form-urlcencoded". POST방식 폼 전송에 기본 값으로 사용
						"action":"/admin/faq/adminfaqInsert"
					});
					$("#f_writeForm").submit();
				}
			});
			
			/* 취소 버튼 클릭 시 처리 이벤트 */
			$("#faqCancelBtn").click(function(){
				$("#f_writeForm").each(function(){
					this.reset();
				});
			});
			
			/* 목록 버튼 클릭 시 처리 이벤트 */
			$("#faqListBtn").click(function(){
				location.href="/admin/faq/adminfaqdList";
			});
		});
	</script>
	</head>	
	<body>	
		<div class="contentContainer container">
			<!-- <div class="contentTit page-header"><h3 class="text-center">게시판 글작성</h3></div> --> 
	
			<div class="contentTB text-center">
				<form id="f_writeForm" name="f_writeForm" class="form-horizontal">
					<table class="table table-bordered">
						<colgroup>
							<col width="20%" />
							<col width="80%" />
						</colgroup>
						<tbody>
							<tr>
								<td>카테고리</td>
						<!-- 	<td class="text-left"><input type="text" name="f_category" id="f_category" class="form-control" /></td>  -->
								<td>
									<select id="f_category" name="f_category" class="form-control">
										<option value="회원">회원</option>
										<option value="예매/취소">예매/취소</option>				
										<option value="결제">결제</option>
										<option value="기타">기타</option>	
									</select>	
								</td>					
							</tr>
							<tr>
								<td>FAQ제목</td>
								<td class="text-left"><input type="text" name="f_title" id="f_title" class="form-control" /></td>
							</tr>
							<tr>
								<td>FAQ내용</td>
								<td class="text-left"><textarea name="f_content" id="f_content" class="form-control" rows="20"></textarea> </td>
							</tr>					
							
						</tbody>	
					</table>
	    				    
					<div class="text-right">
						<input type="button" value="저장" id="faqInsertBtn" class="btn btn-primary" />  <!--btn btn-success  -->
						<input type="button" value="취소" id="faqCancelBtn" class="btn btn-primary" />
						<input type="button" value="목록" id="faqListBtn" class="btn btn-primary" />
					</div>
				</form>
			</div>
		</div>
	</body>
</html>