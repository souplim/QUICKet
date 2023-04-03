<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

	<script type="text/javascript">
		$(function(){
			/* 저장 버튼 클릭 시 처리 이벤트 */
			$("#boardInsertBtn").click(function(){
				//입력값 체크
				if (!chkData("#b_name","이름을"))	return;
				else if (!chkData("#b_title","제목을"))	return;
				else if (!chkData("#b_content","작성할 내용을"))	return;
				else if (!chkData("#b_pwd","비밀번호를"))	return;
				//else if (!chkData("#file", "업로드할 이미지 파일을")) return;
				else {
					if($("#file").val()!=""){
						if(!chkFile($("#file"))) return;
					}
					$("#f_writeForm").attr({
						"method":"post",
						 "enctype":"multipart/form-data",  //enctype 속성의 기본 값은"application/x-www-form-urlcencoded".POST방식 폼 저송에 기본 값으로 사용
						"action":"/board/boardInsert"
					});
					$("#f_writeForm").submit();
				}
			});
			
			/* 취소 버튼 클릭 시 처리 이벤트 */
			$("#boardCancelBtn").click(function(){
				$("#f_writeForm").each(function(){
					this.reset();
				});
			});
			
			/* 목록 버튼 클릭 시 처리 이벤트 */
			$("#boardListBtn").click(function(){
				location.href="/board/boardList";
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
								<td><h2>공연명</h2></td>							
								<td><h2></h2></td>							
							</tr>
							<tr>
								<td>관람시작날짜</td>
								<td class="text-left"><input type="text" name="b_name" id="b_name" class="form-control" /></td>
							</tr>
							<tr>
								<td>관람종료날짜</td>
								<td class="text-left"><input type="text" name="b_name" id="b_name" class="form-control" /></td>
							</tr>
							<tr>
								<td>공연관</td>
								<td class="text-left"><input type="text" name="b_title" id="b_title" class="form-control" /></td>
							</tr>
							<tr>
								<td>상영회차,시간</td>
								<td class="text-left"><textarea name="text" id="b_content" class="form-control" rows="8"></textarea> </td>
							</tr>
							<tr>
								<td>좌석수</td>
								<td class="text-left"><input type="text" name="b_pwd" id="b_pwd" class="form-control" /></td>
							</tr>
						</tbody>	
					</table>
	    				    
					<div class="text-right">
						<input type="button" value="저장" id="ticketInsertBtn" class="btn btn-success" />
						<input type="button" value="취소" id="ticketCancelBtn" class="btn btn-success" />
						<input type="button" value="목록" id="ticketListBtn" class="btn btn-success" />
					</div>
				</form>
			</div>
		</div>
	</body>
</html>