/**
 * 
 */
function makeShowBox(vo, panel, sub, size){
	let $panel = $(panel);
	
	let $showBox = $("<div class='showBox'></div>");
	$showBox.addClass("col-xs-"+size);
	let s_num = vo.s_num;
	$showBox.attr("data-num", s_num);
	$showBox.css({"padding":"10px","textAlign":"center"});
	
	let $showBox_thumbnail = $("<div class='showBox_thumbnail'></div>")
	let $poster = $("<img class='showBox_img' />");
	let poster_url="";
	if(vo.s_posterimg!=null){
		let poster_img = vo.s_posterimg;
		let poster_dir = poster_img.img_dir;
		let poster_name = poster_img.img_name;
		let poster_type = poster_img.img_type;
		
		poster_url = "/uploadStorage/"+poster_dir+"/"+poster_name+"."+poster_type;
	}
	if(poster_url!=""){
		$poster.attr("src", poster_url);
	}else{
		poster_url="/uploadStorage/show/poster_default.jpg"
		$poster.attr("src", poster_url);
	}
	$poster.css({"width":"100%", "marginBottom":"10px"});
	let $link = $("<a href='/showDetail?s_num="+s_num+"'></a>");	
	$link.append($poster);
	$showBox_thumbnail.append($link);
	$showBox_thumbnail.css({"display":"inline-block"});
	
	let $showBox_text = $("<div class='showBox_text'></div>")
	let s_name = vo.s_name;
	let subtxt ='';
	if(sub=='rank_ticket'){
		subtxt = vo.rank_ticket+"%";
	}else if(sub=='s_opendate'){
		subtxt = vo.s_opendate;
	}else if(sub=='s_point'){
		subtxt = vo.s_point;
	}
	let $title = $("<p class='showBox_title'>"+s_name+"</p>");
	let $subtxt = $("<p class='showBox_subtxt'>"+subtxt+"</p>");
	$showBox_text.append($title).append($subtxt);
	$showBox_text.css({"display":"inline-block","textAlign":"center"})
	
	$showBox.append($showBox_thumbnail).append($showBox_text);
	$panel.append($showBox);
}


function makeStar(item, point){
	let $star = $("<span>★★★★★</span>")
	$star.css({
		"position":"relative",
		"fontSize":"2rem",
		"color":"#ccc"
	})
	let $starpaint = $("<span>★★★★★</span>")
	$starpaint.css({
		"width":point*10+"%",
		"position":"absolute",
		"left":"0",
		"color":"#f90",
		"overflow":"hidden",
		"pointer-events":"none"
	})
	$star.append($starpaint);
	$(item).prepend($star);
}