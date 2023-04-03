<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

	<script type="text/javascript">
		$(function(){
			
			let errorMsg = "${errorMsg}";
    		if(errorMsg!="") {
    			alert(errorMsg);
    			errorMsg = "";
    		}
    		
			
			// 저장 버튼 클릭 시 
			$("#couponInsertBtn").click(function(){
				// 입력값 유효 체크
				if(!chkData("#c_num","쿠폰 번호를")) return;
				else if (!chkData("#c_name","쿠폰명을")) return;
				else if (!chkData("#c_discount","쿠폰 할인율을")) return;
				else if (!chkData("#c_startdate","쿠폰 적용 시작일을")) return;
				else if (!chkData("#c_enddate","쿠폰 적용 종료일을")) return;
				else if (!chkData("#file","쿠폰 이미지를")) return;
				else if (!chkFile($("#file"))) return;
				else {
					
					$("#insertForm").attr({
						"method" : "post",
						"enctype" : "multipart/form-data", 	// enctype 속성의 기본 값은 "application/x-www-form-urlcencoded". POST방식 폼 전송에 기본 값으로 사용
						"action" : "/admin/coupon/insertCoupon"
					});
					$("#insertForm").submit();
				}
			});
			
			// 목록 버튼 클릭 시
			$("#couponListBtn").click(function(){
				location.href="/coupon/main";
			});
			
			// 취소 버튼 클릭 시
			
			$("#couponCancelBtn").click(function(){
				$("#insertForm").each(function(){
					this.reset();
				});
			});
		});
	</script>

	</head>
	<body>
		<div class=" contentContainer container">
			<div class="contentTB text-center">
				<form class="form-horizontal"id="insertForm" name="insertForm">
				<table class="table">
					<colgroup>
						<col width="20%" />
						<col width="80%" />
					</colgroup>
					<tbody>
							<tr>
								<td>쿠폰번호</td>
								<td class="text-left"><input type="text" name="c_num" id="c_num" class="form-control" /></td>
							</tr>
							<tr>
								<td>쿠폰명</td>
								<td class="text-left"><input type="text" name="c_name" id="c_name" class="form-control" /></td>
							</tr>
							<tr>
								<td>할인율</td>
								<td class="text-left"><input type="number" min="1" max="100" name="c_discount" id="c_discount" class="form-control"/></td>
							</tr>
							<tr>
								<td>발급기간</td>
								<td class="text-left"><input type="date" name="c_startissue" id="c_startissue" placeholder="발급 시작일"/><input type="date" name="c_endissue" id="c_endissue" placeholder="발급 종료일"/></td>
							</tr>
							<tr>
								<td>유효기간</td>
								<td class="text-left"><input type="date" name="c_startdate" id="c_startdate" placeholder="유효기간 시작일"/><input type="date" name="c_enddate" id="c_enddate" placeholder="유효기간 종료일"/></td>
							</tr>
							<tr>
								<td>이미지 첨부</td>
								<td class="text-left"><input type="file" id="file" name="file"/></td>
							</tr>
						</tbody>
				</table>
				<%--===================버튼===================--%>
				<div class="contentBtn text-right">
					<button type="button"id="couponInsertBtn"class="btn btn-default btn-sm">저장</button>
					<button type="button"id="couponInsertCancelBtn"class="btn btn-default btn-sm">취소</button>
					<button type="button"id="couponInsertListBtn"class="btn btn-default btn-sm">목록</button>
				</div>
			</form>
			</div>
		</div>
	</body>
</html>