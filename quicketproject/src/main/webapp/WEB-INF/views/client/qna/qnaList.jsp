<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

<style type="text/css">
	div.qnaNotice{height: 150px; background-color: #EAEAEA; margin-top: 10px;}
	div.countArea{margin-top: 30px;}
	div.insertBtnArea{margin-top: 15px; margin-botton:0px;}
	#qna-template{display: none;}

</style>

<script type="text/javascript" src="/resources/include/js/jquery-1.12.4.min.js"></script>

<script type = "text/javascript">
		$(function(){
			
			/* 기본 글 목록 불러오기 */
			let s_num = ${detailData.s_num};
			console.log("s_num : "+s_num);
			qnaListAll(s_num); 
			
			
			/* 글쓰기 버튼 클릭시 입력폼 호출 */
			$("#q_insertBtn").click(function(){
				let id = "${userLogin.u_id}";
				
				if(id != ""){
					location.href = "/qna/qnaWriteForm?s_num="+s_num; 
					
				} else{
					alert("로그인 후 서비스를 이용하실 수 있습니다.");
					location.href = "/user/login"; 
				} 
			}); 
			
			/* 제목 클릭시 상세 페이지 이동을 위한 처리 이벤트 */
			$(document).on("click", ".title", function(){
				let q_no = $(this).parents("tr").attr("data-num");
				
				$("#q_no").val(q_no);
				$("#s_number").val(s_num);
				console.log("글번호 : "+q_no);
				console.log("공연번호 : "+$("#s_number").val());
				
				$("#q_detailForm").attr({
					"method":"get",
					"action":"/qna/qnaDetail"
				});
				$("#q_detailForm").submit();
			});
			
			
			$(".paginate_button a").click(function(e){
				e.preventDefault();
				$("#page_form").find("input[name='pageNum']").val($(this).attr("href"));
				goPage();
			}); 
			

		}); // $함수 종료문	
		
		function qnaListAll(s_num){
			//$(".qna").detach();	//선택한 요소를 DOM트리에서 삭제
			
			let url = "/qna/all/"+ s_num;
			$.getJSON(url, function(data){
				$(data).each(function(){
					
					let q_no = this.q_no;
					let q_title = this.q_title;
					let u_id = this.u_id;
					let q_content = this.q_content;
					let q_regdate = this.q_regdate;
					q_content = q_content.replace(/(\r\n|\r|\n)/g, "<br />");
					
					qnaTemplate(q_no, q_title, u_id, q_content, q_regdate);

					console.log(u_id);
				});
			}).fail(function(){
				 alert("덧글 목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해 주세요.");
			});
		}
			
		
		/* 새로운 글을 화면에 추가하기 위한 함수 */
		function qnaTemplate(q_no, q_title, u_id, q_content, q_regdate){
			
			let id = "${userLogin.u_id}";
			console.log(u_id);
			
			let $div = $('#qnaList');
			
			
			let $element = $('#qna-template').clone().removeAttr('id');
			$element.attr("data-num", q_no);
			//$element.addClass("qnaReply");
			$element.find('.boardNum').html(q_no);
			$element.find('.title').html(q_title);
			$element.find('.id').html(u_id);
			$element.find('.date').html(q_regdate);
			
			<%-- 로그인한 id에 따라 출력되는 버튼 제어 필요 없으므로 주석처리
			if(id == u_id){
				$element.find('.panel-heading > .panel-title > button').show();
			} else {
				$element.find('.panel-heading > .panel-title > button').hide();
			}
				$element.find('.panel-body').html(ex_content); --%>
			
			$div.append($element);
			
		}
		
		
		function goPage(){
			$("#page_form").attr({
				"method":"get",
				"action":"/qna/qnaList"
			});
			$("#page_form").submit();
		}	
	</script>

	</head>
	<body>

	<div class="contentContainer container">

		<form id="q_detailForm">
			<input type="hidden" id="q_no" name="q_no"/>
			<input type="hidden" id="s_number" name="s_num"/>
		</form>
		
		<form id= "page_form" name="page_form">
			<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum}">
			<input type="hidden" name="amount" id="amount" value="${pageMaker.cvo.amount }">
		</form>
	
		<%-- 운영규정 안내 --%>
			<div class="expectNotice">
				<div id="noticeHeader">
				<h4>꼭 읽어주세요(운영규정)</h4>
				</div>
				<div id="noticeText">
				게시판 운영 규정에 어긋난다고 판단되는 게시글은 사전 통보없이 블라인드 처리될 수 있습니다.<br/>
				특히 티켓 매매 및 양도의 글은 발견 즉시 임의 삭제되며 전화번호, 이메일 등의 개인정보는 악용될 우려가 있으므로 게시를 삼가 주시기 바랍니다.<br/>
				사전 경고에도 불구하고 불량 게시물을 계속적으로 게재한 게시자의 경우 QUICKet 게시판 작성 권한이 제한됩니다. <br/>
				</div>
			</div>
			
			<%-- 문의글 개수 출력 영역
				<div class="topArea">
					<div class="countArea">총 ${count}개의 문의글이 등록되었습니다.</div>
				</div>   --%>
			
			
			<!--  등록한 테이블이 출력되는 영역 	-->
				<div>
					<table class="table table-hover table-bordered">
						<tbody class="qna-tbody" id = "qnaList">
							<tr id="qna-template" class="temp">
								<td class="boardNum"></td>
								<td class="title"></td>
								<td class="id"></td>
								<td class="date"></td>
							</tr>
						</tbody>
					</table>
				</div>
			
			<div class="insertBtnArea text-right"> <input type="button" value="글쓰기" id="q_insertBtn" class= "btn btn-primary"></div>
		
			
			
		
			
			<%-- 페이징 --%>
			<div class="text-center">
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">
						<li class="paginate_button previous">
							<a href="${pageMaker.startPage - 1 }">Previous</a>
						</li>
					</c:if>	
					<c:forEach var="num" begin="${pageMaker.startPage}"
										 end = "${pageMaker.endPage}">
						<li class="paginate_button ${pageMaker.cvo.pageNum == num ? 'active':''}">  
						<!-- pageMaker의 cvo의 pageNum이 반복문의 num과 일치하는가? true : 'active', false: ' ' -->
							<a href="${num}">${num}</a>
						</li>
					</c:forEach>
					<c:if test="${pageMaker.next}">
						<li class="paginate_button next">
							<a href = "${pageMaker.endPage + 1 }">Next</a>
						</li>		
					</c:if>
				</ul>
			</div>
		</div>	
 	</body>
		
</html>
