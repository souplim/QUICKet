<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"  %>
	
	<style>
		.user {display: flex;}
		.reservUser {display: flex;}
	</style>

    <!--Load the AJAX API-->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <!-- <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script> -->
    <script type="text/javascript">
    
		$(function() {
			
			// 구글 차트 Load the Visualization API and the piechart package.
			google.charts.load('current', {'packages':['corechart']}); // 차트 스타일 - 파이
			google.charts.load('current', {'packages':['bar']}); // 차트 스타일 - 막대
			google.charts.load('current', { 'packages' : ['corechart', 'line'] }); // 차트 스타일 - 선
			
			
			// Set a callback to run when the Google Visualization API is loaded.
			google.charts.setOnLoadCallback(drawChartUserMemberQuit);
			google.charts.setOnLoadCallback(drawChartUserGender);
			google.charts.setOnLoadCallback(drawChartUserAgeGroup);
			google.charts.setOnLoadCallback(drawChartGender);
			google.charts.setOnLoadCallback(drawChartAgeGroup);
			google.charts.setOnLoadCallback(drawChartTicketCnt);
			google.charts.setOnLoadCallback(drawChartShowSales);
			google.charts.setOnLoadCallback(drawChartTicketSales);
			google.charts.setOnLoadCallback(drawChartMonthlySales);
			
			function drawChartUserMemberQuit(){
				$.ajax({
					url : "/admin/stat/userMemberQuitCount",
					type : 'post',
					headers : {
						"Content-Type" : "application/json"
					},
					dataType : "json",
					error : function(xhr, textStatus, errorThrown) {
						alert("시스템에 문제가 있어 잠시 후 다시 진행해주세요.");
					},
					success : function(result) {
						console.log(result);
						
						// Create our data table out of JSON data loaded from server.
						var data = new google.visualization.DataTable(result);
						
						// 차트 상단 제목 설정
						var options = { 
								title : '일반회원 탈퇴회원 비율'							
						};
						
						// 입력값 화면에 뿌려주기
						var chart = new google.visualization.PieChart(document.getElementById('memberQuit_div'));
						chart.draw(data, options);
					},
					async: false
				}).responseText;
			}
			
			function drawChartUserGender(){
				$.ajax({
					url : "/admin/stat/userGenderCnt",
					type : 'post',
					headers : {
						"Content-Type" : "application/json"
					},
					dataType : "json",
					error : function(xhr, textStatus, errorThrown) {
						alert("시스템에 문제가 있어 잠시 후 다시 진행해주세요.");
					},
					success : function(result) {
						console.log(result);
						
						// Create our data table out of JSON data loaded from server.
						var data = new google.visualization.DataTable(result);
						
						// 차트 상단 제목 설정
						var options = { 
								title : '회원 성비'							
						};
						
						// 입력값 화면에 뿌려주기
						var chart = new google.visualization.PieChart(document.getElementById('userGender_div'));
						chart.draw(data, options);
					},
					async: false
				}).responseText;
			}
			
			function drawChartUserAgeGroup(){
				$.ajax({
					url : "/admin/stat/userAgeGroupCnt",
					type : 'post',
					headers : {
						"Content-Type" : "application/json"
					},
					dataType : "json",
					error : function(xhr, textStatus, errorThrown) {
						alert("시스템에 문제가 있어 잠시 후 다시 진행해주세요.");
					},
					success : function(result) {
						console.log(result);
						
						// Create our data table out of JSON data loaded from server.
						var data = new google.visualization.DataTable(result);
						
						// 차트 상단 제목 설정
						var options = { 
								title : '회원 연령비'							
						};
						
						// 입력값 화면에 뿌려주기
						var chart = new google.visualization.PieChart(document.getElementById('userAgeGroup_div'));
						chart.draw(data, options);
					},
					async: false
				}).responseText;
			}
			
			function drawChartGender(){
				$.ajax({
					url : "/admin/stat/genderCnt",
					type : 'post',
					headers : {
						"Content-Type" : "application/json"
					},
					dataType : "json",
					error : function(xhr, textStatus, errorThrown) {
						alert("시스템에 문제가 있어 잠시 후 다시 진행해주세요.");
					},
					success : function(result) {
						console.log(result);
						
						// Create our data table out of JSON data loaded from server.
						var data = new google.visualization.DataTable(result);
						
						// 차트 상단 제목 설정
						var options = { 
								title : '예매자 성비'							
						};
						
						// 입력값 화면에 뿌려주기
						var chart = new google.visualization.PieChart(document.getElementById('gender_div'));
						chart.draw(data, options);
					},
					async: false
				}).responseText;
			}
			
			function drawChartAgeGroup(){
				$.ajax({
					url : "/admin/stat/ageGroupCnt",
					type : 'post',
					headers : {
						"Content-Type" : "application/json"
					},
					dataType : "json",
					error : function(xhr, textStatus, errorThrown) {
						alert("시스템에 문제가 있어 잠시 후 다시 진행해주세요.");
					},
					success : function(result) {
						console.log(result);
						
						// Create our data table out of JSON data loaded from server.
						var data = new google.visualization.DataTable(result);
						
						// 차트 상단 제목 설정
						var options = { 
								title : '예매자 연령비'							
						};
						
						// 입력값 화면에 뿌려주기
						var chart = new google.visualization.PieChart(document.getElementById('ageGroup_div'));
						chart.draw(data, options);
					},
					async: false
				}).responseText;
			}
			
			function drawChartTicketCnt(){
				$.ajax({
					url : "/admin/stat/showTicketCnt",
					type : 'post',
					headers : {
						"Content-Type" : "application/json"
					},
					dataType : "json",
					error : function(xhr, textStatus, errorThrown) {
						alert("시스템에 문제가 있어 잠시 후 다시 진행해주세요.");
					},
					success : function(result) {
						console.log(result);
						
						// Create our data table out of JSON data loaded from server.
						var data = new google.visualization.DataTable(result);
						
						// 차트 상단 제목 설정
						var options = { 
								title : '공연별 예매율'								
						};
						
						// 입력값 화면에 뿌려주기
						var chart = new google.charts.Bar(document.getElementById('ticketCnt_div'));
						chart.draw(data, google.charts.Bar.convertOptions(options));
					},
					async: false
				}).responseText;
			}
			
			function drawChartShowSales(){
				$.ajax({
					url : "/admin/stat/showSales",
					type : 'post',
					headers : {
						"Content-Type" : "application/json"
					},
					dataType : "json",
					error : function(xhr, textStatus, errorThrown) {
						alert("시스템에 문제가 있어 잠시 후 다시 진행해주세요.");
					},
					success : function(result) {
						console.log(result);
						
						// Create our data table out of JSON data loaded from server.
						var data = new google.visualization.DataTable(result);
						
						// 차트 상단 제목 설정
						var options = { 
							title : '공연별 매출비율', 
							series: {
					            0: { color: '#e2431e' }
					        }
						};
						
						// 입력값 화면에 뿌려주기
						var chart = new google.charts.Bar(document.getElementById('showSales_div'));
						chart.draw(data, google.charts.Bar.convertOptions(options));
					},
					async: false
				}).responseText;
				
			}
			
			function drawChartTicketSales(){
				$.ajax({
					url : "/admin/stat/showTicketSales",
					type : 'post',
					headers : {
						"Content-Type" : "application/json"
					},
					dataType : "json",
					error : function(xhr, textStatus, errorThrown) {
						alert("시스템에 문제가 있어 잠시 후 다시 진행해주세요.");
					},
					success : function(result) {
						console.log(result);
						
						// Create our data table out of JSON data loaded from server.
						var data = new google.visualization.DataTable(result);
						
						// 차트 상단 제목 설정
						var options = { title : '공연별 예매율, 매출비율' };
						
						// 입력값 화면에 뿌려주기
						var chart = new google.charts.Bar(document.getElementById('ticketSales_div'));
						chart.draw(data, google.charts.Bar.convertOptions(options));
					},
					async: false
				}).responseText;
				
			}
			
			function drawChartMonthlySales(){
				$.ajax({
					url : "/admin/stat/monthlySales",
					type : 'post',
					headers : {
						"Content-Type" : "application/json"
					},
					dataType : "json",
					error : function(xhr, textStatus, errorThrown) {
						alert("시스템에 문제가 있어 잠시 후 다시 진행해주세요.");
					},
					success : function(result) {
						console.log(result);
						
						// Create our data table out of JSON data loaded from server.
						var data = new google.visualization.DataTable(result);
						
						// 차트 상단 제목 설정
						var options = {
							title : '월별 매출액'
						};
						
						// 입력값 화면에 뿌려주기
						var chart = new google.visualization.LineChart(document.getElementById('monthlySales_div'));
						chart.draw(data, options);
					},
					async: false
				}).responseText;
			}
			
		});
	</script>
  </head>

  <body>
    <!--Div that will hold the pie chart-->
    <div class="user">
    	 <div id="memberQuit_div" style="width: 900px; height: 500px;"></div>
    	 <div id="userGender_div" style="width: 900px; height: 500px;"></div>
    	<div id="userAgeGroup_div" style="width: 900px; height: 500px;"></div>
    </div>
    <div class="reservUser">
    	 <div id="gender_div" style="width: 900px; height: 500px;"></div>
    	<div id="ageGroup_div" style="width: 900px; height: 500px;"></div>
    </div>
    <div id="ticketCnt_div" style="height: 400px;"></div>
    <div id="showSales_div" style="height: 400px;"></div>
    <div id="ticketSales_div" style="height: 400px;"></div>
    <div id="monthlySales_div" style="height: 500px;"></div>
  </body>
</html>