<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"  %>

	<style>
		.contentBtn {margin-bottom: 10px;}
		.select {margin-bottom: 10px;}
		#confirmFaq {
			width: 100%;
			height: 40px;
			display: flex;
			border: 1px solid lightgray;
			cursor: pointer;
			padding: 10px 0 0 10px;
		}
		#faqText { width: 97%; } 
		#faqBox {
			margin-bottom: 10px;
		}
		
		#faqBoxList {
			display: none;
			/* border: 1px solid lightgray; */
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
	
	<script type="text/javascript" src="/resources/include/js/common.js"></script>
	<script type="text/javascript">
		$(function(){
			/* 1대1문의하기 버튼 클릭시 처리 이벤트 */
			$("#listBtn").on("click", function(){
				location.href="/inq/inqList";
			});
			
			/* 유형 선택시 세부유형 option 항목 처리 이벤트 */
			$("#i_category").on("change", function(){
				const opt = ["선택"];
				const 회원정보 = ["로그인","아이디/패스워드","회원가입","회원탈퇴"];
				const 공연 = ["예매","취소/변경","배송","결제","이벤트","건의사항","기타"];
				const 그외 = ["건의사항","기타"];
				
				let category = $("#i_category").val();
				
				let detail;
				if(category == "회원정보") detail = 회원정보;
				else if(category == "공연") detail = 공연;
				else if(category == "그 외") detail = 그외;
				else if(category == "opt") detail = opt;
				
				let target = $("#i_cate_detail");
				target.empty(); /* 기존에 들어가 있는 옵션 삭제 */
				
				for(x in detail)
					target.append("<option>"+detail[x]+"</option>")
			});
			
			/* 예매번호 선택시 option 항목 처리 이벤트 */
			/* $("#ti_num").on("change", function(){
				let ti_num = $("#i_category").val();
			}); */
			
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
			
			
			/* 글자수 제한 */
			$("#i_content").on("input", function(){
				let length = $(this).val().length;
				
				if(length<1000)
					$("#counter").css("color","black");
				else
					$("#counter").css("color","red");
				
				const str = $(this).val();
				$(this).val(str.substr(0,1000));
				
				$("#counter").text($(this).val().length);
			});
			
			/* 등록버튼 클릭시 처리 이벤트 */
			$("#insertBtn").on("click", function(){
				if($("#i_category").val()=="opt"){
					alert("유형을 선택해주세요.");
					return false;
				} else if($("#i_cate_detail").val()=="opt"){
					alert("세부유형을 선택해주세요.");
					return false;
				}
				// alert("취소/변경 및 배송 문의는 예약번호를 조회해주셔야 합니다.");
				else if (!chkData("#i_title","제목을")) return false;
				else if (!chkData("#i_content","내용을")) return false;
				else {
					$("#insertForm").attr({
						"method" : "post",
						"action" : "/inq/inqInsert"
					});
					$("#insertForm").submit();
				}
			});
			
			/* 취소버튼 클릭시 처리 이벤트 */
			$("#cancelBtn").on("click", function(){
				const opt = "선택";
				$("#i_category").val("opt").prop("selected", true);
				
				//$("#i_cate_detail").val("opt").prop("selected", true);
				let target = $("#i_cate_detail");
				target.empty(); 
				target.append("<option>선택</option>");
				
				$("#ti_num").val("ticketNum").prop("selected", true);
				$("#i_title").val("");
				$("#i_content").val("");
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
					<div class="col-md-1"><label for="i_category">유형</label></div>  
					<div class="form-group col-md-2">
						<select class="form-control" id="i_category" name="i_category">
							<option value="opt">선택</option>
							<option value="회원정보">회원정보</option>
							<option value="공연">공연</option>
							<option value="그 외">그 외</option>
						</select>
					</div>
					
					<div class="col-md-1"><label for="i_cate_detail">세부유형</label></div>
					<div class="form-group col-md-2">
						<select class="form-control" id="i_cate_detail" name="i_cate_detail">
							<option value="opt">선택</option>
						</select>
					</div>
					
					<div class="col-md-1"><label for="ti_num">예매번호</label></div>
					<div class="form-group col-md-5">
						<select class="form-control" name="ti_num" id="ti_num">
							<option value="ticketNum">선택</option>
							<c:if test="${not empty ticketLists}">
								<c:forEach var="ticket" items="${ticketLists}" varStatus="status">
									<option value="${ticket.ti_num}">
										${ticket.ti_num}&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
										${ticket.s_name}&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
										${ticket.seat_date}
									</option>
								</c:forEach>
							</c:if> 
						</select>
					</div>
					
				</div>
				
				<div id="faqBox" >
					<div id="confirmFaq" class="bg-info">
						<div id="faqText">문의전, 연관 FAQ를 확인해보세요!</div>
						<div class="glyphicon glyphicon-chevron-down text-right" aria-hidden="true"></div>
					</div>
					
					<div id="faqBoxList">
						<!-- <dl>
							<dt class="faqTitle">test</dt>
							<dd class="faqContents">test</dd>
							<dt class="faqTitle">test2</dt>
							<dd class="faqContents">test2</dd>
						</dl> -->
						
						<!-- 부트스트랩 아코디언 -->
						<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
						  <div class="panel panel-default">
						    <div class="panel-heading" role="tab" id="headingOne">
						      <h4 class="panel-title">
						        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
						          전화로 회원가입/탈퇴/정보 수정이 가능한가요?
						        </a>
						      </h4>
						    </div>
						    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
						      <div class="panel-body">
						      	회원가입 및 탈퇴, 정보수정은 인터파크 홈페이지에서 고객님께서 모두 하실 수 있습니다.
						      </div>
						    </div>
						  </div>
						  <div class="panel panel-default">
						    <div class="panel-heading" role="tab" id="headingTwo">
						      <h4 class="panel-title">
						        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
						          이메일 인증을 통해 가입 후 다른 이메일로 변경은 어떻게 진행 해야 하나요?
						        </a>
						      </h4>
						    </div>
						    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
						      <div class="panel-body">
						      	이메일 변경은 고객님께서 직접 홈페이지 로그인 후 상단의 [회원정보]
								또는 [마이페이지 > 회원정보 > 회원정보조회/수정] 에서 정보를 변경하실 수 있습니다.
								또한 모바일 페이지의 [회원정보수정] 메뉴를 통해서도 가능합니다.
						      </div>
						    </div>
						  </div>
						  <div class="panel panel-default">
						    <div class="panel-heading" role="tab" id="headingThree">
						      <h4 class="panel-title">
						        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
						          이메일 명의자와 가입자의 명의자가 맞지 않더라도 인증이 가능한가요?
						        </a>
						      </h4>
						    </div>
						    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
						      <div class="panel-body">
						      	네 맞습니다. 이메일 계정에 등록 된 정보와 달라도 인증은 가능합니다. 
								이메일 등록 정보와 회원정보간의 일치 여부를 확인하는 것은 불가능합니다. 
								단, 상품 구매 또는 결제 수단 이용 시 제 3자 무단 사용을 방지하기 위해 추가적인 본인인증을 실시하며, 
								내국인은  "휴대폰인증 또는 I-PIN 인증" , 외국인은 "외국인 등록번호" 인증 후 결제가 가능합니다. 
						      </div>
						    </div>
						  </div>
						</div>
						
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
							<p class="text-right"><span id="counter">0</span>/1000</p>
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