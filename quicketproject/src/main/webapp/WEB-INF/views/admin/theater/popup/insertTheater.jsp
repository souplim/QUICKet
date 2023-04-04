<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/popup.jspf" %>
<style type="text/css">
 th{
 	text-align:center;
 }
 th, td{
 	font-size:20px;
 }
</style>
<script type="text/javascript" src="/resources/include/js/common.js"></script>
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
				}else{
					$("#th_addr").val("");
					$("#th_addr").attr("placeholder","좌표를 찾을 수 없는 주소입니다. 다시 입력해주세요.");
					$("#th_addr").focus();
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
			if(!checkForm("#th_name","공연장 이름을")) return;
			if(!checkForm("#th_addr","주소를")) return;
			if(!checkForm("#th_seat","총 좌석수를")) return;
			
			let value = JSON.stringify({
				th_name:$("#th_name").val(),
				th_addr:$("#th_addr").val(),
				th_map_lat:$("#th_map_lat").val(),
				th_map_lng:$("#th_map_lng").val(),
				th_seat:$("#th_seat").val(),
				th_web:$("#th_web").val()
			});
			
			$.ajax({
				url: "/admin/theater/theaterInsert",
				type: "post",
				headers:{
					"Content-Type":"application/json"
				},
				dataType:"text",
				data: value,
				success: function(result){
					if(result=="SUCCESS"){
						alert("데이터가 입력되었습니다.");
						window.opener.location.reload();
						window.self.close();
					}else if(result=="FAILURE"){
						alert("데이터 입력에 실패했습니다.");
						location.href=location.pathname;
					}
				},
				error: function(xhr, textStatus, errorThrown) {
					alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
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
						<input type="text" id="th_addr" name="th_addr" class="form-control" placeholder="주소를 입력하면 좌표를 검색합니다." />
					</td>
				</tr>
				<tr>
					<th>지도 정보</th>
					<td>
						<label for="th_map_lat" class="col-sm-2 text-center">위도</label>
						<div class="col-sm-4">
							<input type="text" id="th_map_lat" name="th_map_lat" class="form-control" readonly />
						</div>
						<label for="th_map_lng" class="col-sm-2 text-center">경도</label>
						<div class="col-sm-4">
							<input type="text" id="th_map_lng" name="th_map_lng" class="form-control" readonly />
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
	</div>
</body>
</html>