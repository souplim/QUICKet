<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js" integrity="sha512-T/tUfKSV1bihCnd+MxKD0Hm1uBBroVYBOYSk1knyvQ9VyZJpc/ALb4P0r6ubwVPSGB2GvjeoMAJJImBG12TiaQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" integrity="sha512-mSYUmp1HYZDFaVKK//63EcZq4iFWFjxSL+Z3T/aCt4IO9Cejm03q3NKKYN6pFQzY0SBOr8h+eCIAZHPXcpZaNw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
		<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js" integrity="sha512-L4qpL1ZotXZLLe8Oo0ZyHrj/SweV7CieswUODAAPN/tnqN3PA1P+4qPu5vIryNor6HQ5o22NujIcAZIfyVXwbQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
		<script type="text/javascript">
			$(function(){
				$("#datepicker").datepicker({
					language:"ko"
				});
				$("#datepicker").on("changeDate", function(){
					$("#date_value").val(
						$("#datepicker").datepicker("getFormattedDate")
					)
				})
			})
		</script>
	
	</head>
	<body>
		<div class="container">
		<br/><br/><br/>
			<div class="row">
				<form class="form-horizontal">
					<div class="form-group">
						<div class="col-sm-2 col-sm-offset-2">
							<select class="form-control">
								<option>공연명</option>
								<option>공연장명</option>
							</select>
						</div>
						<div class="col-sm-4">
							<input type="text" class="form-control" />
						</div>
						<div class="col-sm-1">
							<button type="button" class="form-control btn btn-default"> 검색 </button>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-2 col-sm-offset-2">
							<div id="datepicker"></div>
							<input type="hidden" id="date_value" />	
							<br/>
							<select class="form-control">
								<option>지역</option>
								<option>서울</option>
								<option>경기</option>								
							</select>	
						</div>
						<div class="col-sm-4 col-sm-offset-1">
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
					</div>
				</form>
			</div>
	
		</div>

	</body>
</html>