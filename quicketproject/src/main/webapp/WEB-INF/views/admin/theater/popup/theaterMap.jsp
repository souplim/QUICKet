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
 #th_map{
 	width:100%;
 }
 .info_custom{
 	font-weight:bold;
 	font-size:12px;
 	padding:5px 20px;
 	background-color:#fff;
 	border:2px solid #ccc;
 	border-radius:5px;
 }
 
 .info_custom:after {
 	content: '';
 	position: absolute;
 	margin-left: -12px;
 	left: 50%;
 	bottom: -10px;
 	width: 22px;
 	height: 12px;
 	background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
 }
</style>
<script type="text/javascript" src="/resources/include/js/common.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3dc7376a2cb1e4f12306eaaebe2593e4"></script>
<script type="text/javascript">
	$(function(){
		//지도가 들어갈 박스 지정
		container = document.getElementById("th_map");
		
		//박스 자동 리사이징 
		$("#th_map").css("height",$("#th_map").css("width"));
		$(window).resize(function(){
			$("#th_map").css("height",$("#th_map").css("width"));
		})
		
		//위도 경도 불러와서 초기좌표 및 지도 초기 확대레벨 지정
		let th_map_lat = ${theaterVO.th_map_lat};
		let th_map_lng = ${theaterVO.th_map_lng};
		options = {center: new kakao.maps.LatLng(th_map_lat, th_map_lng),level:3}; 
		
		//지도 객체 생성 및 컨트롤러 부여
		map = new kakao.maps.Map(container, options);
		mapTypeControl = new kakao.maps.MapTypeControl();
		map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
		var zoomControl = new kakao.maps.ZoomControl();
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
		
		//지도에 해당 공연장 위치 마커 생성
		markerPosition  = new kakao.maps.LatLng(th_map_lat, th_map_lng);
		marker = new kakao.maps.Marker({position: markerPosition});
		marker.setMap(map);
		
		//커스텀오버레이로 마커 해설 윈도우 붙이기
		let th_name = "${theaterVO.th_name}";
		let content = "<div class='info_custom'>"+th_name+"</div>"
		let position  = new kakao.maps.LatLng(th_map_lat, th_map_lng);
	    customOverlay = new kakao.maps.CustomOverlay({position: position, content: content, map: map, yAnchor:2.6});
	    kakao.maps.event.addListener(marker, 'mouseover', function(){
	    	customOverlay.setMap(map)
	    });
	    kakao.maps.event.addListener(marker, 'mouseout', function(){
	    	customOverlay.setMap(null)
	    });
	    
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