<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"  %>
	
	<style type="text/css">
		#inqReplyList { margin-bottom: 20px; }
	</style>
	
	<script type="text/javascript" src="/resources/include/js/common.js"></script>
	<script type="text/javascript">
		$(function(){
			
			/* 문의글 제목 클릭하면 상세정보 및 답변 불러오기 */
			$(".goDetail").on("click", function(){
				/* 클릭한 글번호 가져오기 */
				const num = $(this).parents("tr").attr("data-num");
				
				/* 클릭한 리스트 색으로 표시 */
				$(".info").removeClass("info");
				$(this).parents("tr").addClass("info");
				
				/* 세부정보 + 답변 서버에서 가져와 보여주는 함수 */
				listAll(num);
				
			});
			
			/* 등록/수정 버튼 클릭시 데이터 받아다가 input 값 넣을 수 있게 이벤트 처리 후 수정 처리 */
			$(document).on("click","#updateFormBtn", function(){
				
				// 버튼 id 속성 변경
				$("#updateFormBtn").attr("id", "insertBtn");
				$("#insertBtn").text("입력"); 
				
				$("#delBtn").attr("id", "cancelBtn");
				$("#cancelBtn").text("취소"); 
				
				const i_num = $(".dataNum").attr("data-num");
				console.log(i_num);
				const i_r_num = $("#item-template .panel-title").attr("data-num");
				console.log(i_r_num);
				
				if(i_r_num != null){
					
					let updateFormUrl = "/inqReply/all/"+i_num;
					
					$.ajax({
						url : updateFormUrl,
						type : 'get',
						headers : {
							"Content-Type" : "application/json"
						},
						dataType: 'json',
						error : function(xhr, textStatus, errorThrown){
							alert("시스템에 문제가 있어 잠시 후 다시 진행해주세요.");
						},
						success : function(result){
							$(result).each(function(){
								let i_num = this.i_num;
								let i_r_num = this.i_r_num;
								let i_r_content = this.i_r_content;
								let i_r_update = this.i_r_update;
								
								i_r_content = i_r_content.replace(/(\r\n|\r|\n)/g, "<br />"); 
								
								console.log(i_num);
								
								// 테이블에 데이터 삽입
								$("#item-template .panel-body").html("<form id='insertForm'>"+
									"<input type='hidden' name='i_num' value=i_num/>"+
									"<textarea id='i_r_content' name='i_r_content' class='form-control' rows='10'>"+ 
									i_r_content + "</textarea></form>");
							});
						}
					});
					
					/* 답변 있는 상태에서 문의글 답변 수정 - 입력 버튼 클릭시 이벤트 처리 */
					$(document).on("click","#insertBtn", function(){
						
						console.log("등록/수정 버튼 클릭");
						
						/* js값이나 객체를 JSON 문자열로 변환 */
						let value = JSON.stringify({
							i_num : $(".dataNum").attr("data-num"),
							i_r_content : $("#i_r_content").val(),
						});
						
						let updateUrl = "/admin/inq/inqReplyUpdate";
						$.ajax({
							url : updateUrl,
							type : 'post',
							headers : {
								"Content-Type" : "application/json"
							},
							data : value,
							dataType: 'text',
							error : function(xhr, textStatus, errorThrown){
								// alert("시스템에 문제가 있어 잠시 후 다시 진행해주세요.");
								alert(textStatus + " (HTTP-"+ xhr.status + " / " +errorThrown + ")");
							},
							beforeSend: function(){
								if (!chkData("#i_r_content","내용을")) return false;
							}, 
							success : function(result){
								console.log("result: " +result);
								
								if(result=="SUCCESS"){
									alert("문의글 답변 수정이 완료되었습니다.");
									
								} else {
									alert("시스템에 문제가 있어 잠시 후 다시 진행해주세요.");
								}
								listAll(i_num);
							}
						}); 
					});				
					
					/* 취소 버튼 클릭시 이벤트 처리 */
					$(document).on("click","#cancelBtn", function(){
						$("#i_r_content").val("");
					});

				} else { // 답변이 아직 달리지 않은 문의글에 등록
					
					// 테이블에 입력할 textarea 삽입
					$("#item-template .panel-body").html("<form id='insertForm'>"+
						"<input type='hidden' name='i_num' value=i_num/>"+
						"<textarea id='i_r_content' name='i_r_content' class='form-control' rows='10'></textarea></form>");
					
					/* 답변 없는 상태에서 문의글 답변 등록 - 입력 버튼 클릭시 이벤트 처리 */
					$(document).on("click","#insertBtn", function(){
						console.log("등록/수정 버튼 클릭");
						
						/* js값이나 객체를 JSON 문자열로 변환 */
						let value = JSON.stringify({
							i_num : $(".dataNum").attr("data-num"),
							i_r_content : $("#i_r_content").val(),
						});
						
						let updateUrl = "/admin/inq/inqReplyInsert";
						$.ajax({
							url : updateUrl,
							type : 'post',
							headers : {
								"Content-Type" : "application/json"
							},
							data : value,
							dataType: 'text',
							error : function(xhr, textStatus, errorThrown){
								// alert("시스템에 문제가 있어 잠시 후 다시 진행해주세요.");
								alert(textStatus + " (HTTP-"+ xhr.status + " / " +errorThrown + ")");
							},
							beforeSend: function(){
								if (!chkData("#i_r_content","내용을")) return false;
							}, 
							success : function(result){
								console.log("result: " +result);
								
								if(result=="SUCCESS"){
									alert("문의글 답변 등록이 완료되었습니다.");

								} else {
									alert("시스템에 문제가 있어 잠시 후 다시 진행해주세요.");
								}
								/* inqList reload 해서 기존에 보던 페이지 보려면 어떻게 해야 할까? -> 답변 수정/등록 했을 때 리스트에서 답변완료 출력하려면? */
								// listAll(i_num);
								window.location.replace("/admin/inq/inqList?pageNum="+$('#pageNum').val()+"&amount="+$('#amount').val());
							}
						}); 
					});				
					
					/* 취소 버튼 클릭시 이벤트 처리 */
					$(document).on("click","#cancelBtn", function(){
						$("#i_r_content").val("");
					});
				}
			});  
			
			/* 답변 삭제 버튼 클릭시 이벤트 처리 */
			$(document).on("click","#delBtn", function(){
				/* 클릭한 글번호 가져오기 */
				const i_num = $(".dataNum").attr("data-num");
				const i_r_num = $("#item-template .panel-title").attr("data-num");
				
				if(confirm("선택하신 댓글 삭제하시겠습니까?")){
					$.ajax({
						url : '/admin/inq/' + i_r_num,
						type : 'delete',
						headers : {
							"X-HTTP-Method-Override" : "DELETE"
						},
						dataType : 'text',
						error : function(xhr, textStatus, errorThrown){
							alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
						},
						success : function(result){
							console.log("result: "+ result);
							if(result == "SUCCESS"){
								alert("댓글 삭제가 완료되었습니다.");
								listAll(i_num);
							}
						}
					});
				} else { // 삭제하시겠습니까? 했을 때 취소 누름
					listReply(i_num);
				}
			});			
			
		}); // 최상위 $ 종료
		
		/* 서버로부터 상세정보 + 답변 불러와 보여주는 함수 */
		function listAll(num){
			
			// 답변(textarea 태그, input값) 초기화
			$("#item-template .panel-title").empty();
			$("#item-template .panel-body").empty();
			
			/* 상세정보 불러오기 */
			let detailUrl = "/admin/inq/adminInqDetail/"+num; 
			$.ajax({
				url : detailUrl,
				type : 'post',
				headers : {
					"Content-Type" : "application/json"
				},
				dataType: 'json',
				error : function(xhr, textStatus, errorThrown){
					alert("시스템에 문제가 있어 잠시 후 다시 진행해주세요.");
				},
				success : function(result){
					$(result).each(function(){
						let i_num = this.i_num;
						let u_id = this.u_id;
						let i_category = this.i_category;
						let i_cate_detail = this.i_cate_detail;
						
						let i_reply = this.i_reply;
						if(i_reply === 0) { i_reply = '답변 대기중'; }
						if(i_reply === 1) { i_reply = '답변완료'; } 
						
						let i_title = this.i_title;
						let i_content = this.i_content;
						let i_regidate = this.i_regidate;
						let i_update = this.i_update;
						let ti_num = this.ti_num;
						
						console.log("i_num: " +i_num);
						console.log("i_content: " +i_content);
						i_content = i_content.replace(/(\r\n|\r|\n)/g, "<br />"); 
						// 댓글내용에서 enter를 입력하면 \n\r or \r or \n으로 처리
						
						// 테이블에 데이터 삽입
						$(".dataNum").attr("data-num", i_num);
						$("#detail_i_num").html(i_num);
						
						// 예매번호 초기화 및 대입
						$("#ti_num").html("");
						if(ti_num != 0) { $("#ti_num").html(ti_num); }
						
						$("#u_id").html(u_id);
						$("#i_category").html(i_category + " > " +i_cate_detail);
						$("#i_regidate").html(i_regidate);
						$("#i_title").html(i_title);
						$("#i_reply").html(i_reply);
						$("#i_content").html(i_content);
					});
				}
			});
			
			listReply(num);
		}
		
		/* 서버로부터 답변 불러와 보여주는 함수 */
		function listReply(num){
			// 버튼 id 속성 변경
			$("#insertBtn").attr("id", "updateFormBtn");
			$("#updateFormBtn").text("등록/수정"); 
			
			$("#cancelBtn").attr("id", "delBtn");
			$("#delBtn").text("삭제"); 
			
			/* 답변 불러오기 */
			let replyUrl = "/admin/inq/inqReply/"+num;
			$.ajax({
				url : replyUrl,
				type : 'post',
				headers : {
					"Content-Type" : "application/json"
				},
				dataType: 'json',
				error : function(xhr, textStatus, errorThrown){
					alert("시스템에 문제가 있어 잠시 후 다시 진행해주세요.");
				},
				beforesend: function(){
					// 답변(textarea 태그, input값) 초기화
					$("#item-template .panel-title").remove();
					$("#item-template .panel-body").remove();
				},
				success : function(result){
					$(result).each(function(){
						let i_r_num = this.i_r_num;
						let i_num = this.i_num;
						let i_r_content = this.i_r_content;
						let i_r_update = this.i_r_update;
						
						console.log("i_num: " + i_num);
						i_r_content = i_r_content.replace(/(\r\n|\r|\n)/g, "<br />"); 
						
						// 테이블에 데이터 삽입
						$("#item-template .panel-title").attr("data-num", i_r_num);
						$("#item-template .panel-title").html(i_r_update);
						$("#item-template .panel-body").html(i_r_content);
					});
				}
			});
		} 
	</script>
	</head>
	<body>
		<div class="contentContainer container">
			<div>
				<h3>1:1 문의 상세정보</h3>
			</div>
			
			<%-- ================= 리스트 ================= --%>
			<div class="contentTB text-center">
				<table class="table table-bordered">
					<tr class="dataNum" data-num="">
						<td class="col-md-3"></td>
						<td class="col-md-3"></td>
						<td class="col-md-3">글번호</td>
						<td class="col-md-3" id="detail_i_num"></td>
					</tr>
					<tr>	
						<td class="col-md-3">예매번호</td>
						<td class="col-md-3" id="ti_num"></td>
						<td class="col-md-3">작성자</td>
						<td class="col-md-3" id="u_id"></td>
					</tr>
					<tr>
						<td class="col-md-3">카테고리</td>
						<td class="col-md-3" id="i_category"></td>
						<td class="col-md-3">작성일</td>
						<td class="col-md-3" id="i_regidate"></td>
					</tr>
					<tr>
						<td class="col-md-3">제목</td>
						<td class="col-md-3 text-left" id="i_title"></td>
						<td class="col-md-3">답변현황</td>
						<td class="col-md-3" id="i_reply"></td>
					</tr>
					<tr>
						<td colspan="4" class="col-md-12 text-left" id="i_content"></td>
					</tr>
				</table>
			</div>
			
			<%-- ================= 답변 시작 ================= --%>		
			<div id="inqReplyList">
				<strong>답변</strong>
				<div id="item-template" class="bg-info panel-heading panel-title">
					<div class="panel-title text-right date"></div>
					<div class="panel-body"></div>
				</div>			
			</div>
			
			<%-- ================= 답변 등록/삭제 버튼 시작 ================= --%>
			<div class="contentBtn text-right">
				<button type="button" id="updateFormBtn" class="btn btn-primary">등록/수정</button>
				<button type="button" id="delBtn" class="btn btn-primary">삭제</button>
			</div>
			
		</div>
	</body>
</html>