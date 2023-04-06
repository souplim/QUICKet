<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"  %>

	<style type="text/css">
		#search-title {
			font-size: 15px;
			font-weight: bold;
			margin-right: 50px;
		}
		.searchDate {margin-right: 30px;}
		.gray { background-color: rgb(233, 233, 233); }
		.margin-title {
			margin: 0 0 15px 0;
			padding: 10px 15px;
		}
		td { vertical-align : middle; }
	</style>
	<!-- 스크립트 정의 -->
	<script type="text/javascript" src="/resources/include/js/common.js"></script>
	<script type="text/javascript">
		search = "<c:out value='${mypageVO.search}' />"; 
		start_date = "<c:out value='${mypageVO.start_date}' />";
		end_date = "<c:out value='${mypageVO.end_date}' />";
		
		$(function(){
			
			/* 검색어, 검색날짜 띄우기 */
			if(search!=""){
				$('#search').val(search);
			}
			$('#start_date').val(start_date);
			$("#end_date").val(end_date);
			
			/* 날짜 선택 후 검색 버튼 클릭 시 처리 이벤트 */
			$('#searchBtn').click(function(){
				if(!chkSubmit($('#start_date'),"시작날짜를")) return;
				else if(!chkSubmit($('#end_date'),"종료날짜를")) return;
				else if($('#start_date').val()>$('#end_date').val()){
					alert('시작날짜가 종료날짜보다 더 클 수 없습니다.');
					return;
				}
				
				$('#pageNum').val(1);
				goPage();
			});
			
			/* 기간 버튼 선택시 현재 날짜에서 1주일, 1개월, 3개월 더하기 */
			//let date = getDateFormat(new Date());  common.js의 날짜형식 'yyyy-mm-dd'로 바꿔주는 함수
			let endDate = new Date();
			var date = getDateFormat(endDate);
			
			console.log(endDate);
			console.log(date);
			
		    $('#btnWeek').click(function(){
		    	$('#end_date').val(date);
		    	
		    	endDate.setDate(endDate.getDate() - 7);
		    	$('#start_date').val(getDateFormat(endDate));
	
		        $('#pageNum').val(1);
				goPage(); 
		    });
		    
		    $('#btnMonth').click(function(){
		    	$('#end_date').val(date);
		    	
		    	endDate.setMonth(endDate.getMonth()-1);
		    	$('#start_date').val(getDateFormat(endDate));
	
		        $('#pageNum').val(1);
				goPage(); 
		    });
		 
		    $('#btn3Month').click(function(){
				$('#end_date').val(date);
		    	
		    	endDate.setMonth(endDate.getMonth()-3);
		    	$('#start_date').val(getDateFormat(endDate));
	
		        $('#pageNum').val(1);
				goPage(); 
		    });
		    
			
			/* 전체 조회 버튼 클릭시 이벤트 처리 */
			$('#allSearchBtn').click(function(){
				$('#start_date').val("");
				$('#end_date').val("");
				//goPage();
				location.href="/mypage/myTicketList";
			});
			
			/* 엔터 시 검색 */
			$('.paginate_button a').click(function(e){
				e.preventDefault();
				$('#f_search').find("input[name='pageNum']").val($(this).attr("href"));
				goPage();
			});
			
			/* 제목 마우스 오버시 밑줄 & 포인터(goDetail이 아니어서 따로 지정해주어야 함) */
			$(".goShowDetail").hover(function(){
				$(this).css("textDecoration","underline");
				$(this).css("cursor","pointer");
			}, function(){
				$(this).css("textDecoration","none");
				$(this).css("cursor","none");
			});
			
			/* 제목 클릭시 공연 상세 페이지 이동을 위한 처리 이벤트 */
			$(".goShowDetail").on("click", function(){
				let s_num = $(".data-snum").attr("data-snum");
				location.href="/showDetail?s_num="+s_num;
			});
			
			/* 상세정보 버튼 클릭시 상세 페이지 이동을 위한 처리 이벤트 */
			$(".goDetail").click(function(){
				let pay_num = $(this).parents("tr").attr("data-num");
				let s_num = $(".data-snum").attr("data-snum");
				
				console.log("결제번호:"+pay_num);
				console.log("공연번호:"+s_num);
				
				$("#pay_num").val(pay_num);
				$("#s_num").val(s_num);
				
				// 상세 페이지로 이동하기 위해 form 추가(id: dataForm)
				$("#dataForm").attr({
					"method" : "post", 
					"action" : "/mypage/myTicketDetail"
				});
				$("#dataForm").submit();
				
			});
			
			/* 페이징 처리 이벤트 */
			$(".paginate_button a").click(function(e){
				e.preventDefault(); // a태그 -> href로 이동하는 성격 해제
				// dataForm 폼 하위 pageNum을 이름으로 가지는 input의 값을 클릭한 번호
				$("#pageForm").find("input[name='pageNum']").val($(this).attr("href"));
				
				// pageNum을 들고 다시 페이지 list 부르기
				$("#pageForm").attr({
					"method" : "get",
					"action" : "/mypage/myTicketList"
				});
				$("#pageForm").submit();
			});
			
		}); 
		
		/* 페이지 이동 */
		function goPage(){
			$('#f_search').attr({
				"method" : "get",
				"action" : "/mypage/myTicketList"
			});
			$('#f_search').submit();
		}
	</script>
	</head>
	<body>
		<div class="contentContainer container">
			<%-- ================= 데이터 전달 폼 ================= --%>
			<form name="dataForm" id="dataForm">
				<input type="hidden" name="pay_num" id="pay_num">
				<input type="hidden" name="s_num" id="s_num">
			</form>
			<form name="pageForm" id="pageForm">
				<!-- 페이징 처리를 위한 파라미터 -->
				<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum}"/>
				<input type="hidden" name="amount" id="amount" value="${pageMaker.cvo.amount}"/>
			</form>
			
			<div>
				<h1>예매확인/취소</h1>
				<p>상세정보를 클릭하면 예매 상세 내용을 확인할 수 있습니다.</p>
			</div>
			
			<%-- ================= 검색 부분 출력 ================= --%>
			<div class="well text-center">
				<form class="form-inline" id="f_search">
					<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum}"> 
					<input type="hidden" name="amount" id="amount" value="${pageMaker.cvo.amount}">

					<div class="form-group" id="search-title">조회기간 선택</div>
					<!-- 기간 선택 검색 -->
					<div class="form-group">기간검색&nbsp;</div>
					<div class="form-group searchDate">
						<button id="btnWeek" class="btn btn-primary">1주일</button>
					    <button id="btnMonth" class="btn btn-primary">1개월</button>
					    <button id="btn3Month" class="btn btn-primary">3개월</button>
					</div>

					<div class="form-group">날짜검색&nbsp;</div>
					<div class="form-group">
						<label for="search" class="sr-only">검색조건</label>
						<select id="search" name="search" class="form-control">
							<option value="hall_date">관람일</option>
							<option value="ti_regdate">예매일</option>
						</select>
					</div>
					
					<div class="form-group" id="dateCheck"> 
						<input type="date" name="start_date" id="start_date" placeholder="시작일자" class="form-control">
						<input type="date" name="end_date" id="end_date" placeholder="종료일자" class="form-control">
					</div>
					<button type="button" class="btn btn-primary" id="searchBtn">Search</button>
					<button type="button" class="btn btn-primary" id="allSearchBtn">All Search</button> <!-- 전체 레코드 조회 -->
					
				</form>
			</div>
			
			<%-- ================= 리스트 시작 ================= --%>
			<div id="inqList" class="table-height">
				<table summary="게시판 리스트" class="table table-striped">
					<thead>
						<tr>
							<th class="order text-center col-md-2">예매일</th>
							<th class="text-center col-md-2">예매번호</th>
							<th class="text-center col-md-3">공연명</th>
							<th class="order text-center col-md-2">관람일시</th>
							<th class="text-center col-md-1">매수</th>
							<th class="text-center col-md-2">예매상태</th>
						</tr>
					</thead>
					<tbody id="list" class="table-striped">
						<!-- 데이터 출력 -->
						<!-- <c:if test=""></c:if> ${inq.u_id} 세션아이디와 작성자아이디가 같을 경우 출력 -->
						<c:choose>
							<c:when test="${not empty ticketList}">
								<c:forEach var="ticket" items="${ticketList}" varStatus="status">
									<tr class="text-center" data-num="${ticket.pay_num}">
										<!-- 새로 번호 부여 상태변수.index: 0부터 시작-->
										<%-- <td>${count - status.index}</td>  --%>
										<td style="vertical-align:middle">${ticket.ti_regdate}</td> 
										<td class="data-snum" data-snum="${ticket.s_num}" style="vertical-align:middle">${ticket.pay_num}</td>
										<td class="text-left goShowDetail" data-uid="${ticket.u_id}" style="vertical-align:middle">${ticket.s_name}</td>
										<td style="vertical-align:middle">${ticket.hall_date}</td>
										<td style="vertical-align:middle">${ticket.seat_num_cnt}</td>
										<td class="text-danger">
											<c:if test="${ticket.ti_status==0}">
												전체취소
											</c:if>
											<c:if test="${ticket.ti_status==1}">
												예매완료
											</c:if> &nbsp;
											<button type="button" class="goDetail btn btn-info">상세정보</button>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="6" class="tac text-center">예매내역이 존재하지 않습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
						
					</tbody>
				</table>
			</div>
			
			<%-- ================= 페이징 출력 시작 ================= --%>
			<div class="text-center">
				<ul class="pagination">
					<!-- 이전 바로가기 10개 존재 여부를 prev 필드의 값으로 확인 -->
					<c:if test="${pageMaker.prev}">
						<li class="paginate_button previous">
							<a href="${pageMaker.startPage -1}">Previous</a>
						</li>
					</c:if>
					
					<!-- 바로가기 번호 출력 -->
					<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
						<!-- 현재 페이지 색깔 : 현재 보고 있는 페이지와 for문으로 돌리고 있는 페이지가 일치하면 class='active' 적용 -->
						<li class="paginate_button ${pageMaker.cvo.pageNum == num ? 'active':''}">
							<a href="${num}">${num}</a>
						</li>
					</c:forEach>
					
					<!-- 다음 바로가기 10개 존재 여부를 next 필드의 값으로 확인 -->
					<c:if test="${pageMaker.next}">
						<li class="paginate_button next">
							<a href="${pageMaker.endPage+1}">Next</a>
						</li>
					</c:if>
				</ul>
			</div>
			
			<%-- ================= 티켓취소 안내 ================= --%>
			<div class="contentTB text-center">
				<div class="gray margin-title">
					<h4 class="text-left">예매취소 안내</h4>
					<div class="text-left">
						<ul>
							<li>예매수수료는 예매일 이후 취소시에는 환불되지 않습니다.</li>
							<li>동일 상품에 대해서 날짜, 시간, 좌석, 가격 등급, 결제 등의 일부 변경을 원하시는 경우, 기존 예매 건을 취소하시고 재예매 하셔야 합니다.</li>
							<li>단, 취소 시점에 따라 예매수수료가 환불 되지 않으며,취소수수료가 부과될 수 있습니다.<br/>
								(할인선택은 재예매 시점에 적용되는 할인률로만 적용 가능합니다.)</li>
							<li>이미 배송이 시작된 티켓의 경우 인터넷 및 전화로 취소할 수 없습니다.</li>
							<li>반드시 취소마감 시간 이전에 티켓이 퀵켓 고객센터로 반송되어야 취소가능하며, 취소수수료는 도착일자 기준으로 부과됩니다.<br/>
								(* 단, 배송료는 환불되지 않으며 일괄배송 상품의 경우 취소에 대한 자세한 문의는 고객센터로 문의해주시기 바랍니다.)</li>
							<li>예매취소시점과 해당 카드사의 환불 처리기준에 따라 취소금액의 환급방법과 환급일은 다소 차이가 있을 수 있습니다.</li>
							<li>예매 취소 시 최초 결제 동일카드로 예매 시점에 따라 취소 수수료와 배송료를 재승인합니다.</li>
							<li>관람일 전일 오후 5시 이후(토요일은 오전 11시) 또는 관람일 당일 예매하신 건에 대해서는 예매후 취소/변경/환불이 불가합니다.</li>
							<li>티켓 부분 취소 시 할부 결제는 티켓 예매 시점으로 적용됩니다.<br/>
								(무이자할부 행사기간이 지날 경우 혜택받지 못하실 수 있으니 유의하시기 바랍니다)</li>
							<li>기타 문의사항은 [이용안내]를 참조하시거나, [고객센터]를 이용하시기 바랍니다.</li>
						</ul>
					</div>
				</div>
			</div>
			
			
		</div>
	</body>
</html>