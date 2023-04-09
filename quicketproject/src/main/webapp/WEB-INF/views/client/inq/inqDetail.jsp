<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"  %>
	
	<style type="text/css">
		#inqReplyList { margin-bottom: 20px; }
		.btn-blue {
			background-color: dodgerblue;
			color: #fff;
		}
		#contentDiv { min-height: 200px; }
	</style>
	
	<script type="text/javascript" src="/resources/include/js/common.js"></script>
	<script type="text/javascript">
		$(function(){
			
			/* 기존 답변 불러오기 */
			let i_num = ${inqDetail.i_num};
			console.log(i_num);
			listAll(i_num);
			
			/* 목록 버튼 클릭시 처리 이벤트 */
			$("#listBtn").on("click", function(){
				location.href="/inq/inqList";
			});
			
			/* 수정 버튼 클릭시 readonly제거, 버튼이름 변경 이벤트 */
			$(document).on("click", "#updateFormBtn", function(){
				let i_num = $(this).attr("data-num");
				
				$("#titleTd").html("<input type='text' id='i_title' name='i_title' class='form-control' value='${inqDetail.i_title}'/>");
				$("#contentTd").html("<textarea id='i_content' name='i_content' class='form-control' rows='10'>${inqDetail.i_content}</textarea>");
				
				/* 등록버튼 이름, 아이디 변경 -> insertBtn과 같은 버튼이라 등록까지 한번에 클릭으로 인식하는 문제점 */
				/* $("#updateFormBtn").attr("id", "insertBtn");
				$("#insertBtn").html("등록"); */
				
				/* 수정버튼 이름, 아이디 변경 */
				$("#listBtn").attr("id", "cancelBtn");
				$("#cancelBtn").html("취소");
				
				/* 내용에 커서 자동으로 들어가게 */
				$("#i_content").focus();
				
				/* 등록버튼 새로 만들기 */
				$("#updateFormBtn").detach();
				let insertButton = $("<button type='button' class='btn btn-blue' id='insertBtn'>");
				insertButton.html("등록");
				$("#cancelBtn").before(insertButton);
			});
			
		
			/* 등록 버튼 클릭시 이벤트 처리 */
			$(document).on("click","#insertBtn", function(){
				let insertUrl = "/inq/inqUpdate";
				
				/* js값이나 객체를 JSON 문자열로 변환 */
				let value = JSON.stringify({
					i_num : $(".dataNum").attr("data-num"),
					i_title : $("#i_title").val(),
					i_content : $("#i_content").val()
				});
				
				$.ajax({
					url : insertUrl,
					type : 'post',
					headers : {
						"Content-Type" : "application/json"
					},
					data : value,
					dataType: 'text',
					error : function(xhr, textStatus, errorThrown){
						alert("시스템에 문제가 있어 잠시 후 다시 진행해주세요.");
					},
					beforeSend: function(){
						if (!chkData("#i_title","제목을")) return false;
						else if (!chkData("#i_content","내용을")) return false;
					}, 
					success : function(result){
						console.log("result: " +result);
						
						if(result="SUCCESS"){
							alert("문의글 수정이 완료되었습니다.");
							
							/* 등록버튼 이름, 아이디 변경 */
							$("#insertBtn").attr("id", "updateFormBtn");
							$("#updateFormBtn").text("수정"); 
							
							/* 수정버튼 이름, 아이디 변경 */
							$("#cancelBtn").attr("id", "listBtn");
							$("#listBtn").text("목록"); 
							
							let i_num = $(".dataNum").attr("data-num");
							location.href="/inq/inqDetail?i_num="+i_num;
							
						} else {
							alert("시스템에 문제가 있어 잠시 후 다시 진행해주세요.");
						}
						
					}
				});
			}); 
			
		}); // 최상위 $ 종료
		
		/* 댓글 목록 보여주는 함수 - 서버로부터 리스트 받아오기 위한 요청 함수 */
		function listAll(i_num){
			$(".reply").detach(); // detach(): 선택한 요소를 DOM 트리에서 삭제(불러올 때마다 클래스 추가하므로 중복 출력 방지)
			
			let url = "/inqReply/all/"+i_num; 
			
			$.getJSON(url, function(data){ // data = [{r_num:1, r_name:"홍길동"...},{...}]
				$(data).each(function(){
					let i_r_num = this.i_r_num;
					let i_r_content = this.i_r_content;
					let i_r_update = this.i_r_update;
					i_r_content = i_r_content.replace(/(\r\n|\r|\n)/g, "<br />"); 
					// 댓글내용에서 enter를 입력하면 \n\r or \r or \n으로 처리
					template(i_r_num, i_r_content, i_r_update);
				});
			}).fail(function(){
				alert("덧글 목록을 불러오는 데 실패하였습니다. 잠시 후에 다시 시도해주세요.");
			});
		}
		
		/* 새로운 글을 화면에 보여주기(추가하기) 위한 함수 */
		function template(r_i_num, i_r_content, i_r_update){
			let $div = $("#inqReplyList"); // => <div id="reviewList">
			
			let $element = $("#item-template").clone().removeAttr('id'); // id 속성 중복될 수 없기 때문에 삭제 => <div> 
			$element.attr("data-num", r_i_num); // <div data-num="1" class="panel panel-success reply">
// 			$element.addClass("reply");
			$element.find('.panel-title > .date').html(i_r_update);
			$element.find('.panel-body').html(i_r_content);
			
			$div.append($element);
		}
	</script>
	</head>
	<body>
		<div class="contentContainer container">
			
			<div>
				<h1>1:1 문의내역</h1>
				<p>고객님이 문의하신 질문과 답변내용을 확인하실 수 있습니다.</p>
			</div>
			
			<%-- ================= 리스트 ================= --%>
			<div class="contentTB text-center">
				<table class="table table-bordered">
					<tr class="dataNum" data-num="${inqDetail.i_num}">
						<td class="col-md-3"></td>
						<td class="col-md-3"></td>
						<td class="col-md-3">작성자</td>
						<td class="col-md-3">${inqDetail.u_name}</td>
					</tr>
					<tr>
						<td class="col-md-3">카테고리</td>
						<td class="col-md-3">${inqDetail.i_category} > ${inqDetail.i_cate_detail}</td>
						<td class="col-md-3">작성일</td>
						<td class="col-md-3">${inqDetail.i_regidate}</td>
					</tr>
					<tr>
						<td class="col-md-3">예매번호</td>
						<td class="col-md-3">
							<c:if test="${inqDetail.pay_num!=0}">
								${inqDetail.pay_num}
							</c:if>
						</td>
						<td class="col-md-3" style="vertical-align:middle">답변현황</td>
						<td class="col-md-3" style="vertical-align:middle">
							<c:if test="${inqDetail.i_reply==0}">답변 대기중</c:if>
							<c:if test="${inqDetail.i_reply==1}">답변 완료</c:if>
						</td>
					</tr>
					<tr>
						<td class="col-md-3" style="vertical-align:middle">제목</td>
						<td colspan="3" class="col-md-9 text-left" id="titleTd">${inqDetail.i_title}</td>
					</tr>
					<tr>
						<td colspan="4" class="col-md-12 text-left" id="contentTd">
							<div id="contentDiv">
								${inqDetail.i_content}
							</div>
						</td>
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
			
			<%-- ================= 1대1문의하기 버튼 시작 ================= --%>
			<div class="contentBtn text-right">
				<c:if test="${inqDetail.i_reply==0}">
					<button type="button" id="updateFormBtn" class="btn btn-blue">수정</button>
				</c:if>
				<button type="button" id="listBtn" class="btn btn-blue">목록</button>
			</div>
			
		</div>
	</body>
</html>