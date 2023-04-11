<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/popup.jspf" %>
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

	</head>
	<body>
	<div class="contentTit page-header"><h3 class="text-center">회원 예매 내역</h3></div>  
		<div class="contentContainer container">

			<%-- ================= 리스트 시작 ================= --%>
			<div class="continaer">
				<div id="inqList" class="">
					<table summary="게시판 리스트" class="table table-bordered">
						<thead>
							<tr>
								<th class="order text-center col-md-2">예매일</th>
								<th class="text-center col-md-2">예매번호</th>
								<th class="text-center col-md-3">공연명</th>
								<th class="order text-center col-md-2">관람일시</th>
								<th class="text-center col-md-1">매수</th>
								<th class="text-center col-md-1">예매상태</th>
							</tr>
						</thead>
						<tbody id="list" class="">
							<c:choose>
								<c:when test="${not empty ticketList}">
									<c:forEach var="ticket" items="${ticketList}" varStatus="status">
										<tr class="text-center" data-num="${ticket.pay_num}">
											<td style="vertical-align:middle">${ticket.ti_regdate}</td> 
											<td class="data-snum" data-snum="${ticket.s_num}" style="vertical-align:middle">${ticket.pay_num}</td>
											<td class="text-left goShowDetail" data-uid="${ticket.u_id}" style="vertical-align:middle">${ticket.s_name}</td>
											<td style="vertical-align:middle">${ticket.hall_date}</td>
											<td style="vertical-align:middle">${ticket.seat_num}</td>
											<td class="text-danger">
												<c:if test="${ticket.ti_status==0}">
													전체취소
												</c:if>
												<c:if test="${ticket.ti_status==1}">
													예매완료
												</c:if>
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
			
			</div>

		
		</div>
	</body>
</html>