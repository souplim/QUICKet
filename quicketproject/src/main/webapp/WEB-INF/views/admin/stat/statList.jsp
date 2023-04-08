<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"  %>

    <!--Load the AJAX API-->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <!-- <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script> -->
    <script type="text/javascript">
    
		$(function() {
			
			// 구글 차트 Load the Visualization API and the piechart package.
			google.charts.load('current', {'packages':['bar']}); // 차트 스타일 - 막대
			google.charts.load('current', { 'packages' : ['corechart', 'line'] }); // 차트 스타일 - 선
			
			// Set a callback to run when the Google Visualization API is loaded.
			google.charts.setOnLoadCallback(drawChartTicketCnt);
			google.charts.setOnLoadCallback(drawChartShowSales);
			google.charts.setOnLoadCallback(drawChartTicketSales);
			google.charts.setOnLoadCallback(drawChartMonthlySales);
			
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
						var options = { title : '공연별 예매율' };
						
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
							title : '공연별 매출비율'	, 
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
							title : '월별 매출액',
							annotations : {
								boxStyle: {
									
								}
							}
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
    <div id="ticketCnt_div" style="width: 800px; height: 400px;"></div>
    <div id="showSales_div" style="width: 800px; height: 400px;"></div>
    <div id="ticketSales_div" style="width: 800px; height: 400px;"></div>
    <div id="monthlySales_div" style="width: 800px; height: 500px;"></div>
  </body>
</html>