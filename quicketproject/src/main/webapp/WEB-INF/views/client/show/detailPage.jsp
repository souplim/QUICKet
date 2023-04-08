<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<style type="text/css">
.detailImgHolder>img{max-width:100%;}
.showBox_detail{
	box-shadow:10px 10px 20px 3px rgb(123,123,123,0.5);
	padding:30px 50px 50px 50px;
}
.showBox_detail_genre{font-size:16px; font-weight:bold;}
.showBox_detail_genre a{color: #888;}
.showBox_detail_title{margin-left:5px;}
.showBox_detail_title h1{font-weight:bold;}
.showBox_detail_text table{font-size:16px;}
.showBox_detail_text tr{border-style:hidden; height:50px}
.showBox_detail_text th{width:120px}
#theaterBox th{text-align:center;}
#theaterBox td{text-align:left;}
div[role="tabpanel"]{min-height:30em;}
#casting_box{
	box-shadow:10px 10px 20px 3px rgb(123,123,123,0.5);
	padding:20px 30px 30px 50px;
	margin-top:30px;
}
#casting_box p{font-size:24px; font-weight:bold;}
#casting_box table{
	border-spacing:30px;
	font-size:16px;
}
#casting_box th, td{
	padding: 10px;
}
.nav-pills>li{
	text-align:center;
	width:150px;
}
.nav-pills>li+li{
    margin-left: 0px;
}
.nav-pills>li>a{
	color: gray;
    border-radius: 4px 4px 0px 0px;
    border-bottom: 2px solid rgb(120,120,120,0.3);
}
.nav-pills>li.active>a{
    color: black;
    background-color: transparent;
    border-top: 2px solid rgb(120,120,120,0.3);
    border-left: 2px solid rgb(120,120,120,0.3);
    border-right: 2px solid rgb(120,120,120,0.3);
    border-bottom: none;
}
.nav-pills>li.active>a:focus, .nav-pills>li.active>a:hover{
	background-color: #eee;
}
.tab-content{
	padding:100px 0px 50px 0px;
}
</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3dc7376a2cb1e4f12306eaaebe2593e4"></script>
<script type="text/javascript" src="/resources/include/js/theaterMap.js"></script>
<script type="text/javascript">
	$(function(){
		let s_actor_str = "<c:out value='${detailData.s_actor}' />";
		if(s_actor_str!=""){
			let $txt = $("<textarea></textarea>");
			$txt.html(s_actor_str)
			let s_actor_txt = $txt.val();
			let s_actor = JSON.parse(s_actor_txt);
			let $castingTable = $("<table>");
			$(s_actor).each(function(){
				let $castingTr = $("<tr><th>"+this.role+"</th><td>"+this.actor+"</td></tr>")
				$castingTable.append($castingTr);
			})
			$("#casting_box").append($("<p>캐스팅</p><br/>"))
			$("#casting_box").append($castingTable);
		}

		$("a[aria-controls='theaterBox']").on("shown.bs.tab", function(){
			let th_num = Number("<c:out value='${detailData.th_num}' />");		
			$.ajax({
				url:"/theater/theaterOne",
				type:"post",
				headers:{
					"Content-Type":"application/json"
				},
				dataType:"text",
				data: JSON.stringify({
					th_num:th_num
				}),
				success:function(result){
					let theater = JSON.parse(result);
					
					$("#th_name").html(theater.th_name);
					$("#th_addr").html(theater.th_addr);
					$("#th_web").html(theater.th_web);
					
					let th_name = theater.th_name;
					let th_map_lat = theater.th_map_lat;
					let th_map_lng = theater.th_map_lng;
					
	
					makemap("th_map", th_map_lat, th_map_lng, th_name, "100%", "500px");
				},
				error:function(xhr, textStatus, errorThrown){
					alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
				}
			})
		})
		
		let u_id = "${userLogin.u_id}";
	
		/* 관심공연 담기 버튼 클릭시 이벤트 처리 */
		$(".likes").on("click", function(){
			let u_id = "${userLogin.u_id}";
			console.log(u_id);
			if(u_id == "") {
				alert("로그인 후 이용해주세요.");
				let s_num = $("#s_num").val();
				location.href="/showDetail?s_num="+s_num;
				
			} else {
				let likes = "";
				
				if($(this).hasClass("addLikes")){
					likes = "on";
				} else {
					likes = "off";
				}
				console.log(likes);
				const data = {
					s_num : $("#s_num").val(),
					likes : likes
				}
				
				$.ajax({
					url : "/mypage/likes",
					type : "POST",
					data : data,
					error : function(xhr, textStatus, errorThrown){
						alert("시스템에 문제가 있어 잠시 후 다시 진행해주세요.");
					},
					success : function(result){
						console.log(result);
						if(result=="SUCCESS"){
							if(likes=="on"){
								// 관심공연담기 버튼 클릭시 관심공연등록 처리후 관심공연페이지로 이동할지 물어보는 모달창
								$('#myLikesModal').on('shown.bs.modal', function () {
								  $('#myInput').focus();
								});
							} else {
								// 관심공연 해제 버튼 클릭시 뜨는 모달창
								$('#myCancelLikesModal').on('shown.bs.modal', function () {
								  $('#myInput').focus();
								});
								
							}
						}
					}
				});
			}
			
		});
			
		
		/* 나의관심공연 버튼 클릭시 이벤트 처리 */
		$("#myLikesBtn").on("click", function(){
			location.href="/mypage/myLikeList";
		});
		
		/* 나의 관심공연 버튼 클릭시 뜨는 모달창에서 닫기 버튼 클릭시 처리 이벤트 */
		$(".detailReload").on("click", function(){
			let s_num = $("#s_num").val();
			console.log(s_num);
			
			// 디테일 페이지 리로드
			location.href="/showDetail?s_num="+s_num;
		}); 
		
		/* 마이페이지 관람후기 제목 클릭해서 유입 -> 관람후기 탭 열기 */
		if(location.hash == "#reviewBox"){
			$(".nav-pills").find("li").eq(2).addClass('active').siblings().removeClass();
			$(".tab-content").find("#reviewBox").addClass("active").siblings().removeClass('active');
			
			/* const url = new URL(window.location);
	        const urlParams = url.searchParams;
	        if(urlParams.get('s')) { // 특정 파라미터값 얻기
	            const scrollTop = $('#'+urlParams.get('s')).offset().top; // 화면상에서 특정 요소의 y축 위치
	          
	          	// 부드럽게 이동
	            $('html, body').animate({scrollTop: scrollTop-59}, 2000,'easeOutCubic');
	        } */
		} 
		
	});
</script>
</head>
<body>
	<%-- ================= 관심공연 담기 버튼 클릭시 모달창 내용 ================= --%>
	<div class="modal fade" id="myLikesModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">QUICKet 관심공연 담기</h4>
	      </div>
	      <div class="modal-body">
	        <p>관심공연에 담겼습니다.<br/>나의 관심공연에서 확인해주세요.<br/>바로확인하시겠습니까?</p>
	      </div>
	      <div class="modal-footer">
	      	<button type="button" class="btn btn-primary" id="myLikesBtn">나의관심공연</button>
	        <button type="button" class="btn btn-default detailReload">닫기</button>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
	<%-- ================= 관심공연 해제 버튼 클릭시 모달창 내용 ================= --%>
	<div class="modal fade" id="myCancelLikesModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">QUICKet 관심공연 해제</h4>
	      </div>
	      <div class="modal-body">
	        <p>관심공연에서 해제되었습니다.</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary detailReload">확인</button>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
		
	<br/><br/>
	<div class="container">
		<div class="showBox_detail row">
			<div class="showBox_detail_genre row">
				<p>장르> <a href="/genre?s_genre=${detailData.s_genre}">${detailData.s_genre}</a></p>
			</div>
			<div class="showBox_detail_title row">
				<h1>${detailData.s_name}</h1>
			</div>
			<br />
			<div class="row">
				<div class="showBox_thumbnail detailImgHolder col-sm-3">
					<img src=
					<c:if test="${detailData.s_posterimg ne null}">
						"/uploadStorage${detailData.s_posterimg.img_dir}/${detailData.s_posterimg.img_name}.${detailData.s_posterimg.img_type}"
					</c:if>
					<c:if test="${detailData.s_posterimg eq null}">
						"/uploadStorage/show/poster_default.jpg"
					</c:if>
					class="showBox_img" />
				</div>
				<div class="showBox_detail_text col-sm-7 col-sm-offset-2">
					<table class="table">
						<tr>
							<th>장소</th>
							<td>${detailData.th_name}</td>
						</tr>
						<tr>
							<th>기간</th>
							<td>${detailData.s_opendate} ~ ${detailData.s_closedate}</td>
						</tr>
						<tr>
							<th>관람시간</th>
							<td>${detailData.s_time}분</td>
						</tr>
						<tr>
							<th>주최·주관</th>
							<td>${detailData.s_sponsor}</td>
						</tr>
						<tr>
							<th>기획·제작</th>
							<td>${detailData.s_director}</td>
						</tr>
						<tr>
							<th>티켓가격</th>
							<td>${detailData.s_price}원</td>
						</tr>						
					</table>
					
					<%-- ================= 데이터 전달 폼 ================= --%>
					<form name="dataForm" id="dataForm">
						<input type="hidden" name="s_num" id="s_num" value="${detailData.s_num}">
					</form>
					
					<%-- ================= 공연 디테일 페이지에 들어갈 관심공연 버튼 ================= --%>
					<div class="contentBtn text-left" >
						<c:choose>
							<c:when test="${myShowLike.is_likes == 1}">
								<button type="button" class="btn btn-danger likes cancelLikes" data-toggle="modal" data-target="#myCancelLikesModal">
									<span class="glyphicon glyphicon-heart-empty" aria-hidden="true"></span> 
										<span class="badge">${mypageVO.likesCount}</span>
								</button>
							</c:when>
							<c:otherwise>
								<button type="button" class="btn btn-default likes addLikes" data-toggle="modal" data-target="#myLikesModal">
									<span class="glyphicon glyphicon-heart" aria-hidden="true"></span> 
										<span class="badge">${mypageVO.likesCount}</span>
								</button>
							</c:otherwise>
						</c:choose> 
					</div>
					
				</div>
				
			</div>
		</div>
		
		<!-- 캐스팅 정보 존재할 때 입력되는 박스 -->
		<c:if test="${not empty detailData.s_actor}">
			<div class="row">
				<div id="casting_box"></div>
			</div>
		</c:if>
		
		<!-- 예매기능 박스 -->
		<div class="ticketBox row">
			<c:import url="/WEB-INF/views/client/ticket/showDetail.jsp" />
		</div>
		<br/><br/>
		<!-- 상세페이지 탭 기능 구현 -->
		<div class="detail_tabBox row">
			<div class="row">
				<div class="col-xs-10 col-xs-offset-1">
					<!-- Navi 형 탭리스트 -->
					<ul class="nav nav-pills" role="tablist">
						<li role="presentation" class="active">
							<a href="#detailimgBox" aria-controls="detailimgBox" role="tab" data-toggle="tab">공연 소개</a>
						</li>
						<li role="presentation">
							<a href="#theaterBox" aria-controls="theaterBox" role="tab" data-toggle="tab">공연장 안내</a>
						</li>
						<li role="presentation">
							<a href="#reviewBox" aria-controls="reviewBox" role="tab" data-toggle="tab">관람 후기</a>
						</li>
						<li role="presentation">
							<a href="#expectBox" aria-controls="expectBox" role="tab" data-toggle="tab">기대평</a>
						</li>
						<li role="presentation">
							<a href="#qnaBox" aria-controls="qnaBox" role="tab" data-toggle="tab">Q&A</a>
						</li>
						<li role="presentation">
							<a href="#guideBox" aria-controls="guideBox" role="tab" data-toggle="tab">안내사항</a>
						</li>					
					</ul>
				</div>
			</div>	
			<!-- 탭의 컨텐츠를 표시하는 각 패널 부분 -->
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane active" id="detailimgBox">
					<div class="row text-center detailImgHolder">
						<c:if test="${detailData.s_detailimg ne null and not empty detailData.s_detailimg}"></c:if>
						<c:forEach var="detailimg" items="${detailData.s_detailimg}">
							<c:if test="${detailimg ne null}">
								<img class="showBox_img" src="/uploadStorage${detailimg.img_dir}/${detailimg.img_name}.${detailimg.img_type}" />
							</c:if>
						</c:forEach>
					</div>
				</div>
				<div role="tabpanel" class="tab-pane" id="theaterBox">
					<div class="row">
						<div class="row">
							<h3 id="th_name"></h3>
						</div>
						<br />
						<div class="row">
							<table class="table table-bordered">
								<tr>
									<th>주소</th>
									<td id="th_addr"></td>
								</tr>
								<tr>
									<th>웹사이트</th>
									<td id="th_web"></td>
								</tr>
								<tr>
									<th colspan="2">공연장 지도</th>
								</tr>
								<tr>
									<td colspan="2">
										<div id="th_map"></div>
									</td>
								</tr>						
							</table>
						</div>

					</div>
				</div>
				<div role="tabpanel" class="tab-pane" id="reviewBox">
					<div class="row">
						<c:import url="/WEB-INF/views/client/review/reviewList.jsp" />
					</div>
				</div>
				<div role="tabpanel" class="tab-pane" id="expectBox">
					<div class="row">
						<c:import url="/WEB-INF/views/client/expect/expectList.jsp" />
					</div>
				</div>
				<div role="tabpanel" class="tab-pane" id="qnaBox">
					<div class="row"></div>
				</div>
				<div role="tabpanel" class="tab-pane" id="guideBox">
					<div class="row text-center">
						<div id="s_guide">${detailData.s_guide}</div>
					</div>
				</div>															
			</div>
		</div>
	</div>

</body>
</html>