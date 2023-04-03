<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

<script type="text/javascript">
	
		$(function(){
			/*등록 버튼 클릭 시 처리 이벤트 */
			$("#qnaInsertBtn").click(function(){
				
				if (!chkData("#q_title", "제목을")) return;
				else if(!chkData("#q_content", "내용을")) return;
					
					$("#q_writeForm").attr({
						method: "post",
						action: "/qna/qnaInsert"
					});
					$("#q_writeForm").submit();
				});
			
			
			/* 취소 버튼 클릭 시 처리 이벤트 */
			$("#qnaCancelBtn").click(function(){
				$("#q_writeForm").each(function(){
					this.reset();
				});
			});
			
			/* 목록 버튼 클릭 시 처리 이벤트 */
			$("#qnaListBtn").click(function(){
				location.href = "/qna/qnaList";
			});
		
		});
	</script>
</head>
	<body>
		<div class="contentContainer container">
			
		<div class="contentTB text-center">
			<form  id="q_writeForm" name="q_writeForm" class="form-horizontal">
				 <table class="table table-bordered">
				 	<colgroup>
				 		<col width = "20%"/>
				 		<col width = "80%"/>
				 	</colgroup>
				 	<tbody>
				 		<tr>
				 			<td>작성자</td>
				 			<td class="text-left">${userLogin.u_id}</td>
				 		</tr>
				 		<tr>
				 			<td>제목</td>
				 			<td class="text-left"><input type="text" name="q_title" id="q_title" class="form-control"/></td>
				 		</tr>
				 		<tr>
				 			<td>내용</td>
				 			<td class="text-left"><textarea name="q_content" id="q_content" class="form-control" rows="8"></textarea></td>
				 		</tr>
				 
				 	</tbody>
				  </table>
				  
				  <div class = "text-right">
				  	<input type="button" value="등록" id="qnaInsertBtn" class="btn btn-primary"/>
				  	<input type="button" value="취소" id="qnaCancelBtn" class="btn btn-primary"/>
				  	<input type="button" value="목록" id="qnaListBtn" class="btn btn-primary"/>
				  </div>
			  </form>
			</div>
		</div>
</html>