<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<style>
	.input-date-empty::before{
		content:attr(data-placeholder);
		width:100%;
	}
	.thumbnail{
		width:100%;
	}
</style>
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
		
		/* 검색 후 검색 날짜 출력 - 검색 여부는 키워드(keyword)의 값 존재여부로 제어*/
		let start_date = "<c:out value='${showVO.start_date}' />";
		let end_date = "<c:out value='${showVO.end_date}' />";
		if(start_date!="" && end_date!=""){
			$("#start_date").val("<c:out value='${showVO.start_date}' />");
			$("#end_date").val("<c:out value='${showVO.end_date}' />");
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
		
		//데이터등록버튼 클릭시 처리
		$("#insertShowBtn").click(function(){
			location.href="/admin/show/insertShow";
		})
		
		//날짜박스 placeholder 처리
		function inputDatePlaceholder(item, placeholder){
			$(item).attr('data-placeholder',placeholder);
			if($(item).val()==""){
				$(item).addClass("input-date-empty");
			}
			$(item).change(function(){
				if($(this).val()!=''){
					$(this).removeClass("input-date-empty");
				}else{
					$(this).addClass("input-date-empty");
				}
			})
		}
		inputDatePlaceholder("#start_date","시작일자");
		inputDatePlaceholder("#end_date","종료일자");
		
		//공연리스트 포인트란에 별 부여
		$(".showlist_point").each(function(){
			let point = $(this).data('point');
			makeStar($(this), point);
		})
		
	})
</script>

</head>
	<body>
	<div class="container">
		<div class="row">
			<br/><br/>
			<form class="form-horizontal" id="f_search">
				<div class="form-group">
					<div class="col-sm-2">
						<select id="s_array" name="s_array" class="form-control">
							<option value="s_num">번호순</option>
							<option value="s_name">이름순</option>
							<option value="s_startdate">시작일순</option>
							<option value="s_closedate">종료일순</option>								
						</select>						
					</div>
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
				<div class="form-group" id="dateCheck">
					<div class="col-sm-2 col-sm-offset-8">
						<input type="date" name="start_date" id="start_date" class="form-control" />
					</div>
					<div class="col-sm-2">
						<input type="date" name="end_date" id="end_date" class="form-control" />
					</div>
				</div>
				<br/><br/>
				<div class="form-group">
					<div class="col-sm-2 col-sm-offset-10 text-right">
						<span class="glyphicon glyphicon-sort"></span>
						<label for="s_sortorder" id="sortlabel" role="button">내림차순</label>
						<input type="hidden" id="s_sortorder" name="s_sortorder" value="desc" />
					</div>
				</div>
			</form>
		</div>
		<div class="row">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th class="order text-center col-md-1">등록번호</th>
						<th class="text-center col-md-2">썸네일</th>
						<th class="text-center col-md-9">기본정보</th>
					</tr>
				</thead>
				<tbody id="list">
					<c:forEach var="show" items="${showList}" varStatus="status">
						<tr class="text-center" data-num="${show.s_num}">
							<td>${show.s_num}</td>
							<td>
								<c:if test="${show.s_posterimg ne null}">
									<img class="thumbnail" src="/uploadStorage/show/${show.s_num}/poster/${show.s_posterimg.img_name}.${show.s_posterimg.img_type}" />
								</c:if>
							</td>
							<td>
								<table class="table table-bordered">
									<tr>
										<td>공연명</td>
										<td class="showname">
											<a href="/admin/show/showDetail?s_num=${show.s_num}">${show.s_name}</a>
										</td>
									</tr>
									<tr>
										<td>공연장</td>
										<td class="theatername">${show.th_name}</td>
									</tr>
									<tr>
										<td>공연기간</td>
										<td>${show.s_opendate} ~ ${show.s_closedate}</td>
									</tr>
									<tr>
										<td>평점</td>
										<c:set var="s_point" value="${(show.s_point+0.005)-((show.s_point+0.005)%0.01)}" />
										<td class="showlist_point" data-point="${s_point}">${s_point}</td>
									</tr>
									<tr>
										<td>등록일</td>
										<td>${show.s_regdate}</td>
									</tr>
									<tr>
										<td>수정일</td>
										<td>${show.s_update}</td>
									</tr>
								</table>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="row text-right">
			<button type="button" id="insertShowBtn" class="btn btn-default">데이터 등록</button>
		</div>
		<c:import url="/WEB-INF/views/common/pagination.jsp" />
	</div>
	</body>
</html>