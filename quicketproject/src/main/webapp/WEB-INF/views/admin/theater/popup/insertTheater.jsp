<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<style type="text/css">
 th{
 	text-align:center;
 }
 th, td{
 	font-size:20px;
 }
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3dc7376a2cb1e4f12306eaaebe2593e4&libraries=services,clusterer,drawing"></script>
<script type="text/javascript">
	$(function(){
		$("#th_addr").change(function(){
			let th_addr = $(this).val();
			
			geocoder = new kakao.maps.services.Geocoder();
			geocoder.addressSearch(th_addr, function(result, status){
				if(status===kakao.maps.services.Status.OK){
					$("#th_map_lat").val(result[0].y);
					$("#th_map_lng").val(result[0].x);
				}
			})
		})
		
		$("#returnBtn").click(function(){
			window.self.close();
			
		})
		$("#cancelBtn").click(function(){
			location.href=location.pathname;
		})
		$("#theaterInsertBtn").click(function(){
			$.ajax({
				url: "/admin/theater/theaterInsert",
				type: "post",
				success: function(result){
					if(result=="success"){
						alert("데이터가 입력되었습니다.");
						window.self.close();
					}else{
						let $option = $("<option value=''>공연장 정보가 없습니다.</option>");
						$("#th_num").append($option);
					}
				
			})
		})
		
	})
</script>
</head>
<body>
	<div class="container">
		<div class="row text-center"><h1>공연장 데이터 입력 양식</h1></div>
		<br/><br/>
		<form id="f_theaterInsert">
			<div class="row">
				<div class="col-xs-10 col-xs-offset-1">
				<table class="table table-bordered">
					<tr>
						<th class="col-sm-4">공연장 이름</th>
						<td class="col-sm-8">
							<input type="text" id="th_name" name="th_name" class="form-control" />
						</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>
							<input type="text" id="th_addr" name="th_addr" class="form-control" />
						</td>
					</tr>
					<tr>
						<th>지도 정보</th>
						<td>
							<label for="th_map_lat" class="col-sm-2 text-center">위도</label>
							<div class="col-sm-4">
								<input type="text" id="th_map_lat" name="th_map_lat" class="form-control" />
							</div>
							<label for="th_map_lng" class="col-sm-2 text-center">경도</label>
							<div class="col-sm-4">
								<input type="text" id="th_map_lng" name="th_map_lng" class="form-control" />
							</div>
						</td>
					</tr>
					<tr>
						<th>좌석수</th>
						<td>
							<input type="text" id="th_seat" name="th_seat" class="form-control" />
						</td>
					</tr>
					<tr>
						<th>웹사이트</th>
						<td>
							<input type="text" id="th_web" name="th_web" class="form-control" />
						</td>
					</tr>
				</table>
				</div>
			</div>
			<div class="row"><div class="col-xs-10 col-xs-offset-1 text-right">
				<button type="button" id="returnBtn" class="btn btn-default">돌아가기</button>
				<button type="button" id="cancelBtn" class="btn btn-default">입력취소</button>
				<button type="button" id="theaterInsertBtn" class="btn btn-default">등록하기</button>
			</div></div>
		</form>
	</div>
</body>
</html>