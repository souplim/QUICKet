<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

	<style type="text/css">
	tr.table-tr-height { height: 200px;}
	div.container{width: 700px;}
	</style>

	<script type="text/javascript">
			//let buttonCheck = 0;
			$(function(){

				/* 수정 버튼 클릭 시 처리 이벤트 */
				$("#qnaUpdateBtn").click(function(){
					goUrl = "/qna/qnaUpdateForm";
					$("#q_data").attr("action",goUrl);
					$("#q_data").submit(); 
				});
				
				/* 목록 버튼 클릭 시 처리 이벤트 */
				$("#qnaListBtn").click(function(){
					location.href = "/qna/qnaList";
				});
				
				/* 삭제 버튼 클릭 시 처리 이벤트 */
				$("#qnaDeleteBtn").click(function(){
					if(confirm("댓글을 삭제하시겠습니까?")){
						$.ajax({
							url: "/qna/qnaReplyCnt",
							type: "post",
							data: "q_no="+$("#q_no").val(),
							dataType: "text",
							error: function(){
								alert('시스템 오류, 관리자에게 문의하세요.');
							},
						success : function(resultData){
							if(resultData==0){
								goUrl = "/qna/qnaDelete";
								
								$("#q_data").attr("action", goUrl);
								$("#q_data").submit();
								
							} else {
								alert("댓글이 존재하면 게시물을 삭제할 수 없습니다.\n댓글 삭제 후 다시 확인해주세요. ")
								return;
								}
							}

						});
						
					}
					
				}); 
			});
	</script>
	
	</head>
	<body>
		<div class="contentContainer container">
		
			<form name ="q_data" id="q_data" method="post">
				<input type="hidden" id="q_no" name="q_no" value="${detail.q_no}"/>
				<input type="hidden" id="s_num" name="s_num" value="${detail.s_num}"/>
			</form>
			
			
			<%-- 상세페이지 --%>
			<div class="contentTB text-center">
				<table class="table table-bordered">
					<tbody>
						<tr>
							<td class="col-md-2">작성자</td>
							<td class="col-md-3 text-left">${detail.u_id}</td>
							<td class="col-md-2">작성일</td>
							<td class="col-md-3 text-left">${detail.q_regdate}</td>
						</tr>
						<tr>
							<td class="col-md-2">제목</td>
							<td colspan="3" class="col-md-8 text-left">${detail.q_title}</td>							
						</tr>
						<tr class="table-tr-height">
							<td class="col-md-2">내용</td>
							<td colspan="3" class="col-md-8 text-left">${detail.q_content}</td>
						</tr>
					
					</tbody>
				</table>
			</div>
				<div class="btnArea text-right">
					<c:if test = "${userLogin.u_id == detail.u_id}">
						<input type="button" value="수정" id="qnaUpdateBtn" class="btn btn-primary"/>
						<input type="button" value="삭제" id="qnaDeleteBtn" class="btn btn-primary"/>
						
					</c:if>
					
						<input type="button" value="목록" id="qnaListBtn" class="btn btn-primary"/>
				</div>
			
			
			<jsp:include page="qnaReply.jsp" />
			</div>
</body>
</html>