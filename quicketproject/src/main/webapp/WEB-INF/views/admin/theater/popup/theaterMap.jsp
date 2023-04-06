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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3dc7376a2cb1e4f12306eaaebe2593e4"></script>
<script type="text/javascript" src="/resources/include/js/theaterMap.js"></script>
<script type="text/javascript">
	$(function(){
		
		let th_name = "${theaterVO.th_name}";
		let th_map_lat = ${theaterVO.th_map_lat};
		let th_map_lng = ${theaterVO.th_map_lng};
		
		makemap("th_map", th_map_lat, th_map_lng, th_name, "100%", "400px");
	    
		$("#returnBtn").click(function(){
			window.self.close();	
		})
	})
</script>
</head>
<body>
	<br/><br/>
	<div class="container">
		<div class="row">
			<div class="col-xs-10 col-xs-offset-1">
			<table class="table table-bordered">
				<tr>
					<th class="col-sm-4">공연장 이름</th>
					<td class="col-sm-8">
						<div class="col-sm-12">${theaterVO.th_name}</div>
					</td>
				</tr>
				<tr>
					<th>지도 정보</th>
					<td>
						<div class="col-sm-6">
							<strong>위도</strong> ${theaterVO.th_map_lat}
						</div>
						<div class="col-sm-6">
							<strong>경도</strong> ${theaterVO.th_map_lng}
						</div>
						
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div id="th_map"></div>
					</td>
				</tr>
			</table>
			</div>
		</div>
		<div class="row"><div class="col-xs-10 col-xs-offset-1 text-right">
			<button type="button" id="returnBtn" class="btn btn-default">돌아가기</button>
		</div></div>
		<br/><br/>
	</div>
</body>
</html>