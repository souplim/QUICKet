<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"  %>

	<style>
		.contentBtn {margin-bottom: 10px;}
		.select {margin-bottom: 10px;}
		#confirmFaq {
			width: 100%;
			height: 40px;
			border: 1px solid lightgray;
			cursor: pointer;
			padding: 10px 0 0 10px;
		}
		
		#faqBox {
			margin-bottom: 10px;
		}
		
		#faqBoxList {
			display: none;
			border: 1px solid lightgray;
			height: auto;
		}
		#faqBoxList dt {
			cursor: pointer;
			padding: 10px;
			border-bottom: 1px solid lightgray;
		}
		#faqBoxList dd {
			cursor: pointer;
			padding: 10px;
		}
		#faqBoxList dd:not(:last-of-type){
			border-bottom: 1px solid lightgray;
		}
		
		.faqContents {display:none;}
		
		#inqContent {
			height: auto;
			padding-top: 10px;
			margin-bottom: 10px;
			border: 1px solid lightgray;
		}
		
		
	</style>
	<script type="text/javascript">
		$(function(){
			/* 1대1문의하기 버튼 클릭시 처리 이벤트 */
			$("#listBtn").on("click", function(){
				location.href="/inq/inqList";
			});
			
			/* 유형 선택시 세부유형 option항목 처리 이벤트 */
			$("#i_category").on("change", function(){
				const member = ["로그인","아이디/패스워드","회원가입","회원탈퇴"];
				const show = ["예매","취소/변경","배송","결제","이벤트","건의사항","기타"];
				const etc = ["건의사항","기타"];
				
				let category = $("#i_category").val();
				
				let detail;
				if(category == "member") detail = member;
				else if(category == "show") detail = show;
				else if(category == "etc") detail = etc;
				
				let target = $("#i_cate_detail");
				target.empty(); /* 기존에 들어가 있는 옵션 삭제 */
				
				for(x in detail)
					target.append("<option>"+detail[x]+"</option>")
			});
			
			/* faqList 클릭하면 faq리스트 slideDown 처리 이벤트 */
			$("#confirmFaq").on("click", function(){
				if($("#faqBoxList").css("display") == "none"){ // 클릭하는 요소 열려있지 않으면
					$(this).next("div").slideDown();
				} else {
					$(this).next("div").slideUp();
				}
			});
			
			/* faq리스트 제목 클릭하면 내용 slideDown 처리 이벤트 */
			$(".faqTitle").on("click", function(){
				if($(this).next("dd").css("display") == "none"){ // 클릭하는 요소 열려있지 않으면
					$(this).next("dd").slideDown();
				} else {
					$(this).next("dd").slideUp();
				}
			});
		});
	</script>
	</head>
	<body>
		<div class="contentContainer container">
			<div>
				<h1>1:1 문의하기</h1>
				<p>고객님이 문의하신 질문과 답변내용을 확인하실 수 있습니다.</p>
			</div>
			
			<%-- ================= 1대1문의내역 버튼 시작 ================= --%>
			<div class="contentBtn text-right">
				<button type="button" id="listBtn" class="btn btn-primary">1대1 문의내역</button>
			</div>
			
			<%-- ================= 폼 시작 ================= --%>
			<form class="form-horiozontal" id="insertForm">
				<div class="select row">
					<div class="form-group col-md-3">
						<label for="i_category" class="sr-only">유형</label>
						<select class="form-control" id="i_category" name="i_category">
							<option>선택</option>
							<option value="member">회원정보</option>
							<option value="show">공연</option>
							<option value="etc">그 외</option>
						</select>
					</div>
					
					<div class="form-group col-md-3">
						<label for="i_cate_detail" class="sr-only">세부유형</label>
						<select class="form-control" id="i_cate_detail" name="i_cate_detail">
							<option>선택</option>
						</select>
					</div>
					
					<div class="form-group col-md-6">
						<label class="sr-only" for="i_cate_detail">예매번호</label>
						<select class="form-control" id="ti_num" name="ti_num">
							<option>예매번호</option>
						</select>
					</div>
				</div>
				
				<div id="faqBox" >
					<div id="confirmFaq">문의전, 연관 FAQ를 확인해보세요!</div>
					<div id="faqBoxList">
						<dl>
							<dt class="faqTitle">test</dt>
							<dd class="faqContents">test</dd>
							<dt class="faqTitle">test2</dt>
							<dd class="faqContents">test2</dd>
						</dl>
					</div>
				</div>
				
				<div id="inqContent" class="form-horizontal">
					<div class="form-group">
						<label for="i_title" class="col-md-2 control-label">제목</label>
						<div class="col-md-9">
							<input type="text" id="i_title" name="i_title" class="form-control"/>
						</div>
					</div>
					<div class="form-group">
						<label for="i_content" class="col-md-2 control-label">문의내용</label>
						<div class="col-md-9">
							<textarea id="i_content" name="i_content" class="form-control" rows="10"></textarea>
						</div>
					</div>
					
					<div class="form-group">
						<div class=col-md-2></div>
						<div class=col-md-9>
							문의 내용을 구체적으로 작성해 주세요. 정확하고 빠른 답변에 도움이 됩니다.<br/>
 							주민등록번호를 포함한 고객님의 소중한 개인정보는 사이트에 노출되지 않으나
							꼭 필요한 경우가 아닌 경우 기재를 삼가시길 바랍니다.
						</div>
					</div>
				</div>
				
				<%-- ================= 1대1문의내역 버튼 시작 ================= --%>
				<div class="text-right">
					<button type="button" class="btn btn-primary" id="insertBtn">등록</button>
					<button type="button" class="btn btn-primary" id="cancelBtn">취소</button>
				</div>
			</form>
			
		</div>
	</body>
</html>