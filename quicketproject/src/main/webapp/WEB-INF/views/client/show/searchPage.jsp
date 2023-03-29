<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<style type="text/css">
#showBox_template{
	display:none;
}
.showBox_search{
	margin:10px 0px;
	padding:20px 10px 10px 10px;
	text-align:center;
	border:1px solid #ccc;
}
.showBox_img{
	width:100%;
	margin:0px 0px 10px 0px;
}
.showBox_thumbnail{
	display:inline-block;
}
.showBox_search_text{
	display:inline-block;
	text-align:left;
}
#datelabel{
	font-size:20px;
}
#start_date, #end_date{
	display:none;
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js" integrity="sha512-T/tUfKSV1bihCnd+MxKD0Hm1uBBroVYBOYSk1knyvQ9VyZJpc/ALb4P0r6ubwVPSGB2GvjeoMAJJImBG12TiaQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" integrity="sha512-mSYUmp1HYZDFaVKK//63EcZq4iFWFjxSL+Z3T/aCt4IO9Cejm03q3NKKYN6pFQzY0SBOr8h+eCIAZHPXcpZaNw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js" integrity="sha512-L4qpL1ZotXZLLe8Oo0ZyHrj/SweV7CieswUODAAPN/tnqN3PA1P+4qPu5vIryNor6HQ5o22NujIcAZIfyVXwbQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript">
	$(function(){
		
		/* 검색 후 검색 대상과 검색 단어 출력 - 검색 여부는 키워드(keyword)의 값 존재여부로 제어*/
		let word = "<c:out value='${showVO.keyword}' />";
		if(word!=""){
			$("#keyword").val("<c:out value='${showVO.keyword}' />");
			$("#search").val("<c:out value='${showVO.search}' />");
			
			if($("#search").val()=="s_name"){
				$("#list tr td.showname:contains('"+word+"')").each(function(){
					let regex = new RegExp(word,'gi');
					$(this).html($(this).html().replace(regex,"<span class='required'>"+word+"</span>"));
				})
			}
			if($("#search").val()=="th_name"){
				$("#list tr td.theatername:contains('"+word+"')").each(function(){
					let regex = new RegExp(word,'gi');
					$(this).html($(this).html().replace(regex,"<span class='required'>"+word+"</span>"));
				})
			}
		}
		
		/*검색 후 select 위치 맞추기*/
		let array = "<c:out value='${showVO.s_array}' />";
		if(array!=""){
			$("#s_array").val(array).prop("selected",true);
		}
		$("#s_genre").val("<c:out value='${showVO.s_genre}' />")
		let region = "<c:out value='${showVO.s_select_region}' />";
		if(region!=""){
			$("#s_select_region").val(region).prop("selected",true);
		}
		
		
		/*검색 후 오름차순 내림차순 표시 바꾸기*/
		let sortorder = "<c:out value='${showVO.s_sortorder}' />";
		if(sortorder!=""){
			$("#s_sortorder").val(sortorder)
		}
		if(sortorder=="asc"){
			$("#sortlabel").html("오름차순");
		}
		if(sortorder=="desc"){
			$("#sortlabel").html("내림차순");
		}
		
		/* 입력 양식 enter 제거 */
		$("#keyword").bind("keydown", function(event){
			 if (event.keyCode == 13) {
			        event.preventDefault();
			        $("#searchData").click();
			    }
		});
		
		/* 검색 버튼 클릭 시 처리 이벤트 */
		$("#searchData").click(function(){
			if($("#start_date").val()>$("#end_date").val()){
				alert("시작날짜가 종료날짜보다 더 클 수 없습니다.");
				return
			}
			if($("#keyword").val()==""){
				$("#search").val()==""
			}
			if($("#s_array")!="" && $("#sortorder").val()==""){
				$("#sortorder").val("desc")
			}
			$("#f_search").attr({
					"method":"get",
					"action":location.pathname
			});
			$("#f_search").submit();
			
		});
		
		/* 정렬 박스 선택시 처리 이벤트 */
		$("#s_array").change(function(){
			$("#searchData").click();
		})
		/*라벨버튼 클릭시 처리 이벤트*/
		$("#sortlabel").click(function(){
			if($("#s_sortorder").val()=='asc'){
				$("#s_sortorder").val('desc');
				$("#sortlabel").html('내림차순');
				
			}else{
				$("#s_sortorder").val('asc');
				$("#sortlabel").html('오름차순');
			}
			
			$("#searchData").click();
		})
		
		/* select 박스 선택시 처리 이벤트 */
		$("#s_genre").change(function(){
			$("#searchData").click();
		})		
		$("#s_select_region").change(function(){
			$("#searchData").click();
		})

		/* 달력 설정 및 입력 처리*/
		let start_date="<c:out value='${showVO.start_date}' />";
		
		if(start_date!=""){
			$("#datelabel").html("▼  <c:out value='${showVO.start_date}' />");
		}
		$("#start_date").datepicker({
			language:"ko",
		});
		$("#datelabel").click(function(){
			$("#start_date").focus();
			$('.datepicker').css({'top':Math.floor($("#datelabel").offset().top+30)+'px', 'left':Math.floor($("#datelabel").offset().left-30)+'px'});
		})
		$("#start_date").on("changeDate", function(){
			$("#datelabel").html("▼  "+$("#start_date").datepicker("getFormattedDate"));
			$("#end_date").val($("#start_date").val());
			$("#searchData").click();
		})
		
	})
</script>
	
</head>
<body>
	<div class="container">
		<div class="row text-center">
			<h1><c:if test="${showVO.keyword!=''}">"${showVO.keyword}"(으)로 검색한 </c:if>공연의 검색 결과입니다.</h1>
			<p><c:if test="${showVO.start_date!=''}"><strong>상영일:</strong> ${showVO.start_date}</c:if></p>
			<p><c:if test="${showVO.s_select_region!=''}"><strong>지역:</strong> ${showVO.s_select_region}</c:if></p>
			<p><c:if test="${showVO.s_genre!=''}"><strong>장르:</strong> ${showVO.s_genre}</c:if></p>
		</div>
		<br/><br/><br/>
		<div class="row">
			<form class="form-horizontal" id="f_search">
				<div class="form-group">
					<div class="col-sm-2 col-sm-offset-2">
						<select id="search" name="search" class="form-control">
							<option value="s_name">공연명</option>
							<option value="th_name">공연장명</option>
						</select>
					</div>
					<div class="col-sm-4">
						<input type="text" name="keyword" id="keyword" class="form-control" />
					</div>
					<div class="col-sm-2">
						<button type="button" id="searchData" class="form-control btn btn-default">검색</button>
					</div>
				</div>
				<br/><br/>
				<div class="form-group">
					<div class="col-sm-2">
						<select id="s_genre" name="s_genre" class="form-control">
							<option value="">전체장르</option>
							<option value="뮤지컬">뮤지컬</option>
							<option value="연극">연극</option>							
						</select>	
					</div>
					<div class="col-sm-2">
						<select name="s_select_region" id="s_select_region" class="form-control">
							<option value="">지역</option>
							<option value="서울">서울</option>
							<option value="경기">경기</option>							
						</select>
					</div>		
					<div class="col-sm-4 text-center">
						<label for="start_date" id="datelabel">▼ 날짜 입력하기</label>
						<input type="date" id="start_date" name="start_date" />
						<input type="date" id="end_date" name="end_date" />
					</div>				
					<div class="col-sm-2">
						<select id="s_array" name="s_array" class="form-control">
							<option value="s_name">이름순</option>
							<option value="s_startdate">시작일순</option>
							<option value="s_closedate">종료일순</option>								
						</select>						
					</div>
					<div class="col-sm-2">
						<label for="s_sortorder" id="sortlabel" role="button">내림차순</label>
						<input type="hidden" id="s_sortorder" name="s_sortorder" value="desc" />
					</div>
				</div>
			</form>
		</div>
		<br/><br/><br/>
		<div id="list" class="row">
			<c:forEach var="show" items="${showList}">
				<div class="showBox_search col-xs-12" data-num="${show.s_num}">
					<div class="showBox_thumbnail col-xs-3">
						<a href="/showDetail?s_num=${show.s_num}">
							<img src=
							<c:if test="${show.s_posterimg ne null}">
								"/uploadStorage/${show.s_posterimg.img_dir}/${show.s_posterimg.img_name}.${show.s_posterimg.img_type}"
							</c:if>
							<c:if test="${show.s_posterimg eq null}">
								"/uploadStorage/show/poster_default.jpg"
							</c:if>
							 class="showBox_img" />
						</a>
					</div>
					<div class="showBox_search_text col-xs-6 col-xs-offset-1 ">
						<h4 class="showBox_search_title"><strong>${show.s_name}</strong></h4>
						<br/>
						<p class="showBox_search_genre"><strong>장르 : </strong>${show.s_genre}</p>
						<p class="showBox_search_theater"><strong>장소 : </strong>${show.th_name}</p>
						<p class="showBox_search_date"><strong>기간 : </strong>${show.s_opendate} ~ ${show.s_closedate}</p>
						<p class="showBox_search_price"><strong>관람가 : </strong>${show.s_price}원</p>
					</div>
				</div>
			</c:forEach>
		</div>
		<c:import url="/WEB-INF/views/common/pagination.jsp" />
	</div>
</body>
</html>