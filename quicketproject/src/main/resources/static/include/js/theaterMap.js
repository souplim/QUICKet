/**
 * 
 */

 function makemap(item, lat, lng, txt, width, height){
	//지도가 들어갈 박스 지정
	container = document.getElementById(item);
	
	$("#"+item).css({
		"width":width, "height":height
	})
	
	//위도 경도 불러와서 초기좌표 및 지도 초기 확대레벨 지정
	let theater_pos = new kakao.maps.LatLng(lat, lng)
	options = {center: theater_pos,level:3}; 
	
	//지도 객체 생성 및 컨트롤러 부여
	map = new kakao.maps.Map(container, options);
	mapTypeControl = new kakao.maps.MapTypeControl();
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
	zoomControl = new kakao.maps.ZoomControl();
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
	
	//지도에 해당 공연장 위치 마커 생성
	marker = new kakao.maps.Marker({position: theater_pos});
	marker.setMap(map);
	
	//커스텀오버레이로 마커 해설 윈도우 붙이기
	let content = "<div><div class='info_custom_before'></div><div class='info_custom'>"+txt+"</div><div class='info_custom_after'></div></div>"
	
	customOverlay = new kakao.maps.CustomOverlay({position: theater_pos, content: content, map: map, yAnchor:2.6});
	info_css('.info_custom');
	kakao.maps.event.addListener(marker, 'mouseover', function(){
    	customOverlay.setMap(map)
    });
    kakao.maps.event.addListener(marker, 'mouseout', function(){
    	customOverlay.setMap(null)
    });
    
	//박스 좌표 재설정
	$(window).resize(function(){
		map.setCenter(theater_pos);
	})
	
	//커스텀 말풍선 css 적용하는 함수
	function info_css(item){
	    let item_css = {
				"fontWeight":"bold",
				"fontSize":"12px",
				"padding":"5px 20px",
				"backgroundColor":"#fff",
				"border":"2px solid #ccc",
				"borderRadius":"5px"
		}
		let item_before_css = {
				"position":"absolute",
				"width":"0",
				"height":"0",
				"borderTop":"10px solid #ccc",
			 	"borderLeft":"5px solid transparent",
	 			"borderRight":"5px solid transparent",
	 			"left":"50%",
	 			"top":"99%",
	 			"transform": "translateX(-5px)"
		}
		let item_after_css = {
				"position":"absolute",
				"width":"0",
				"height":"0",
				"borderTop":"10px solid #fff",
			 	"borderLeft":"5px solid transparent",
	 			"borderRight":"5px solid transparent",
	 			"left":"50%",
	 			"top":"88%",
	 			"transform": "translateX(-5px)"
		}
	    
	    $(item).css(item_css);
	    $(item+"_before").css(item_before_css);
	    $(item+"_after").css(item_after_css);
	}
}