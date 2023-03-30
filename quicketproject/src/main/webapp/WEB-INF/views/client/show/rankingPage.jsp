<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<style type="text/css">
#start_date, #end_date{
	display:none;
}
#datelabel{
	font-size:20px;
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js" integrity="sha512-T/tUfKSV1bihCnd+MxKD0Hm1uBBroVYBOYSk1knyvQ9VyZJpc/ALb4P0r6ubwVPSGB2GvjeoMAJJImBG12TiaQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" integrity="sha512-mSYUmp1HYZDFaVKK//63EcZq4iFWFjxSL+Z3T/aCt4IO9Cejm03q3NKKYN6pFQzY0SBOr8h+eCIAZHPXcpZaNw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js" integrity="sha512-L4qpL1ZotXZLLe8Oo0ZyHrj/SweV7CieswUODAAPN/tnqN3PA1P+4qPu5vIryNor6HQ5o22NujIcAZIfyVXwbQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript">
	$(function(){
		//화면 시작시에 필요없는 컴포넌트 숨김 처리
		let s_array ="<c:out value='${rankVO.s_array}' />"
		if(s_array=='s_point'){
			$("#dateSelect").hide();
			$("#periodNav").hide();
		}
		
		
		
	})
</script>
</head>
<body>
	<div class="container">
		<br/>
		<div class="row">
			<div class="col-xs-4 col-xs-offset-4">
			<div class="btn-group btn-group-justified">
				<div class="btn-group btn-group-lg" role="group">
				  <button type="button" class="btn btn-default">전체</button>
				</div>
				<div class="btn-group btn-group-lg" role="group">
				  <button type="button" class="btn btn-default">뮤지컬</button>
				</div>
				<div class="btn-group btn-group-lg" role="group">
				  <button type="button" class="btn btn-default">연극</button>
				</div>
			</div>
			</div>
		</div>
		<br/><br/>
		<div class="row">
			<div class="form-group">
				<div class="col-sm-2">
					<select id="s_array" name="s_array" class="form-control">
						<option value="rank_ticket">예매율순</option>
						<option value="s_point">평점순</option>							
					</select>						
				</div>	
				<div id="dateSelect" class="col-sm-4 col-sm-offset-2 text-center">
					<label for="start_date" id="datelabel">▼ 날짜 입력하기</label>
					<input type="date" id="start_date" name="start_date" />
					<input type="date" id="end_date" name="end_date" />
				</div>				
				<div id="periodNav" class="col-sm-3 col-sm-offset-1">
					<ul class="nav nav-pills">
						<li role="presentation" ><a href="#">일간</a></li>
						<li role="presentation" class="active"><a href="#">주간</a></li>
						<li role="presentation"><a href="#">월간</a></li>
						<li role="presentation"><a href="#">연간</a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="row">
			<div id="top3list"></div>
		</div>
		<div class="row">
			<div id="otherlist"></div>
		</div>
	</div>

</body>
</html>