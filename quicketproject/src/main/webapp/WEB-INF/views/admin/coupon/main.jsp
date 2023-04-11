<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<title>관리자 쿠폰 관리</title>

<script>
	search = "<c:out value='${data.search}' />";
	keyword = "<c:out value='${data.keyword}' />";

	$(function(){
		
		// 등록 클릭 시 폼으로 이동
		$("#insertCouponBtn").click(function(){
			location.href="/admin/coupon/insertForm";
		});
		
		// 페이징 처리
		$(".paginate_button a").click(function(e) {
			 e.preventDefault();
			 $("#f_search").find("input[name='pageNum']").val($(this).attr("href"));
			 goPage();
		});
		
	});
	
	function goPage() {
		if($("#search").val()=="all") {
			$("#keyword").val("");
		}
		
		$("#f_search").attr({
			"method" : "get",
			"action" : "/admin/coupon/main"
		});
		$("#f_search").submit();
	}
</script>

<style>
	.cImg{width:25px;}
</style>
</head>
<body>
<div class="">

		<div class="well">
			<form class="form-inline" id="f_search">
				<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum}">
				<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
							
				<h3 style="display: inline;"><span class="label label-success">검색조건</span></h3>
				<div class="form-group">
					<select id="search" name="search" class="form-control">
						<option value="c_num">쿠폰번호</option>
						<option value="c_name">쿠폰명</option>	
					</select>
				</div>
				<div class="form-group" id="textCheck">
					<input type="text" name="keyword" id="keyword" class="form-control" placeholder="검색어를입력하세요" />
				</div>
				<button type="button" class="btn btn-primary" id="searchBtn">Search</button>
				<button type="button" class="btn btn-primary" id="allSearchBtn">All Search</button>
			</form>
		</div> 

	<div class="table-responsive table-height">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th class="text-center">번호</th>
						<th class="text-center">쿠폰번호</th>
						<th class="text-center">쿠폰명</th>
						<th class="text-center">이미지</th>
						<th class="text-center">발급기간</th>
						<th class="text-center">유효기간</th>
						<th class="text-center">할인율</th>
						<th class="text-center">등록일</th>
					</tr>
				</thead>
				<tbody>
					<!-- 데이터 출력 -->
					<c:choose>
						<c:when test="${not empty couponList}" >
							<c:forEach var="coupon" items="${couponList}" varStatus="status">
								<tr class="text-center" data-num="${coupon.c_num}">
									<td>${count - status.index}</td>
									<td>${coupon.c_num}</td>
									<td>${coupon.c_name}</td>
									<td><img class="cImg" src="/uploadStorage/coupon/${coupon.c_img}"/></td>
									<td><span>${coupon.c_startissue }</span>~<span>${coupon.c_endissue }</span></td>
									<td><span>${coupon.c_startdate}</span>~<span>${coupon.c_enddate}</span></td>
									<td>${coupon.c_discount}%</td>
									<td>${coupon.c_regdate}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="7" class="text-center">등록된 쿠폰이 없습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		
		<div class="contentBtn text-right">
				<input type="button" value="등록" id="insertCouponBtn" class="btn btn-info"/>
		</div>
		
		<div class="text-center">
			<ul class="pagination">
				<!-- 이전 바로가기 10개 존재 여부를 prev 필드의 값으로 확인. -->
				<c:if test="${pageMaker.prev}">
					<li class="paginate_button previous">
						<a href="${pageMaker.startPage - 1}">Previous</a>
					</li>
				</c:if>
						
				<!-- 바로가기 번호 출력 -->
				<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
					<li class="paginate_button  ${pageMaker.cvo.pageNum == num ? 'active':''}">
						<a href="${num}">${num}</a>
					</li>
				</c:forEach>
		
				<!-- 다음 바로가기 10개 존재 여부를 next 필드의 값으로 확인. -->
				<c:if test="${pageMaker.next}">
					<li class="paginate_button next">
						<a href="${pageMaker.endPage + 1 }">Next</a>
					</li>
				</c:if> 
			</ul>
		</div>	
		
	</div>
</body>
</html>