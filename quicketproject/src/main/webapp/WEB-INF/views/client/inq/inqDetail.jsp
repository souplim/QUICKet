<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"  %>

	<script type="text/javascript">
		$(function(){
			/* 1대1문의하기 버튼 클릭시 처리 이벤트 */
			$("#listBtn").on("click", function(){
				location.href="/inq/inqList";
			});
			
		});
	</script>
	</head>
	<body>
		<div class="contentContainer container">
			<div>
				<h1>1:1 문의내역</h1>
				<p>고객님이 문의하신 질문과 답변내용을 확인하실 수 있습니다.</p>
			</div>
			
			<%-- ================= 리스트 시작 ================= --%>
			<div class="contentTB text-center">
				<table class="table table-bordered">
					<%-- <tr>
						<td class="col-md-3">예매번호</td>
						<td class="col-md-3 text-left">${inqVO.ti_num}</td>
						<td class="col-md-3">작성자</td>
						<td class="col-md-3 text-left">${sessionScope.세션객체명.u_id}</td>
					</tr>
					<tr>
						<td class="col-md-3">카테고리</td>
						<td colspan="4" class="col-md-8 text-left">${inqVO.i_category} > ${inqVO.i_cate_detail}</td>
						<td class="col-md-3">작성일</td>
						<td colspan="2" class="col-md-8 text-left">${inqVO.i_regidate}</td>
					</tr>
					<tr>
						<td class="col-md-3">제목</td>
						<td colspan="4" class="col-md-8 text-left">${inqVO.i_title}</td>
						<td class="col-md-3">답변현황</td>
						<td colspan="2" class="col-md-8 text-left">${inqVO.i_content}</td>
					</tr>
					<tr>
						<td colspan="6" class="col-md-8 text-left">${inqVO.i_content}</td>
					</tr> --%>
				</table>
			</div>
			
			<%-- ================= 답변 시작 ================= --%>
			<div id="inqReply" class="bg-info">
				답변<%-- ${inqReplyVO.i_r_update} ${inqReplyVO.i_r_content}--%>
			</div>
			
			
			<%-- ================= 1대1문의하기 버튼 시작 ================= --%>
			<div class="contentBtn text-right">
				<button type="button" id="updateFormBtn" class="btn btn-primary">수정</button>
				<button type="button" id="listBtn" class="btn btn-primary">목록</button>
			</div>
			
		</div>
	</body>
</html>