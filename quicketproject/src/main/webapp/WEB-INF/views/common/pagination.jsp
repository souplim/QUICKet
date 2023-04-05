<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page trimDirectiveWhitespaces="true" %>
<style type="text/css">
.pagination>li>a, .pagination>li>a:hover{
	color:#999;
}
.pagination>.active>a{
    background-color:#ccc;
    border-color:#ccc;
}
.pagination>.active>a:hover{
    background-color:#999;
    border-color:#ccc;
}
.pagination>.active>a:focus{
    background-color:#777;
    border-color:#ccc;
}
</style>
<script type="text/javascript">
$(function(){
	$(".paginate_btn a").click(function(e){
		e.preventDefault();
		$("#f_pagination").find("input[name='pageNum']").val($(this).attr("href"));
		goPage();
	})
	
	function goPage(){
		$("#f_pagination").attr({
				"method":"get",
				"action":location.pathname
		});
		$("#f_pagination").submit();
	}
})
</script>
<div class="row text-center">
	<form id="f_pagination">
		<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}" />
		<input type="hidden" name="amount" value="${pageMaker.cvo.amount}" />
		<c:if test="${boardVO.keyword!=''}">
			<input type="hidden" name="search" value="${boardVO.search}" />
			<input type="hidden" name="keyword" value="${boardVO.keyword}" />	
		</c:if>
	</form>
	<ul class="pagination">
		<c:if test="${pageMaker.prev}">
			<li class="paginate_btn previous">
				<a href="${pageMaker.startPage-1}">Prev</a>
			</li>
		</c:if>
		<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
			<li class="paginate_btn ${pageMaker.cvo.pageNum==num?'active':''}">
				<a href="${num}">${num}</a>
			</li>
		</c:forEach>
		<c:if test="${pageMaker.next}">
			<li class="paginate_btn next">
				<a href="${pageMaker.endPage+1}">Next</a>
			</li>
		</c:if>
	</ul>
</div>