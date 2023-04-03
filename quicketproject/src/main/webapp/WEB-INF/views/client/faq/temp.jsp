<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

	<style>
		#item-template{display:none;}
		.inline{display:inline-block;} 			
	</style> 
	
	<script type="text/javascript">		
		$(function() {			
			
			/** 댓글 목록 보여주는 함수*/ 	
			let s_num = ${detail.s_num};
			let r_no =  ${detail.r_no};	
			//let u_id =  ${detail.u_id};	
			

			listAll(s_num);			
						
					
					/** 글입력을 위한  Ajax 연동 처리 */
					//$("#replyInsertBtn").click(function(){ 
					$(document).on("click", "#replyInsertBtn", function(){ 
					
						let insertUrl = "/reviewList/reviewInsert";
						
						/* JSON.stringify(): JavaScript 값이나 객체를 JSON 문자열로 변환. */
						let value = JSON.stringify({
						//	r_no:r_no,
							u_id:'yubin', 
							r_title:$("#r_title").val(),
							r_content:$("#r_content").val(),
							r_point:$("#r_point").val(),
							r_hit:0,
							s_num:s_num
						});
						{}
						$.ajax({
							url : insertUrl,  //전송 url
							type : "post",    // 전송 시 method 방식
							headers : {
								"Content-Type":"application/json"
							},
							dataType:"text",
							data : value,
							error: function(xhr, textStatus, errorThrown) { //실행시 오류가 발생하였을 경우
								alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
								//alert("시스템에 문제가 있어 잠시 후 다시 진행해 주세요.");
							},
							beforeSend: function(){  // 전송 전 유효성 체크
								if (!checkForm("#r_title","작성자를"))	          return false; // checkForm()함수는 placeholder 속성을 이용하여 메시지 출력						
								else if (!checkForm("#r_content","댓글내용을"))  return false;
							},
							success : function(result){ // 서버로부터 응답코드 200으로 정상 처리가 되었을 경우
								if(result=="SUCCESS"){
									alert("댓글 등록이 완료되었습니다.");
									dataReset();        // 입력폼 초기화
									listAll(s_num);
								}
							}
						});
					});
					
		
				
				/** 수정 버튼 처리 */
				$(document).on("click", "#updateBtn", function(){ 	
					
					let panel = $(this).parents("div.panel")
					let r_no = panel.attr("data-num");
					let s_num = panel.attr("data-snum");
					let form = $(this).parents(".inline");				
				//	let msg = form.find(".msg");
					let value = 0;
					
					console.log("수정 폼 출력");					
					updateForm(r_no, panel, s_num);
				//	formHide();						
					}); 
		
			});	
		
		/** 수정 폼 화면 구현 함수 */
		function updateForm(r_no, panel,s_num){
			$("#replyForm .resetBtn").detach();
		
			$("#r_name").val(panel.find(".panel-title .name").html());
			$("#r_name").prop("readonly", true);
			
			let content = panel.find(".panel-body").html();	
			let r_title = panel.find('.panel-heading > .panel-title > .name').html();					
			
			content = content.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n');
			$("#r_content").val(content);					
			$("#r_title").val(r_title);
			
			//추가					
			
			$("#replyForm button[type='button']").attr("id", "replyUpdateBtn");
			$("#replyForm button[type='button']").attr("data-rnum", r_no);
			//추가
			$("#replyForm button[type='button']").attr("data-snum", s_num);
			$("#replyForm button[type='button']").html("수정");
								
			
			let resetButton = $("<button type='button' class='btn btn-primary resetBtn'>");
			resetButton.html("취소");
			$("#replyForm .sendBtn").after(resetButton);
			
		}
		
		/* 수정하기 클릭시 동적으로 생성된 "취소" 버튼 이벤트 처리 */
		$(document).on("click", ".resetBtn", function(){ 
			dataReset();
		});		
	
				
		/** 수정을 위한  Ajax 연동 처리 */
		$(document).on("click", "#replyUpdateBtn", function(){
			
			
			let r_no = $(this).attr("data-rnum");	
			let s_num = $(this).attr("data-snum");	
			
				
			$.ajax({					
				
				url:'/reviewList/'+r_no,
				type:'put',
				headers: { 
					"Content-Type": "application/json",
					"X-HTTP-Method-Override": "PUT" 
				},
				data:JSON.stringify({
					r_content:$("#r_content").val(),
					r_title:$("#r_title").val()
				}), 
				dataType:'text', 
				error: function(xhr, textStatus, errorThrown) { 
					alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
					//alert("시스템에 문제가 있어 잠시 후 다시 진행해 주세요.");
				}, 
				beforeSend: function(){
					if (!checkForm("#r_content","댓글내용을"))	return false;
				},
				success:function(result){
					console.log("result: " + result);
					if(result == "SUCCESS"){
						alert("댓글 수정이 완료되었습니다.");
						dataReset();
						listAll(s_num);
					}
				}
			}); 		
		});		 /* 최상위 종료*/	
		
		/** 기본 목록 불러오기 */
		function listAll(s_num){				
			$(".reply").detach(); // detach(): 선택한 요소를 DOM 트리에서 삭제.
			
			let url = "/reviewList/all/"+s_num; 				
			$.getJSON(url, function(data) { //data = [{r_num:?, r_name:"?"}, {}]
 				$(data).each(function() { 					
 				
 					let s_num = this.s_num;
 					let r_title = this.r_title;
 					let r_content = this.r_content;
 					let r_regdate = this.r_regdate;
 					let r_no	= this.r_no;
 					
					r_content = r_content.replace(/(\r\n|\r|\n)/g, "<br />");
					template(s_num, r_title, r_content, r_regdate, r_no);
				});
			}).fail(function() {
				alert("덧글 목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해 주세요.");
			});				
				
		}	
		
		
		/** 새로운 글을 화면에 추가하기(보여주기) 위한 함수*/
		function template(s_num, r_title, r_content, r_regdate,r_no){
			let $div = $('#reviewList');			 
			let $element = $('#item-template').clone().removeAttr('id');
			$element.attr("data-snum", s_num);
			$element.attr("data-num", r_no);
			$element.addClass("reply");
		    $element.find('.panel-heading > .panel-title > .name').html(r_title);
		    $element.find('.panel-heading > .panel-title > .date').html(" / " + r_regdate); 
		    $element.find('.panel-body').html(r_content);			 
		    
		    $div.append($element); 
		}			
		
		
		/* 입력 폼 초기화 */
		function dataReset() {
			$("#replyForm").each(function(){
				this.reset();
			});				
		
			$("#r_name").prop("readonly", false);
			$("#replyForm button[type='button']").removeAttr("data-rnum");
			$("#replyForm button[type='button']").attr("id", "replyInsertBtn");
			$("#replyForm button[type='button'].sendBtn").html("저장");
			$("#replyForm button[type='button'].resetBtn").detach();
		}		
	
		
		$(document).on("click", "#delBtn", function(){

			
			let r_no =   ${detail.r_no};
			let s_num = ${detail.s_num};
			deleteBtn(r_no,s_num);
		
			/** 글 삭제를 위한  Ajax 연동 처리 */
			function deleteBtn(r_no,s_num){
				if (confirm("선택하신 댓글을 삭제하시겠습니까?")) {
					$.ajax({
						//url : '/replies/' + b_num + '/' + r_num, 
						url : '/reviewList/' + r_no, 
						type : 'delete',   // method - get(조회)/post(입력)/put(수정)/delete(삭제) 존재         
						headers : {
							"X-HTTP-Method-Override" : "DELETE"
						},
						dataType : 'text',
						error: function(xhr, textStatus, errorThrown) { //실행시 오류가 발생하였을 경우
							alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
							//alert("시스템에 문제가 있어 잠시 후 다시 진행해 주세요.");
						},
						success : function(result) {
							console.log("result: " + result);
							if (result == 'SUCCESS') {
								alert("댓글 삭제가 완료되었습니다.");
							    listAll(s_num);
							}
						}
					});
				} else {
					formHide();
				}
			}
		
		});	
	</script>
	</head>
	<body>
	
				
	<h4> 꼭 읽어주세요(운영규정) </h4>
	<h5>	 
		게시판 운영 규정에 어긋난다고 판단되는 게시글은 사전 통보없이 블라인드 처리될 수 있습니다.<br/>
		특히 티켓 매매 및 양도의 글은 발견 즉시 임의 삭제되며 전화번호, 이메일 등의 개인정보는 악용될 우려가 있으므로 게시를 삼가 주시기 바랍니다.<br/>
		사전 경고에도 불구하고 불량 게시물을 계속적으로 게재한 게시자의 경우 Quicket 게시판 작성 권한이 제한됩니다.
	</h5>	

		<div id="replyContainer">
		
			<%-- 댓글 리스트 화면 --%>			
			<form id="replyForm" name="replyForm">
				<div class="panel panel-default">
					<table class="table">
						<tbody>
							<tr>
								<td class="col-md-1">제목</td>
								<td class="col-md-3 text-left">
									<input type="text" name="r_title" id="r_title"  class="form-control" >
								</td>
																
								<td class="col-md-4 btnArea">
									<button type="button" id="replyInsertBtn" class="btn btn-primary gap sendBtn">저장</button>
								</td>
							</tr>
							<tr>
								<td class="col-md-1">댓글내용</td>
								<td colspan="4" class="col-md-11 text-left">
									<textarea name="r_content" id="r_content" class="form-control" rows="3"></textarea>
								</td>
							</tr>
							
							<tr>
								<td class="col-md-1">포인트</td>
								<td colspan="4" class="col-md-11 text-left">
									<textarea name="r_point" id="r_point" class="form-control" rows="1"></textarea>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</form>

			
			
			<%-- 리스트 영역 --%>
			<div id="reviewList">
				<div id="item-template" class="panel panel-success">
					<div class="panel-heading">
						<h3 class="panel-title">
							<span class="name"></span>
							<span class="date"></span>
							<button type="button" id="updateBtn" data-btn="upBtn" class="btn btn-default gap">수정하기</button>
						<!-- 	<button type="button" data-btn="delBtn" class="btn btn-default gap">삭제하기</button>  -->
							<button type="button" id="delBtn" class="btn btn-default gap">삭제하기</button>
						</h3>						
					</div>
					<div class="panel-body"></div>
				</div>
			</div>

		</div>
	</body>
</html>						