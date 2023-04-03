<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

	<script type="text/javascript">
		let buttonCheck = 0; // 수정버튼과 삭제버튼을 구별하기 위한 변수
		$(function(){

			/* 삭제 버튼 클릭 시 처리 이벤트  "f_no="+$("#f_no").val(),  쿼리 스트링이기 때문에 공백 들어가면 안된다.*/
			
			$("#reviewDeleteBtn").click(function(){
				if(confirm("정말 삭제하시겠습니까?")){
					goUrl = "/admin/review/adminreviewDelete";
					$("#f_data").attr("action",goUrl);
					$("#f_data").submit();
				}
			});
								
		
			
			/* 목록 버튼 클릭 시 처리 이벤트 */
			$("#reviewListBtn").click(function(){
				location.href="/admin/review/adminreviewList"; 
			});
			
		});	
	</script>
	</head>
	<body>
		<div class="contentContainer container"> 					 
			
			 <form name="f_data" id="f_data">
				<input type="hidden" name="r_no" value="${detail.r_no}"/>
				<input type="hidden" name="s_num" value="${detail.s_num}"/>		
				<input type="hidden" name="u_id" value="${detail.u_id}"/>		
			</form> 
				
			<%-- =============== 상세 정보 보여주기 시작 ============ --%>
			<div class="contentTB text-center">
				<table class="table table-bordered">
				
					<tbody>
						<tr>
							<td class="col-md-1">공연번호</td> 
							<td class="col-md-1 text-left">${detail.s_num}</td> 
							<td class="col-md-1">공연명</td> 
							<td class="col-md-1 text-left">${detail.s_name}</td> 						
						</tr>	
						
						<tr>
							<td class="col-md-1">고객ID</td> 
							<td class="col-md-1 text-left">${detail.u_id}</td> 
							<td class="col-md-1">고객명</td> 
							<td class="col-md-1 text-left">${detail.u_name}</td> 						
						</tr>	
						
						<tr class="table-tr-height">	
							<td class="col-md-1">관람후기제목</td> 						
							<td colspan="3" class="col-md-8 text-left">${detail.r_title}</td>
						</tr>			
								
						<tr>								
							<td class="col-md-3">작성일</td>
							<td class="col-md-3 text-left">${detail.r_regdate}</td>							
							<td class="col-md-3">수정일</td>
							<td class="col-md-3 text-left">${detail.r_update}</td>
						</tr>
								
						<tr class="table-tr-height">
							<td class="col-md-4">관람후기내용</td>
							<td colspan="3" class="col-md-10 text-left">${detail.r_content}</td>
						</tr>	
					</tbody>
			
				</table>			
			</div>			
	
							
			<%-- ========= 목록 버튼 ====== --%>	
			<div class="btnArea col-md-4 text-right">
			
				<input type="button" value="글삭제" id="reviewDeleteBtn" class="btn btn-primary" />
				<input type="button" value="목록" id="reviewListBtn" class="btn btn-primary" />
			</div>
		
		</div>	
			<hr>
			<hr>
			<hr>
	     	
	</body>
</html>
