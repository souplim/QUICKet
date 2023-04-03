let keyword = "", search = "", search_detail = "", start_date = "", end_date = "";

$(function(){
	
	/* 유형별 영역 숨기기 */
	if(search=="i_category" || search=="i_reply") {
		$("#dateCheck").hide(); /* 유형 검색 선택 시 날짜, 검색어 부분 감추기 */
		$('#textCheck').hide();
		$("#start_date").val(date);
		$("#end_date").val(date);
		
		$('#keyword').val(""); /* 키워드 초기화 */
		$("#search").val(search); /* 유형 검색 후 유형 보여주기 */
		//$("#search_detail").val(1234); // 왜 안 먹을까? -> 동적으로 생성된 option이기 때문! 다시 동적으로 값 주어야 함

		/* 검색했을 때 다시 동적으로 option 값 보여주기 */		
		const i_category = ["회원정보", "공연", "그 외"];
		const reply = ["답변대기중", "답변완료"];
		
		let search_detail;
		if(search == "i_category") search_detail = i_category;
		else if(search == "i_reply") search_detail = reply;
		
		let target = $("#search_detail");
		target.empty(); //기존에 들어가 있는 옵션 삭제
		for(x in search_detail)
			target.append("<option value='"+search_detail[x]+"'>"+search_detail[x]+"</option>")
		
	} else if (search=="i_regidate"){
		$('#search').val(search);
		$('#textCheck').hide(); /* 날짜 검색 선택 시 보이는 부분 감추기 */
		$('#start_date').val(start_date);
		$("#end_date").val(end_date);
	} else {
		$("#dateCheck").hide();
		var date = getDateFormat(new Date());
		$("#start_date").val(date);
		$("#end_date").val(date);
	} 
	
	/* 검색어로 검색할 경우 유형 및 검색단어 보여주기 */
	if(keyword!=""){ 
		$("#search").val(search);
		$("#keyword").val(keyword);
	}
	
	/* 검색 버튼 클릭 시 처리 이벤트 */
	$('#searchBtn').click(function(){
		if($('#search').val()=="i_title" || $('#search').val()=="u_id" || $('#search').val()=="i_content"){
			if(!chkSubmit($('#keyword'), "검색어를"));
		} else if($('#search').val()=="i_regidate"){
			if(!chkSubmit($('#start_date'),"시작날짜를")) return;
			else if(!chkSubmit($('#end_date'),"종료날짜를")) return;
			else if($('#start_date').val()>$('#end_date').val()){
				alert('시작날짜가 종료날짜보다 더 클 수 없습니다.');
				return;
			}
		}
		
		$('#pageNum').val(1);
		goPage();
	});
	
	/* 전체 조회 버튼 클릭시 이벤트 처리 */
	$('#allSearchBtn').click(function(){
		$('#search > option:selected').val("");
		$('#search_detail > option:selected').val("");
		$('#keyword').val("");
		$('#start_date').val("");
		$('#end_date').val("");
		//goPage();
		location.href="/admin/inq/inqList";
	});
	
	/* 검색 대상이 변경될 때마다 처리 이벤트 -> */
	$('#search').on("input", function(){
		if($('#search').val()=="i_regidate"){
			$('#textCheck').hide();
			$('#dateCheck').show();
		} else if($('#search').val()=="i_category" || $('#search').val()=="i_reply"){
			$('#textCheck').hide();
			$('#dateCheck').hide();
		} else {
			$('#dateCheck').hide();
			$('#textCheck').show();
		}
	});
	
	/* 엔터 시 검색 */
	$('.paginate_button a').click(function(e){
		e.preventDefault();
		$('#f_search').find("input[name='pageNum']").val($(this).attr("href"));
		goPage();
	});
	
	/* 제목 마우스오버 시 밑줄 */
	$(".goDetail").hover(function(){
		$(this).css("textDecoration","underline");
	}, function(){
		$(this).css("textDecoration","none");
	});
	
	/* 유형 선택시 세부유형 option 항목 처리 이벤트 */
	$("#search").on("change", function(){
		const i_category = ["회원정보", "공연", "그 외"];
		const reply = ["답변대기중", "답변완료"];
		const emp = ["---"];
		
		let search = $("#search").val();
		
		let search_detail;
		if(search == "i_category") search_detail = i_category;
		else if(search == "i_reply") search_detail = reply;
		else search_detail = emp;
		
		let target = $("#search_detail");
		target.empty(); /* 기존에 들어가 있는 옵션 삭제 */
		
		for(x in search_detail)
			target.append("<option value='"+search_detail[x]+"'>"+search_detail[x]+"</option>")
	});
	
	/* 페이징 처리 이벤트 */
	$(".paginate_button a").click(function(e){
		e.preventDefault(); // a태그 -> href로 이동하는 성격 해제
		// dataForm 폼 하위 pageNum을 이름으로 가지는 input의 값을 클릭한 번호
		$("#pageForm").find("input[name='pageNum']").val($(this).attr("href"));
		
		// 폼태그 안 데이터 들고 다시 페이지 list 부르기
		goPage();
	});
	
	/* 삭제 버튼 클릭시 처리 이벤트 */
	$('.delBtn').click(function(){
		if(confirm('정말 삭제하시겠습니까?')){
			let i_num = $(this).parents("tr").attr("data-num");
			$("#i_num").val(i_num);
			location.href="/admin/inq/inqDelete?i_num="+i_num;
		}
	});
	
});

/* 페이지 이동 */
function goPage(){
	
	$('#f_search').attr({
		"method" : "get",
		"action" : "/admin/inq/inqList"
	});
	$('#f_search').submit();
}