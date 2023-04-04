<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

<style type="text/css">
	#item-template{display: none;}
	.inline{display:inline-block;}
</style>


<script type = "text/javascript">
		$(function(){
			
			/* 기본 댓글 목록 불러오기 */
			let s_num = ${detailData.s_num};
			
			listAll(s_num);
			
			/** 글 입력을 위한 Ajax 연동 처리 */
			$(document).on("click", "#replyInsertBtn", function(){
				let id = "${userLogin.u_id}";
				
				if(id != ""){
					let insertUrl = "/expect/expectInsert";
					
					let value = JSON.stringify({
						ex_title:$("#ex_title").val(),
						ex_content:$("#ex_content").val(),
						s_num:s_num
					});
					{}
					$.ajax({
						url: insertUrl,
						type: "post",
						headers : {
							"Content-Type":"application/json"
						},
						dataType:"text",
						data : value,
						error: function(xhr, textStatus, errorThrown){
							alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
						},
						beforeSend: function(){	
							if(!checkForm("#ex_title","댓글 제목을 "))	return false;
							if(!checkForm("#ex_content", "댓글 내용을 ")) return false;
						},
						success : function(result){
							if(result == "SUCCESS"){
								alert("댓글 등록이 완료되었습니다.");
								dataReset();
								listAll(s_num);
							}
						}
					});
				} else {
					alert("로그인 후 서비스를 이용하실 수 있습니다.");
					location.href = "/user/login";
				}
			});
			
			/** 수정 클릭  */
			$(document).on("click", ".upBtn", function(){
				let panel = $(this).parents("div.panel");
				let ex_no = panel.attr("data-num");
				console.log("ex_no: " + ex_no);
				
				updateForm(ex_no, panel);
			});
			
			/** 삭제 클릭  */
			$(document).on("click", ".delBtn", function(){
				let panel = $(this).parents("div.panel");
				let ex_no = panel.attr("data-num");
				//console.log("q_r_no: " + q_r_no);
				//console.log("q_no: " + q_no);
				
				deleteBtn(s_num, ex_no);
			});
			
			/** 수정 폼 화면 구현 함수 */
			function updateForm(ex_no, panel){
				//$("#replyForm" .resetBtn).detach();
				
				let content = panel.find(".panel-body").html();		
				content = content.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n');	
				$("#ex_content").val(content);
				
				$("#replyForm button[type='button']").attr("id", "replyUpdateBtn");	// 등록버튼에 id=replyUpdateBtn으로 속성 부여
				$("#replyForm button[type='button']").attr("data-num", ex_no);
				$("#replyForm button[type='button']").html("수정");	// 등록 -> 수정 버튼으로 변경
				
				let resetButton = $("<button type='button' class='btn btn-primary resetBtn'>");	//취소버튼 생성?
				resetButton.html("취소");
				$("#replyForm .sendBtn").after(resetButton);	// 기존등록버튼 뒤에 취소버튼 추가. .after() - 선택한 요소 뒤에 새 요소를 추가하거나, 다른 곳에 있는 요소를 이동시키는 메서드
			}
			
			$(document).on("click", ".resetBtn", function(){
				dataReset();
			});
		
			
			/** 수정을 위한 Ajax 연동 처리 */
			$(document).on("click", "#replyUpdateBtn", function(){
				let ex_no = $(this).attr("data-num");
				$.ajax({
					url:'/expect/'+ex_no,
					type: 'put',
					headers: {
						"Content-Type": "application/json",
						"X-HTTP-Method-Override":"PUT"
					},
					data:JSON.stringify({	
						ex_content:$("#ex_content").val(),
						
					}),
					dataType:'text',
					error: function(xhr, textStatus, errorThrown){
						alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
						
					},
					beforeSend: function(){
						if(!checkForm("#ex_title", "댓글 제목을 ")) return false;
						if(!checkForm("#ex_content", "댓글 내용을 ")) return false;	
					},
					success:function(result){
						console.log("result: "+result);
						if(result == "SUCCESS"){
							alert("댓글 수정이 완료 되었습니다.");
							dataReset();
							listAll(s_num);
						}
					}
				});
			});
		});
	</script>

	</head>
	<body>

	<div id = "replyContainter">

			<%-- 댓글 리스트 화면 --%>
			<form id = "replyForm" name="replyForm">
				<div class="panel panel-default">
					<table class="table">
						<tbody>
							<tr>
								<td class="col-md-2">작성자</td>
								<td class="col-md-3 text-left">
									${userLogin.u_id}
								</td>
									
									<td class="col-md-4-btnArea">
										<button type="button" id="replyInsertBtn" class="btn btn-primary gap sendBtn">등록</button>
									</td>
							</tr>
							<tr>
								<td class="col-md-2">내용</td>
								<td colspan="4" class="col-md-11 text-left">
									<textarea name="ex_content" id="ex_content" class="form-control" rows="3"></textarea>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</form>
			
			
			<%-- 리스트 영역 --%>
			<div id="reviewList">
				<div id="item-template" class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">
							<span class="title"></span>
							<span class="id"></span>
							<span class="date"></span>
								<button type="button" data-btn="upBtn" class="btn btn-default gap upBtn">수정하기</button>
								<button type="button" data-btn="delBtn" id="q_replyDeleteBtn" class="btn btn-default gap delBtn">삭제하기</button>
						</h3>
					</div>
					<div class="panel-body"></div>
				</div>
			</div>
		</div>

</body>
</html>