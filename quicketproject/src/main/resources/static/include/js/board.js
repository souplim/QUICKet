let keyword = "", search = "", start_date = "", end_date = "";
$(function(){
	if(search!="b_date"){
		$("#dateCheck").hide();
		var date = getDateFormat(new Date());
		$("#start_date").val(date);
		$("#end_date").val(date);
	} else {
		$('#search').val(search);
		$('#textCheck').hide();
		$('#start_date').val(start_date);
		$("#end_date").val(end_date);
	}
	
	/* 검색단어 보여주기 */
	if(keyword!=""){ 
		$("#search").val(search);
		$("#keyword").val(keyword);
	}
	
	/* 검색 버튼 클릭 시 처리 이벤트 */
	$('#searchBtn').click(function(){
		if($('#search').val()!="b_date"){
			if(!chkSubmit($('#keyword'), "검색어를"));
		} else if($('#search').val()=="b_date"){
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
		$('#keyword').val("");
		$('#start_date').val("");
		$('#end_date').val("");
		//goPage();
		location.href="/admin/board/boardList";
	});
	
	/* 검색 대상이 변경될 때마다 처리 이벤트 */
	$('#search').change(function(){
		if($('#search').val()!="b_date"){
			$('#dateCheck').hide();
			$('#textCheck').show();
		}
		if($('#search').val()=="b_date"){
			$('#textCheck').hide();
			$('#dateCheck').show();
		}
	});
	
	$('.paginate_button a').click(function(e){
		e.preventDefault();
		$('#f_search').find("input[name='pageNum']").val($(this).attr("href"));
		goPage();
	});
	
	/* 제목 마우스 오버시 밑줄 */
	$('.goDetail').hover(function(){
		$(this).css("textDecoration","underline");
	}, function(){
		$(this).css("textDecoration","none");
	});
	
	/* 제목 클릭시 상세 페이지 이동을 위한 처리 이벤트 */
	$('.goDetail').click(function(){
		let b_num = $(this).parents("tr").attr("data-num");
		$("#b_num").val(b_num);
		// console.log("글번호:"+b_num);
		location.href="/admin/board/boardDetail?b_num="+b_num;
		/*$("#f_search").attr({
			"method" : "get",
			"action" : "/admin/board/boardDetail"
		});
		$("#f_search").submit();*/
	});
	
	/* 삭제 버튼 클릭시 처리 이벤트 */
	$('.delBtn').click(function(){
		if(confirm('정말 삭제하시겠습니까?')){
			let b_num = $(this).parents("tr").attr("data-num");
			$("#b_num").val(b_num);
			location.href="/admin/board/boardDelete?b_num="+b_num;
			/*$("#f_search").attr({
				"method" : "get",
				"action" : "/admin/board/boardDelete"
			});
			$("#f_search").submit();*/
		}
	});
});

function goPage(){
	$('#f_search').attr({
		"method" : "get",
		"action" : "/admin/board/boardList"
	});
	$('#f_search').submit();
}