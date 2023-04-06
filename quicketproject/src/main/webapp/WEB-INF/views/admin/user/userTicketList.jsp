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
	
	/*
		search = "<c:out value='${mypageVO.search}' />"; 
		start_date = "<c:out value='${mypageVO.start_date}' />";
		end_date = "<c:out value='${mypageVO.end_date}' />";
	*/	
	
		$(function(){
			
			/* 검색어, 검색날짜 띄우기
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
			}); */
			
			/* 기간 버튼 선택시 현재 날짜에서 1주일, 1개월, 3개월 더하기
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
		    
			 */
			/* 전체 조회 버튼 클릭시 이벤트 처리
			$('#allSearchBtn').click(function(){
				$('#start_date').val("");
				$('#end_date').val("");
				//goPage();
				location.href="/mypage/myTicketList";
			}); */
			
			/* 엔터 시 검색 
			$('.paginate_button a').click(function(e){
				e.preventDefault();
				$('#f_search').find("input[name='pageNum']").val($(this).attr("href"));
				goPage();
			});*/
			
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
				location.href="";
			});
			
			/* 상세정보 버튼 클릭시 상세 페이지 이동을 위한 처리 이벤트 
			$(".goDetail").click(function(){
				let ti_num = $(this).parents("tr").attr("data-num");
				let s_num = $(".data-snum").attr("data-snum");
				
				console.log("예매번호:"+ti_num);
				console.log("공연번호:"+s_num);
				
				$("#ti_num").val(ti_num);
				$("#s_num").val(s_num);*/
				
				// 상세 페이지로 이동하기 위해 form 추가(id: dataForm)
				/*$("#dataForm").attr({
					"method" : "post", 
					"action" : "/mypage/myTicketDetail"
				});
				$("#dataForm").submit();
				
			});*/
			
			
		}); 
		
		/* 페이지 이동 
		function goPage(){
			$('#f_search').attr({
				"method" : "get",
				"action" : "/mypage/myTicketList"
			});
			$('#f_search').submit();
		}*/
	</script>
	</head>
	<body>
		<div class="contentContainer container">
			<%-- ================= 데이터 전달 폼 ================= --%>
			<form name="dataForm" id="dataForm">
				<input type="hidden" name="ti_num" id="ti_num">
				<input type="hidden" name="s_num" id="s_num">
			</form>
			<form name="pageForm" id="pageForm">
				<!-- 페이징 처리를 위한 파라미터 
				<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum}"/>
				<input type="hidden" name="amount" id="amount" value="${pageMaker.cvo.amount}"/>
		-->	</form>
			
			<div>
				<h1>회원 예매내역</h1>
			</div>
			
			<%-- ================= 검색 부분 출력 ================= 
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
			</div>--%>
			
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
									<tr class="text-center" data-num="${ticket.ti_num}">
										<td style="vertical-align:middle">${ticket.ti_regdate}</td> 
										<td class="data-snum" data-snum="${ticket.s_num}" style="vertical-align:middle">${ticket.ti_num}</td>
										<td class="text-left goShowDetail" data-uid="${ticket.u_id}" style="vertical-align:middle">${ticket.s_name}</td>
										<td style="vertical-align:middle">${ticket.hall_date}</td>
										<td style="vertical-align:middle">${ticket.seat_num}</td>
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
			
			<%-- ================= 페이징 출력 시작 ================= 
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
			--%>
		
		</div>
	</body>
</html>