<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

	<script type="text/javascript">
		$(function(){
			/* 수정 버튼 클릭 시 처리 이벤트 */
			$("#qnaUpdateBtn").click(function(){
				if(!chkData("#q_title", "제목을")) return;
				else if (!chkData("#q_content", "작성할 내용을")) return;					
				else{
					
					$("#q_updateForm").attr({
						"method":"post", 
						"action":"/qna/qnaUpdate"
					});
					$("#q_updateForm").submit();
				}
			});
			
			/* 취소 버튼 클릭 시 처리 이벤트 */
			$("#qnaCancelBtn").click(function(){
				$("#q_updateForm").each(function(){
					this.reset();
				});
			});
			
			/*목록 버튼 클릭시 처리 이벤트 */
			$("#qnaListBtn").click(function(){
				location.href = "/qna/qnaList";
			});
		});
	</script>
	
	</head>
	<body>
		<div class="contentContainer container">
			<div class="contentTB text-center">
			
					<!-- 글번호 받는 hidden -->
				<form id="q_updateForm" name="q_updateForm">
					<input type="hidden" id="q_no" name="q_no" value="${updateData.q_no}"/>
					<input type="hidden" id="s_number" name="s_num" value="${param.s_num}"/>
					
					<table class="table table-bordered">
						<tbody>
							<tr>
								<td class="col-md-3">글번호</td>
								<td class="text-left col-md-3">${updateData.q_no}</td>
								<td class="col-md-3">작성일</td>
								<td class="text-left col-md-3">${updateData.q_regdate}</td>
							</tr>
							<tr>
								<td>작성자</td>
								<td colspan="3" class="text-left">${updateData.u_id}</td>
							</tr>
							<tr>
								<td>글제목</td>
								<td colspan="3" class="text-left">
									<input type="text" name="q_title" id="q_title" value="${updateData.q_title}" class="form-control" />
								</td>
							</tr>
							<tr class="table-tr-height">
								<td>내용</td>
								<td colspan="3" class="text-left">
									<textarea name="q_content" id="q_content" class="form-control" rows="8">${updateData.q_content}</textarea>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
			
			<div class= "contentBtn text-right">
				<input type="button" value="수정" id="qnaUpdateBtn" class="btn btn-primary"/>
				<input type="button" value="취소" id="qnaCancelBtn" class="btn btn-primary"/>
				<input type="button" value="목록" id="qnaListBtn" class="btn btn-primary"/>
			</div>
		</div>
	
	</body>
</html>