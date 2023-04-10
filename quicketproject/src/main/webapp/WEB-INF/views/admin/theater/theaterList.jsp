<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<style>
	.th_date{
		font-size:8px;
	}

</style>
<script type="text/javascript">
	$(function(){
		
		/* 검색 후 검색 대상과 검색 단어 출력 - 검색 여부는 키워드(keyword)의 값 존재여부로 제어*/
		let word = "<c:out value='${theaterVO.keyword}' />";
		if(word!=""){
			$("#keyword").val("<c:out value='${theaterVO.keyword}' />");
			$("#search").val("<c:out value='${theaterVO.search}' />");
			
			if($("#search").val()=="th_name"){
				$("#list tr td.theatername:contains('"+word+"')").each(function(){
					let regex = new RegExp(word,'gi');
					$(this).html($(this).html().replace(regex,"<span class='required'>"+word+"</span>"));
				})
			}
			if($("#search").val()=="th_addr"){
				$("#list tr td.theateraddr:contains('"+word+"')").each(function(){
					let regex = new RegExp(word,'gi');
					$(this).html($(this).html().replace(regex,"<span class='required'>"+word+"</span>"));
				})
			}
		}
		
		/*검색 후 select 위치 맞추기*/
		let array = "<c:out value='${theaterVO.th_array}' />";
		if(array!=""){
			$("#th_array").val(array).prop("selected",true);
		}
		
		/*검색 후 오름차순 내림차순 표시 바꾸기*/
		let sortorder = "<c:out value='${theaterVO.th_sortorder}' />";
		if(sortorder!=""){
			$("#th_sortorder").val(sortorder)
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
			if($("#keyword").val()==""){
				$("#search").val()==""
			}
			if($("#th_array")!="" && $("#sortorder").val()==""){
				$("#sortorder").val("desc")
			}
			$("#f_search").attr({
					"method":"get",
					"action":location.pathname
			});
			$("#f_search").submit();
			
		});
		
		/* 정렬 박스 선택시 처리 이벤트 */
		$("#th_array").change(function(){
			$("#searchData").click();
		})
		
		/*라벨버튼 클릭시 처리 이벤트*/
		$("#sortlabel").click(function(){
			if($("#th_sortorder").val()=='asc'){
				$("#th_sortorder").val('desc');
				$("#sortlabel").html('내림차순');
				
			}else{
				$("#th_sortorder").val('asc');
				$("#sortlabel").html('오름차순');
			}
			
			$("#searchData").click();
		})
		
		
		//지도정보 버튼 클릭시 처리
		$(".theaterMapBtn").each(function(){
			$(this).click(function(){
				let th_num = $(this).parents(".th_tr").data("num");
				window.open("/admin/theater/theaterMap?th_num="+th_num, "_blank", "width=600,height=800,scrollbars=yes");
			})
		})
		
		//데이터등록버튼 클릭시 처리
		$("#insertTheaterBtn").click(function(){
			window.open("/admin/theater/insertTheater", "_blank", "width=1200,height=600,scrollbars=yes");
		})
		//데이터수정버튼 클릭시 처리
		$(".updateTheaterBtn").each(function(){
			$(this).click(function(){
				let th_num = $(this).parents(".th_tr").data("num");
				window.open("/admin/theater/updateTheater?th_num="+th_num, "_blank", "width=1200,height=600,scrollbars=yes");
			})
		})
		//데이터삭제버튼 클릭시 처리
		$(".deleteTheaterBtn").each(function(){
			$(this).click(function(){
				if(confirm("정말로 삭제하시겠습니까?")){
					let del_th_num = $(this).parents(".th_tr").data("num");
					let value = JSON.stringify({th_num:del_th_num});
					
					$.ajax({
						url: "/admin/theater/theaterDelete",
						type: "post",
						headers:{
							"Content-Type":"application/json"
						},
						dataType:"text",
						data: value,
						success: function(result){
							if(result=="SUCCESS"){
								alert("데이터 삭제를 완료했습니다.");
								location.reload();
							}else if(result=="CANCELED"){
								alert("해당 공연장에 등록된 공연이 존재합니다. 삭제를 취소합니다.");
							}else if(result=="FAILURE"){
								alert("데이터 삭제에 실패했습니다.");
							}
						},
						error: function(xhr, textStatus, errorThrown) {
							
							alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
						}	
					})
				}
			})
		})
	})
</script>

</head>
	<body>
	<div class="container">
		<div class="row text-center">
			<h3>공연장 관리 리스트</h3>
		</div>
		<br/><br/>
		<div class="row">
			<form class="form-horizontal" id="f_search">
				<div class="form-group">
					<div class="col-sm-2">
						<select id="th_array" name="th_array" class="form-control">
							<option value="th_num">번호순</option>
							<option value="th_name">이름순</option>
							<option value="th_addr">지역순</option>
							<option value="th_regdate">등록일순</option>								
						</select>						
					</div>
					<div class="col-sm-2 col-sm-offset-2">
						<select id="search" name="search" class="form-control">
							<option value="th_name">공연장명</option>
							<option value="th_addr">주소</option>
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
					<div class="col-sm-2 col-sm-offset-10 text-right">
						<span class="glyphicon glyphicon-sort"></span>
						<label for="th_sortorder" id="sortlabel" role="button">내림차순</label>
						<input type="hidden" id="th_sortorder" name="th_sortorder" value="desc" />
					</div>
				</div>
			</form>
		</div>
		<div class="row">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th class="order text-center col-md-1">등록번호</th>
						<th class="text-center col-md-2">이름</th>
						<th class="text-center col-md-3">주소</th>
						<th class="text-center col-md-2">웹사이트</th>
						<th class="text-center col-md-1">지도 정보</th>
						<th class="text-center col-md-1">등록일<br/>/수정일</th>
						<th class="col-md-1"></th>
					</tr>
				</thead>
				<tbody id="list">
					<c:forEach var="theater" items="${theaterList}" varStatus="status">
						<tr class="th_tr" data-num="${theater.th_num}">
							<td class="text-center">${theater.th_num}</td>
							<td>${theater.th_name}</td>
							<td>${theater.th_addr}</td>
							<td>${theater.th_web}</td>
							<td class="text-center">
								<button type="button" class="theaterMapBtn btn btn-default">지도 정보</button>
							</td>
							<td class="th_date text-center">
								<p><strong>등록일</strong><br/>${theater.th_regdate}</p>
								<p><strong>수정일</strong><br/>${theater.th_update}</p>
							</td>
							<td class="text-center">
								<button type="button" class="updateTheaterBtn btn btn-default">수정</button><br/>
								<button type="button" class="deleteTheaterBtn btn btn-default">삭제</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="row text-right">
			<button type="button" id="insertTheaterBtn" class="btn btn-default">데이터 등록</button>
		</div>
		<c:import url="/WEB-INF/views/common/pagination.jsp" />
	</div>
	</body>
</html>