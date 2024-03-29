<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

<style>
		 #qnaReply-template{display: none;}
		 .inline{display:inline-block;}
		 .panel-heading {background-color:#CCEEFF;} 
	</style>
	
	<script type = "text/javascript">
		$(function(){
			
			/* 기본 덧글 목록 불러오기 */
			let q_no = ${detail.q_no};	
			qnaReplyListAll(q_no);
			
			let u_id = ${detail.q_no};
			

			/** 글 입력을 위한 Ajax 연동 처리 */
			$(document).on("click", "#replyInsertBtn", function(){	//  입력화면이 수정화면이 될수 있고 수정form으로 쓸수 있어서, 동적으로 요소 만들다 보니 on 이라는 구문으로 정의
				let id ="${userLogin.u_id}";
				
				if(id != ""){
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
								qnaReplyListAll(q_no);
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
				
				let resetButton = $("<button type='button' class='w-btn-outline w-btn-gray-outline btn resetBtn'>");	//취소버튼 생성?
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
							qnaReplyListAll(q_no);
						}
					}
				});
			});
			
		});	
		
		
	/** 댓글 목록 보여주는 함수 - 서버로부터 리스트를 받아오기 위한 요청 함수*/
	function qnaReplyListAll(q_no){
		$(".reply").detach();	// detach() : 선택한 요소를 DOM 트리에서 삭제
		
		let url = "/qnaReply/all/"+q_no;	// 

		$.getJSON(url, function(data){	
			$(data).each(function(){
				let q_r_no = this.q_r_no;
				let u_id = this.u_id;
				let q_r_content = this.q_r_content;
				let q_r_regdate = this.q_r_regdate;
				q_r_content = q_r_content.replace(/(\r\n|\r|\n)/g, "<br />");
				qrTemplate(q_r_no, u_id, q_r_content, q_r_regdate);
			
			});
		
		}).fail(function(){
			alert("댓글 목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해주세요");
		});		
	}
	
	/** 새로운 글을 화면에 추가하기(보여주기) 위한 함수 */
		function qrTemplate(q_r_no, u_id, q_r_content, q_r_regdate){
		
			let id = "${userLogin.u_id}"
			let $div = $('#reviewList');
			
			let $element = $('#qnaReply-template').clone().removeAttr('id');
			$element.attr("data-num", q_r_no);	
			$element.addClass("reply");
			$element.find('.panel-heading > .panel-title > .id').html(u_id);	
			$element.find('.panel-heading > .panel-title > .date').html(" / " + q_r_regdate);
			
			if(id == u_id){
				$element.find('.panel-heading > .panel-title > button').show();
			}else {
				$element.find('.panel-heading > .panel-title > button').hide();
			}
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
						qnaReplyListAll(q_no);
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
								<td class="col-md-2">작성자</td>
								<td class="col-md-3 text-left">
									${userLogin.u_id}
								</td>
									
									<td class="col-md-4-btnArea text-right">
										<button type="button" id="replyInsertBtn" class="btn w-btn-outline w-btn-indigo-outline sendBtn">등록</button>
									</td>
							</tr>
							<tr>
								<td class="col-md-2">내용</td>
								<td colspan="4" class="col-md-11 text-left">
									<textarea name="q_r_content" id="q_r_content" class="form-control" rows="3"></textarea>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</form>
			
			
			<%-- 불러온 리스트 출력되는 영역 --%>
			<div id="reviewList">
				<div id="qnaReply-template" class="panel">
					<div class="panel-heading">
						<h3 class="panel-title">
							<span class="id"></span>
							<span class="date"></span>
							&nbsp;
							<button type="button" data-btn="upBtn" class="w-btn-outline w-btn-gray-outline btn gap upBtn">수정하기</button>
							<button type="button" data-btn="delBtn" id="q_replyDeleteBtn" class="w-btn-outline w-btn-gray-outline btn gap delBtn">삭제하기</button>
						</h3>
					</div>
					<div class="panel-body"></div>
				</div>
			</div>
		</div>
		

</body>
</html>