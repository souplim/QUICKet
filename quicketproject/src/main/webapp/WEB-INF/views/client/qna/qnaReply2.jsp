<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

<style>
		 #item-template{display: none;}
		 .inline{display:inline-block;}
	</style>
	
	<script type = "text/javascript">
		let btnKind = "";
		
		$(function(){
			
			/* 기본 덧글 목록 불러오기 */
			let q_no = ${detail.q_no};	
			listAll(q_no);
			

			/** 글 입력을 위한 Ajax 연동 처리 */
			$(document).on("click", "#q_replyInsertBtn", function(){	//  입력화면이 수정화면이 될수 있고 수정form으로 쓸수 있어서, 동적으로 요소 만들다 보니 on 이라는 구문으로 정의
				let insertUrl = "/qnaReply/qnaReplyInsert";
				
				let value = JSON.stringify({	
					q_no:q_no,
					q_r_content:$("#q_r_content").val()
				});
				
				$.ajax({
					url: insertUrl,		
					type: "post",		
					headers : {
						"Content-Type":"application/json"
					},
					dataType:"text",
					data: value,
					//data : $("#frm").serialize(),
					error: function(xhr, textStatus, errorThrown){	
						alert(textStatus + "(HTTP-"+xhr.status + "/" +errorThrown+")");
						
					},
					beforeSend: function(){	
						if(!checkForm("#q_r_content", "댓글 내용을")) return false;
						
					},
					success : function(result){	
						if(result =="SUCCESS"){
							alert("댓글 등록이 완료되었습니다");
							dataReset();
							listAll(q_no);
						}
					}
				});
			});	
			
			/** 수정 클릭  */
			$(document).on("click", ".upBtn", function(){
				let panel = $(this).parents("div.panel");
				let q_r_no = panel.attr("data-num");
				console.log("q_r_no: " + q_r_no);
				
				updateForm(q_r_no, panel);

			});
			
			/** 삭제 클릭  */
			$(document).on("click", ".delBtn", function(){
				let panel = $(this).parents("div.panel");
				let q_r_no = panel.attr("data-num");
				//console.log("q_r_no: " + q_r_no);
				//console.log("q_no: " + q_no);
				
				deleteBtn(q_no, q_r_no);
			});
			
			/** 수정 폼 화면 구현 함수 */
			function updateForm(q_r_no, panel){
				//$("#replyForm" .resetBtn).detach();
				
				
				let content = panel.find(".panel-body").html();		
				content = content.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n');	
				$("#q_r_content").val(content);
				
				$("#replyForm button[type='button']").attr("id", "replyUpdateBtn");	// 등록버튼에 id=replyUpdateBtn으로 속성 부여
				$("#replyForm button[type='button']").attr("data-num", q_r_no);
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
				let q_r_no = $(this).attr("data-num");
				$.ajax({
					url:'/qnaReply/'+q_r_no,
					type: 'put',
					headers: {
						"Content-Type": "application/json",
						"X-HTTP-Method-Override":"PUT"
					},
					data:JSON.stringify({	
						q_r_content:$("#q_r_content").val(),
						
					}),
					dataType:'text',
					error: function(xhr, textStatus, errorThrown){
						alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
						
					},
					beforeSend: function(){
						if(!checkForm("#q_r_content", "댓글 내용을")) return false;	
					},
					success:function(result){
						console.log("result: "+result);
						if(result == "SUCCESS"){
							alert("댓글 수정이 완료 되었습니다.");
							dataReset();
							listAll(q_no);
						}
					}
				});
			});
			
		});	
		
		
	/** 댓글 목록 보여주는 함수 - 서버로부터 리스트를 받아오기 위한 요청 함수*/
	function listAll(q_no){
		$(".reply").detach();	// detach() : 선택한 요소를 DOM 트리에서 삭제
		
		let url = "/qnaReply/all/"+q_no;	// 

		$.getJSON(url, function(data){	
			$(data).each(function(){
				let q_r_no = this.q_r_no;
				let u_id = this.u_id;
				let q_r_content = this.q_r_content;
				let q_r_regdate = this.q_r_date;
				q_r_content = q_r_content.replace(/(\r\n|\r|\n)/g, "<br />");
				template(q_r_no, u_id, q_r_content, q_r_regdate);
			
			});
		
		}).fail(function(){
			alert("댓글 목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해주세요");
		});		
	}
	
	/** 새로운 글을 화면에 추가하기(보여주기) 위한 함수 */
		function template(q_r_no, u_id, q_r_content, q_r_regdate){
			let $div = $('#reviewList');
			
			let $element = $('#item-template').clone().removeAttr('id');
			$element.attr("data-num", q_r_no);	
			$element.addClass("reply");
			$element.find('.panel-heading > .panel-title > .id').html(u_id);	
			$element.find('.panel-heading > .panel-title > .date').html(" / " + q_r_regdate);
			$element.find('.panel-body').html(q_r_content);
			
			$div.append($element);
		
		}	
	
	/* 입력 폼 초기화 */
	function dataReset(){
		$("#replyForm").each(function(){
			this.reset();
		});
		
		$("#u_id").prop("readonly", false);	
		$("#replyForm button[type='button']").removeAttr("data-num");
		$("#replyForm button[type='button']").attr("id", "replyInsertBtn");
		$("#replyForm button[type='button'].sendBtn").html("저장");
		$("#replyForm button[type='button'].resetBtn").detach();
	}
	
	
	/** 글 삭제를 위한 Ajax 연동 처리 */
	function deleteBtn(q_no, q_r_no){
		if(confirm("선택하신 댓글을 삭제하시겠습니까?")){
			$.ajax({
				url : '/qnaReply/'+q_r_no,
				type: 'delete',
				headers : {
					"X-HTTP-Method-Override" : "DELETE"
				},
				dataType : 'text',
				error: function(xhr, textStatus, errorThrown){	
					alert(textStatus + " (HTTP-"+xhr.status + " / " + errorThrown + ")");
					
				},
				success : function(result){
					console.log("result: "+result);
					if(result == 'SUCCESS'){
						alert("댓글 삭제가 완료되었습니다.");
						listAll(q_no);
					}
				}
			});
		} else {
			formHide();
		}
	}
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
								<td class="col-md-1">작성자</td>
								<td class="col-md-3 text-left">
									${detail.u_id}
								</td>
									
									<td class="col-md-4-btnArea">
										<button type="button" id="replyInsertBtn" class="btn btn-primary gap sendBtn">등록</button>
									</td>
							</tr>
							<tr>
								<td class="col-md-1">댓글내용</td>
								<td colspan="4" class="col-md-11 text-left">
									<textarea name="q_r_content" id="q_r_content" class="form-control" rows="3"></textarea>
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
							<span class="id"></span>
							<span class="date"></span>
							
								<button type="button" data-btn="upBtn" class="btn btn-default gap upBtn">수정하기</button>
								<button type="button" data-btn="delBtn" id="q_replyDeleteBtn" class="btn btn-default gap delBtn">삭제하기</button>
							<!--  <c:if test=""></c:if> 로 id 일치, 불일치에 따라 수정삭제 버튼 뜨는 조건 넣어야 --> 
						</h3>
					</div>
					<div class="panel-body"></div>
				</div>
			</div>
		</div>

</body>
</html>