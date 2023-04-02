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
			
			/* 예매번호 숨기기 */
			$("#reserveInfo").hide();
			/* '선택' 유형 선택 시 faq 숨기기 */
			$("#accordion").hide();
			
			/* 유형 선택시 세부유형 option 항목 처리, 유형 '공연' 선택시 예매번호 조회 이벤트 */
			$("#i_category").on("change", function(){
				const opt = ["선택"];
				const 회원정보 = ["로그인","아이디/패스워드","회원가입","회원탈퇴"];
				const 공연 = ["예매","취소/변경","배송","결제","이벤트","건의사항","기타"];
				const 그외 = ["건의사항","기타"];
				
				let category = $("#i_category").val();
				
				let detail;
				if(category == "회원정보") {
					detail = 회원정보;
					$("#reserveInfo").hide();
					$("#accordion").show();
					
					/* 유형 선택 시 아코디언 열기 */
					if($("#faqBoxList").css("display") == "none"){ // 클릭하는 요소 열려있지 않으면
						$("#confirmFaq").next("div").slideDown();
					} else {
						$("#confirmFaq").next("div").slideUp();
					}
				}
				else if(category == "공연") {
					detail = 공연;
					$("#reserveInfo").show();
					$("#accordion").show();
				} else if(category == "그 외") {
					detail = 그외;
					$("#reserveInfo").hide();
					$("#accordion").show();
				} else {
					detail = opt;
					$("#reserveInfo").hide();
					$("#accordion").hide();
				}
				
				let target = $("#i_cate_detail");
				target.empty(); /* 기존에 들어가 있는 옵션 삭제 */
				
				for(x in detail)
					target.append("<option>"+detail[x]+"</option>");
					
				/* 서버로부터 유형에 따른 faq 리스트 불러와 보여주는 함수 */	
				let Url = "/inq/faqList/?f_category="+category; 	
				$.ajax({
					url : Url,
					type : 'post',
					headers : {
						"Content-Type" : "application/json"
					},
					dataType: 'json',
					error : function(xhr, textStatus, errorThrown){
						alert("시스템에 문제가 있어 잠시 후 다시 진행해주세요.");
					},
					success : function(result){
		                $.each(result, function (i, item) {
		                	$("#heading"+(i+1)+" a").html(item.f_title);
		                	let f_content = item.f_content
		                	f_content = f_content.replace(/(\r\n|\r|\n)/g, "<br />"); 
		                	$("#collapse"+(i+1)+" div").html(item.f_content);
		                });
					}
				});	
			});
			
			/* faqList 클릭하면 faq리스트 slideDown 처리 이벤트 */
			$("#confirmFaq").on("click", function(){
				if($("#faqBoxList").css("display") == "none"){ // 클릭하는 요소 열려있지 않으면
					$(this).next("div").slideDown();
				} else {
					$(this).next("div").slideUp();
				}
			});
			
			/* faq리스트 제목 클릭하면 내용 slideDown 처리 이벤트 -> 부트스트랩으로 기능 대체
			/* $(".faqTitle").on("click", function(){
				if($(this).next("dd").css("display") == "none"){ // 클릭하는 요소 열려있지 않으면
					$(this).next("dd").slideDown();
				} else {
					$(this).next("dd").slideUp();
				}
			}); */
			
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
					// select option null값 제외 
					console.log($("#ti_num option:selected").val());
					
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
					
					<div id="reserveInfo">
						<div class="col-md-1"><label for="ti_num">예매번호</label></div>
						<div class="form-group col-md-5">
							<select class="form-control" name="ti_num" id="ti_num">
								<option value="0">선택</option>
								<!-- 유형이 공연일 때만 선택 조회 -->
								<c:if test="${not empty ticketList}" >
									<c:forEach var="ticket" items="${ticketList}" varStatus="status">
										<option value="${ticket.ti_num}" >
											${ticket.ti_num}&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
											${ticket.s_name}&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
											${ticket.hall_date}
										</option>
									</c:forEach>
								</c:if>
							</select>
						</div>
					
					</div>
					
				</div>

			<div id="faqBox">
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
						<%-- <c:forEach var="i" begin="0" end="4">
							<div class="panel panel-default">
								<div class="panel-heading" role="tab" id=i>
									<h4 class="panel-title">
										<a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
											dfdf
										</a>
									</h4>
								</div>
								<div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby=i>
									<div class="panel-body">
										dfdf
									</div>
								</div>
							</div>
						</c:forEach> --%>
						
						<div class="panel panel-default">
							<div class="panel-heading" role="tab" id="heading1">
								<h4 class="panel-title">
									<a data-toggle="collapse" data-parent="#accordion" href="#collapse1" aria-expanded="true" aria-controls="collapseOne">
									</a>
								</h4>
							</div>
							<div id="collapse1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading1">
								<div class="panel-body">
									
								</div>
							</div>
						</div>
						
						<div class="panel panel-default">
							<div class="panel-heading" role="tab" id="heading2">
								<h4 class="panel-title">
									<a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapse2" aria-expanded="false" aria-controls="collapseTwo">
										
									</a>
								</h4>
							</div>
							<div id="collapse2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading2">
								<div class="panel-body">
									
								</div>
							</div>
						</div>
						
						<div class="panel panel-default">
							<div class="panel-heading" role="tab" id="heading3">
								<h4 class="panel-title">
									<a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapse3" aria-expanded="false" aria-controls="collapseThree">
										 
									</a>
								</h4>
							</div>
							<div id="collapse3" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading3">
								<div class="panel-body">
									
								</div>
							</div>
						</div>

						<div class="panel panel-default">
							<div class="panel-heading" role="tab" id="heading4">
								<h4 class="panel-title">
									<a class="collapsed" data-toggle="collapse"data-parent="#accordion" href="#collapse4" aria-expanded="false" aria-controls="collapseFour">
										
									</a>
								</h4>
							</div>
							<div id="collapse4" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading4">
								<div class="panel-body">

								</div>
							</div>
						</div>
						
						<div class="panel panel-default">
							<div class="panel-heading" role="tab" id="heading5">
								<h4 class="panel-title">
									<a class="collapsed" data-toggle="collapse"data-parent="#accordion" href="#collapse5" aria-expanded="false" aria-controls="collapseFive">
										
									</a>
								</h4>
							</div>
							<div id="collapse5" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading5">
								<div class="panel-body">
									
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