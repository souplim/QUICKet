<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
</head>
	<body>
		<div class="container">
		
			<div class="row">
				<!-- 메인 페이지 슬라이드 기능 구현 -->
				<div id="mainPage-slide" class="carousel slide" data-ride="carousel">
					<!-- 인디케이터 -->
					<ol class="carousel-indicators">
						<li data-target="#mainPage-slide" data-slide-to="0" class="active"></li>
						<li data-target="#mainPage-slide" data-slide-to="1"></li>
						<li data-target="#mainPage-slide" data-slide-to="2"></li>
						<li data-target="#mainPage-slide" data-slide-to="3"></li>
						<li data-target="#mainPage-slide" data-slide-to="4"></li>
					</ol>
				
					<!-- 내부에 들어갈 아이템 -->
					<div class="carousel-inner" role="listbox">
						<div class="item active">
							<div style="background-color:black; width:100%; height:600px">
								<p>캐러셀 기능 테스트용 슬라이드1</p>
							</div>
						</div>
						<div class="item">
							<div style="background-color:white; width:100%; height:600px">
								<p>캐러셀 기능 테스트용 슬라이드2</p>
							</div>
						</div>
						<div class="item">
							<div style="background-color:red; width:100%; height:600px">
								<p>캐러셀 기능 테스트용 슬라이드3</p>
							</div>
						</div>
						<div class="item">
							<div style="background-color:gray; width:100%; height:600px">
								<p>캐러셀 기능 테스트용 슬라이드4</p>
							</div>
						</div>
						<div class="item">
							<div style="background-color:blue; width:100%; height:600px">
								<p>캐러셀 기능 테스트용 슬라이드5</p>
							</div>
						</div>					
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
						평점 순 랭킹이 들어갈 패널입니다.
					</div>
					<div role="tabpanel" class="tab-pane" id="ticketRank">
						예매율 순 랭킹이 들어갈 패널입니다.
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
						신작이 들어갈 패널입니다.
					</div>
				</div>

			</div>
			
		</div>
	</body>
</html>