<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<style type="text/css">
#showBox_template{
	display:none;
}
.showBox{
	padding:10px;
	text-align:center
}
.showBox_img{
	width:100%;
	margin:0px 0px 10px 0px;
}
.showBox_thumbnail{
	display:inline-block;
}
.showBox_text{
	display:inline-block;
	text-align:center;
}
</style>
<script type="text/javascript">
$(function(){
	
	$.getJSON("/mainSlideList",function(data){
		let $indicators = $("#mainPage-slide").find(".carousel-indicators");
		let $inner = $("#mainPage-slide").find(".carousel-inner");
		$(data).each(function(index){			
			let $imgBox = $("<div>");
			let $img = $("<img />");
			
			let img_url="";
			if(this.s_posterimg!=null){				
				img_url = "/uploadStorage/"+this.s_posterimg.img_dir+"/"+this.s_posterimg.img_name+"."+this.s_posterimg.img_type;
			}			
			$img.addClass("slide_img");
			if(img_url!=""){
				$img.attr("src", img_url);
			}else{
				img_url="/uploadStorage/show/poster_default.jpg"
				$img.attr("src", img_url);
			}
			$imgBox.css({
				width:"100%",
				height:"600px",
				backgroundImage:"url("+img_url+")",
				backgroundSize:"cover"
			})
			
			if(index==0){
				let $item = $(".item")
				$imgBox.append($img);
				$item.append($imgBox);
			}else{
				let $item = $("<div class='item'></div>");
				$imgBox.append($img);
				$item.append($imgBox);
				$inner.append($item);
				let $idc = $("<li data-target='#mainPage-slide' data-slide-to='"+index+"'>")
				$indicators.append($idc)
			}
		})
	})
	
	
	//전체 평점 랭킹 5개 받아오기
	$.getJSON("/mainPointRankList",function(data){
		$(data).each(function(){
			makeShowBox(this, "#mainPointRankPanel", "s_point", "2");
		})
	}).fail(function(){alert("메인페이지 로딩 중에 오류가 발생했습니다. 관리자에게 문의하세요.")})
	
	//이번 주 예매율 랭킹 5개 받아오기
	$.getJSON("/mainTicketRankList",function(data){
		$(data).each(function(){
			makeShowBox(this, "#mainTicketRankPanel", "rank_ticket", "2");
		})
	}).fail(function(){alert("메인페이지 로딩 중에 오류가 발생했습니다. 관리자에게 문의하세요.")})
	
	//이번 주 개봉되는 공연 리스트 5개 받아오기
	$.getJSON("/mainNewList",function(data){
		$(data).each(function(){
			makeShowBox(this, "#mainNewPanel", "s_opendate", "2");
		})
	}).fail(function(){alert("메인페이지 로딩 중에 오류가 발생했습니다. 관리자에게 문의하세요.")})
	
	
	function makeShowBox(vo, panel, sub, size){
		let $panel = $(panel);
		
		let $showBox = $("#showBox_template").clone().removeAttr("id");
		$showBox.addClass("col-xs-"+size);
		let s_num = vo.s_num;
		$showBox.attr("data-num", s_num);
		
		let s_name = vo.s_name;
		
		let subtxt ='';
		if(sub=='rank_ticket'){
			subtxt = vo.rank_ticket+"%";
		}else if(sub=='s_opendate'){
			subtxt = vo.s_opendate;
		}else if(sub=='s_point'){
			subtxt = vo.s_point;
		}
		
		let $title = $("<p class='showBox_title'>"+s_name+"</p>");
		let $subtxt = $("<p class='showBox_subtxt'>"+subtxt+"</p>");
		$showBox.find(".showBox_text").append($title).append($subtxt);
		
		let $poster = $("<img />");
		let poster_url="";
		if(vo.s_posterimg!=null){
			let poster_img = vo.s_posterimg;
			let poster_dir = poster_img.img_dir;
			let poster_name = poster_img.img_name;
			let poster_type = poster_img.img_type;
			
			poster_url = "/uploadStorage/"+poster_dir+"/"+poster_name+"."+poster_type;
		}
		
		$poster.addClass("showBox_img");
		if(poster_url!=""){
			$poster.attr("src", poster_url);
		}else{
			poster_url="/uploadStorage/show/poster_default.jpg"
			$poster.attr("src", poster_url);
		}
		
		let $link = $("<a href='/showDetail?s_num="+s_num+"'></a>");	
		$link.append($poster);
		
		$showBox.find(".showBox_thumbnail").append($link);
		
		$panel.append($showBox);
	}
	
})
</script>
</head>
	<body>
		<div class="container">
		
			<div class="row">
				<!-- 메인 페이지 슬라이드 기능 구현 -->
				<div id="mainPage-slide" class="carousel slide" data-ride="carousel">
					<!-- 인디케이터 -->
					<ol class="carousel-indicators">
						<li data-target="#mainPage-slide" data-slide-to="0" class="active"></li>
					</ol>
				
					<!-- 내부에 들어갈 아이템 -->
					<div class="carousel-inner" role="listbox">
						<div class="item active"></div>				
					</div>
					
					<!-- 슬라이드 버튼 -->
					<a class="carousel-control left" href="#mainPage-slide" role="button" data-slide="prev">
						<span class="glyphicon glyphicon-chevron-left" aria-hidden="false"></span>
						<span class="sr-only">이전 페이지</span>
					</a>
					<a class="carousel-control right" href="#mainPage-slide" role="button" data-slide="next">
						<span class="glyphicon glyphicon-chevron-right" aria-hidden="false"></span>
						<span class="sr-only">다음 페이지</span>
					</a>
				</div>
			</div>
			
			<br/><br/><br/>
			
			<!-- 랭킹박스 탭 기능 구현 -->
			<div class="row">
			
				<!-- Navi 형 탭리스트 -->
				<ul class="nav nav-tabs" role="tablist">
					<li class="disabled">
						<a href="#">WEEK RANKING</a>
					</li>
					<li role="presentation" class="active">
						<a href="#pointRank" aria-controls="pointRank" role="tab" data-toggle="tab">평점순</a>
					</li>
					<li role="presentation">
						<a href="#ticketRank" aria-controls="ticketRank" role="tab" data-toggle="tab">예매율순</a>
					</li>
				</ul>
				<!-- 탭의 컨텐츠를 표시하는 각 패널 부분 -->
				<div class="tab-content">
					<div role="tabpanel" class="tab-pane active" id="pointRank">
						<div id="mainPointRankPanel"></div>
					</div>
					<div role="tabpanel" class="tab-pane" id="ticketRank">
						<div id="mainTicketRankPanel">
							
						</div>
					</div>
				</div>

			</div>
			
			<br/><br/><br/>
			
			<!-- 신작 박스 구현 -->
			<div class="row">
			
				<!-- Navi 형 탭리스트 -->
				<ul class="nav nav-tabs" role="tablist">
					<li class="disabled">
						<a href="#">WEEK NEW</a>
					</li>
				</ul>
				<!-- 탭의 컨텐츠를 표시하는 각 패널 부분 -->
				<div class="tab-content">
					<div role="tabpanel" class="tab-pane active" id="weekNew">
						<div id="mainNewPanel" class="row">
						</div>
					</div>
				</div>

			</div>
			
		</div>

		<!-- 공연 박스 템플릿 -->
		<div id="showBox_template" class="showBox">
			<div class="showBox_thumbnail">
			</div>
			<div class="showBox_text"></div>
		</div>
		
	</body>
</html>