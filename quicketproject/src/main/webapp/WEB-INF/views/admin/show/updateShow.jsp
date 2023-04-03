<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<style>
	.input-date-empty::before{
		content:attr(data-placeholder);
		width:100%;
	}
	input[type="file"]{
		display:none;
	}
	#cast_template{
		display:none;
	}
	.showhidetxt{
		font-size:20px;
	}
</style>
<script type="text/javascript" src="/resources/include/js/common.js"></script>
<script type="text/javascript">
$(function(){
	$(".showhidetxt").next().hide();
	$(".showhidetxt").click(function(){
		$(this).next().toggle();
		if($(this).next().css("display")!="none"){
			$(this).text("▲"+$(this).text().substr(1));
		}else{
			$(this).text("▼"+$(this).text().substr(1));
		}
	})
	
	//공연장 select 버튼 항목 불러오고 초기화하는 메소드
	$.ajax({
		url: "/admin/theater/theaterSelectList",
		type: "get",
		success: function(data){
			let init_th_num = Number("<c:out value='${updateData.th_num}' />");
			
			if(data!=null && data.length>0){
				for(let i=0; i<data.length;i++){
					let th_num = data[i].th_num;
					let th_name = data[i].th_name;
					let $option = $("<option value="+th_num+">"+th_name+"</option>");
					if(th_num==init_th_num){
						$option.prop("selected", true);
					}
					$("#th_num").append($option);
				}
			}else{
				let $option = $("<option value=''>공연장 정보가 없습니다.</option>");
				$("#th_num").append($option);
			}
		},
		error: function(xhr, textStatus, errorThrown) {
			alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
		}
	})
	//장르 select 기본값 지정
	let init_s_genre = "<c:out value='${updateData.s_genre}' />";
	if(init_s_genre!='') $("#s_genre").val(init_s_genre).prop("selected",true);
	
	//포스터 이미지 불러오고 바꾸는 기능 구현
	function getPosterBox(url){
		let $posterimg = $("<img>");
		$posterimg.attr("src", url)
		$posterimg.addClass("poster");
		$posterimg.css({width:"100%","z-index":"none"})
		
		$posterdiv = $("<div>");
		$posterdiv.addClass("posterbox")
		$posterdiv.css({
			display:"inline-block",
			position:"relative",
			width:"200px",
			border:"1px solid #000",
			"z-index":"1"
		})
		
		$posterchangeBtn = $("<button type='button'>변경하기</button>");
		$posterchangeBtn.attr("id","changeBtn")
		$posterchangeBtn.addClass("btn btn-default");
		$posterchangeBtn.css({
			position:"absolute",
            right:"2px",
            bottom:"2px",
            "z-index":"999",
            backgroundColor:"#fff"
		})
		$posterdiv.append($posterimg).append($posterchangeBtn);
		$("#poster_div").append($posterdiv);
	};
	if(${updateData.s_posterimg!=null}){
		$("#posterlabel").hide();
		getPosterBox("/uploadStorage/show/${updateData.s_num}/poster/${updateData.s_posterimg.img_name}.${updateData.s_posterimg.img_type}");
	}
	$("#s_posterfile").on("change",function(e){
		$("#poster_div").find(".posterbox").remove();
		let file = e.target.files[0];
		if(file!=null){
			let file_type = file.name.split('.').pop().toLowerCase();
			if($.inArray(file_type, ["jpg","gif","png"])==-1){
				alert("이미지 파일만 등록 가능합니다.");
				return;
			}
			let reader = new FileReader();
			reader.readAsDataURL(file);
			reader.onload = function(e){
				getPosterBox(e.target.result);
				$("#posterlabel").hide();
			}
		}else{
			$("#poster_div").find(".posterbox").remove();
			if(${updateData.s_posterimg!=null}){
				$("#posterlabel").hide();
				getPosterBox("/uploadStorage/show/${updateData.s_num}/poster/${updateData.s_posterimg.img_name}.${updateData.s_posterimg.img_type}");
			}else{
				$("#posterlabel").show();
			}
		}
	})
	$(document).on("click","#changeBtn",function(){
		$("#s_posterfile").click();
	})
	
	//기존 상세 이미지 리스트를 받고 썸네일 생성
	let old_files=[]
	<c:forEach var="old_file" items="${updateData.s_detailimg}">
		$img = $("<img>");
		$img.attr("src", "/uploadStorage/show/${old_file.s_num}/detail/${old_file.img_name}.${old_file.img_type}");
		$img.attr("imgId", ${old_file.img_id});
		$img.addClass("thumbnail");
		$img.css({width:"100%",height:"100%","z-index":"none"})
		
		$div = $("<div>");
		$div.addClass("thumbbox")
		$div.css({
			display:"inline-block",
			position:"relative",
			width:"120px",
			height:"150px",
			margin:"2px",
			border:"1px solid #000",
			"z-index":"1"
		})
		
		$delBtn = $("<button type='button'>×</button>");
		$delBtn.attr("imgId", ${old_file.img_id});
		$delBtn.addClass("thumbdelBtn");
		$delBtn.css({
			width:"20px",
			height:"20px",
			position:"absolute",
			fontSize:"24px",
	        right:"0px",
	        top:"0px",
	        "z-index":"999",
	        border:"none",
			color:"#f00",
			backgroundColor:"transparent"
		})
		
		$div.append($img).append($delBtn)
		$("#detail_thumb").append($div);
	
	
		old_files.push(${old_file.img_id});
	</c:forEach>
	
	//상세 이미지 등록 기능 구현
	let set_files = []
	$("#s_detailfile").on("change", function(e){
		let files = e.target.files;
		let filesArr = Array.prototype.slice.call(files);
		
		filesArr.forEach(function(file){
			let file_type = file.name.split('.').pop().toLowerCase();
			if($.inArray(file_type, ["jpg","gif","png"])==-1){
				alert("이미지 파일만 등록 가능합니다.");
				return;
			}
			set_files.push(file);
			let reader = new FileReader();
			reader.readAsDataURL(file);
			reader.onload = function(e){
				let $img = $("<img>");
				$img.attr("src", e.target.result)
				$img.attr("filename", file.name);
				$img.addClass("thumbnail");
				$img.css({width:"100%",height:"100%","z-index":"none"})
				
				$div = $("<div>");
				$div.addClass("thumbbox")
				$div.css({
					display:"inline-block",
					position:"relative",
					width:"120px",
					height:"150px",
					margin:"2px",
					border:"1px solid #000",
					"z-index":"1"
				})
				
				$delBtn = $("<button type='button'>×</button>");
				$delBtn.attr("filename", file.name);
				$delBtn.addClass("thumbdelBtn");
				$delBtn.css({
					width:"20px",
					height:"20px",
					position:"absolute",
					fontSize:"24px",
		            right:"0px",
		            top:"0px",
		            "z-index":"999",
		            border:"none",
					color:"#f00",
					backgroundColor:"transparent"
				})
				
				$div.append($img).append($delBtn)
				$("#detail_thumb").append($div);
			}
		})
	})
	$(document).on("click", ".thumbdelBtn", (function(){
		let s_detailfile = document.getElementById("s_detailfile");
		let delfile = $(this).attr("filename");
		if(delfile!=null){
			for(i=0; i<set_files.length; i++){
				if(delfile==set_files[i].name){
					set_files.splice(i,1);
				}
			}
			let datatrans = new DataTransfer();
			for(let f in set_files){
				fl = set_files[f];
				datatrans.items.add(fl);
			}
			s_detailfile.files = datatrans.files;
			$(this).parents(".thumbbox").remove();
			$("#detail_preview").text("상세 이미지 미리보기");
			console.log(s_detailfile.files);
		}else{
			let imgId = $(this).attr("imgId");
			for(i=0; i<old_files.length; i++){
				if(old_files[i]==imgId){
					old_files.splice(i,1);
				}
			}
			$(this).parents(".thumbbox").remove();
			$("#detail_preview").text("상세 이미지 미리보기");
			console.log(old_files);
		}
	}))
	$(document).on("click", ".thumbnail", (function(){
		$("#detail_preview").html("");
		let viewfile = $(this).attr("filename");
		if(viewfile!=null){	//새로 추가한 데이터를 클릭했을 경우에 처리되는 부분
			for(i=0; i<set_files.length; i++){
				if(viewfile==set_files[i].name){
					let viewreader = new FileReader();
					viewreader.readAsDataURL(set_files[i]);
					viewreader.onload = function(e){
						let $img = $("<img>");
						$img.attr("src", e.target.result)
						$img.addClass("viewsize");
						$img.css({width:"100%"})
						
						$("#detail_preview").append($img);
					}
				}
			}
		}else{	//받아온 데이터를 클릭했을 경우에 처리되는 부분
			let url = $(this).attr("src");
			let $img = $("<img>");
			$img.attr("src", url)
			$img.addClass("viewsize");
			$img.css({width:"100%"})
			
			$("#detail_preview").append($img);
		}

	}))
	
	//캐스팅 데이터 로딩
	let s_actor_str = "<c:out value='${updateData.s_actor}' />";
	//html로 decoding (안하면 따옴표를 제데로 못 읽어서 에러가 남)
	let $txt = $("<textarea></textarea>");
	$txt.html(s_actor_str)
	let s_actor_txt = $txt.val();
	let s_actor = JSON.parse(s_actor_txt);
	if(s_actor!=null){
		for(let act of s_actor){
			let $table = $("#cast_table");
			let $element = $("#cast_template").clone().removeAttr("id");
			$element.find(".cast_role").val(act.role);
			$element.find(".cast_actor").val(act.actor);				
			
			$table.append($element);
		}
	}
	//캐스팅 데이터 추가 입력 폼 구현
	function addCasting(){
		let $table = $("#cast_table");
		let $element = $("#cast_template").clone().removeAttr("id");
		
		$table.append($element);
	}
	$("#addCasting").click(function(){
		addCasting();
	})
	$(document).on("click",".delCasting",function(){
		$(this).parents(".cast_tr").remove();
	})
	
	//날짜 박스 placeholder 처리
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
	inputDatePlaceholder("#s_opendate","상영개시일");
	inputDatePlaceholder("#s_closedate","상영종료일");	
	
	//캐스팅 정보는 json string으로 바꾸어 input에 넣는 방식으로 전송한다.
	function cast_stringfy(){
		let s_actor=[];
		$(".cast_tr").each(function(){
			let cast_role = $(this).find(".cast_role").val();
			let cast_actor = $(this).find(".cast_actor").val();
			if(cast_role!='' && cast_actor!=''){
				s_actor.push({"role":cast_role, "actor":cast_actor});
			}
		})
		if(Object.keys(s_actor).length>0){
			let s_actor_json = JSON.stringify(s_actor);
			$("#s_actor").val(s_actor_json);
		}
	}	
	
	//버튼 클릭시 메서드
	$("#insertTheaterBtn").click(function(){
		window.open("/admin/theater/insertTheater", "_blank", "width=1200,height=600,scrollbars=yes");
	})
	$("#returnBtn").click(function(){
		location.href="/admin/show/showDetail?s_num="+${updateData.s_num};
		
	})
	$("#cancelBtn").click(function(){
		location.reload();
	})
	$("#showUpdateBtn").click(function(){
		if(!checkForm("#s_name","공연이름을")) return;
		if(!checkForm("#th_num","공연장을")) return;
		if($("#s_opendate").val()==""){alert("상영개시일을 입력해주세요");return;}
		if($("#s_closedate").val()==""){alert("상영종료일을 입력해주세요");return;} 
		if(!checkForm("#s_time","상영시간을")) return;
		if(!checkForm("#s_price","티켓가격을")) return;
		
		cast_stringfy(); //배역 캐스팅 정보 json 문자열화
		
		if(old_files.length>0){
			$("#s_detail_str").val(old_files.join(','));
		}else{
			$("#s_detail_str").val("");
		}
		$("#f_showUpdate").attr({
			//enctype 속성의 기본값은 application/x-www-form-urlcencoded"
			//POST방식 폼 전송에 기본값으로 사용
			//multipart/form-data를 넣지 않으면 다중파일 업로드가 불가능하다.
			method:"post",
			enctype:"multipart/form-data",
			action:"/admin/show/showUpdate"
		});
		$("#f_showUpdate").submit();
	});
	

	
})

</script>

</head>
<body>
<div class="container">
	<div class="row">
		<h1 class="text-center">공연 데이터 수정 양식</h1>
	</div>
	<form id="f_showUpdate" class="form-horizontal">
	<input type="hidden" id="s_num" name="s_num" value="${updateData.s_num}" />
	<div id="default_data" class="row">
		<table class="table table-bordered">
			<thead>
				<tr><th colspan="3" class="text-center">기본 데이터 수정 폼</th></tr>
			</thead>
			<tbody>
				<tr>
					<td id="poster_td" rowspan="6" class="col-sm-2">
						<div id="poster_div" class="text-center">
							<label id="posterlabel" for="s_posterfile" role="button" class="form-control btn ">
								포스터 이미지 첨부하기
							</label>
							<input type="file" id="s_posterfile" name="s_posterfile" class="form-control" />
						</div>
					</td>
					<th class="text-center">공연명</th>
					<td>
						<div class="col-sm-12">
							<input type="text" id="s_name" name="s_name" class="form-control" value="${updateData.s_name}" />
						</div>
					</td>
				</tr>
				<tr>
					<th class="text-center">장르</th>
					<td>
						<div class="col-sm-4">
							<select id="s_genre" name="s_genre" class="form-control">
								<option value="뮤지컬">뮤지컬</option>
								<option value="연극">연극</option>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<th class="text-center">공연장</th>
					<td>
						<div class="col-sm-8">
							<select id="th_num" name="th_num" class="form-control"></select>
						</div>
						<div class="col-sm-4">
							<button type="button" id="insertTheaterBtn" class="btn btn-default">공연장 정보 등록</button>
						</div>
					</td>
				</tr>
				<tr>
					<th class="text-center">공연기간</th>
					<td>
						<div class="col-sm-3">
							<input type="date" name="s_opendate" id="s_opendate" class="form-control" value="${updateData.s_opendate}" />
						</div>
						<span class="col-sm-1 text-center">~</span>
						<div class="col-sm-3">
							<input type="date" name="s_closedate" id="s_closedate" class="form-control" value="${updateData.s_closedate}" />
						</div>
					</td>					
				</tr>
				<tr>
					<th class="text-center">공연시간</th>
					<td>
						<div class="col-sm-12">
							<input type="text" id="s_time" name="s_time" class="form-control" value="${updateData.s_time}"/>
						</div>
					</td>
				</tr>
				<tr>
					<th class="text-center">티켓가격</th>
					<td>
						<div class="col-sm-12">
							<input type="text" id="s_price" name="s_price" class="form-control" value="${updateData.s_price}"/>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<p class="showhidetxt">▼ 추가 데이터 수정</p>
	<div id="add_data" class="row">
		<table class="table table-bordered">
			<thead>
				<tr><th colspan="2" class="text-center">추가 데이터 수정 폼</th></tr>
			</thead>
			<tbody>
				<tr>
					<th class="col-sm-2 text-center">캐스팅</th>
					<td class="col-sm-10">
						<div>
							<table id="cast_table" class="table table-bordered">
								<tr id="cast_template" class="cast_tr">
									<th class="col-sm-2 text-center">배역</th>
									<td class="col-sm-3">
										<input type="text" class="cast_role form-control" />
									</td>
									<th class="col-sm-2 text-center">배우명</th>
									<td class="col-sm-4">
										<input type="text" class="cast_actor form-control" />
									</td>
									<td class="col-sm-1 text-center">
										<button type="button" class="btn btn-default delCasting">삭제</button>
									</td>
								</tr>
							</table>
						</div>
						<div>
							<input type="hidden" id="s_actor" name="s_actor" />
							<button type="button" id="addCasting" class="btn btn-default">데이터 추가</button>
						</div>
					</td>
				</tr>
				<tr>
					<th class="text-center">주최·주관</th>
					<td>
						<div class="col-sm-12">
							<input type="text" id="s_sponsor" name="s_sponsor" class="form-control" value="${updateData.s_sponsor}" />
						</div>
					</td>
				</tr>
				<tr>
					<th class="text-center">기획·제작</th>
					<td>
						<div class="col-sm-12">
							<input type="text" id="s_director" name="s_director" class="form-control" value="${updateData.s_director}"/>
						</div>
					</td>
				</tr>
				<tr><th colspan="2" class="text-center">안내 사항 입력란</th></tr>
				<tr><td colspan="2"><textarea id="s_guide" name="s_guide" class="form-control" rows="5">${updateData.s_guide}</textarea></td></tr>
			</tbody>
		</table>
	</div>
	<p class="showhidetxt">▼ 상세 이미지 첨부</p>
	<div id="img_data" class="row">
		<table class="table table-bordered">
			<thead>
				<tr><th class="text-center">상세 이미지 첨부</th></tr>
			</thead>
			<tbody>
				<tr><td>
					<label for="s_detailfile" role="button" class="btn btn-default">이미지 추가</label>
					<input type="file" id="s_detailfile" class="s_detailfile" name="s_detailfile" multiple />
					<input type="hidden" id="s_detail_str" name="s_detail_str" />
					<br/>
					<div id="detail_thumb"></div>
				</td></tr>
				<tr><td class="text-center">		
				<div id="detail_preview">
						상세 이미지 미리보기
				</div>	
				</td></tr>
			</tbody>
		</table>
	</div>
	<div class="row text-right">
		<button type="button" id="returnBtn" class="btn btn-default">돌아가기</button>
		<button type="button" id="cancelBtn" class="btn btn-default">입력취소</button>
		<button type="button" id="showUpdateBtn" class="btn btn-default">수정하기</button>
	</div>
	</form>
	<br/>
	<br/>
	<br/>
</div>

</body>
</html>