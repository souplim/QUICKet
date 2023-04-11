/**
 * 
 */
function makeShowBox(vo, panel, sub, width, height){
	let $panel = $(panel);
	
	let $showBox = $("<div class='showBox'></div>");
	let s_num = vo.s_num;
	$showBox.attr("data-num", s_num);
	$showBox.css({
		"display":"inline-block",
		"verticalAlign":"top",
		"padding":"15px 20px",
		"textAlign":"center",
		"boxShadow":"10px 10px 20px 3px rgb(123,123,123,0.5)",
		"margin":"10px",
		"width":width+"px",
		"height":height+"px"
	});
	
	let $showBox_thumbnail = $("<div class='showBox_thumbnail'></div>")
	let $poster = $("<img class='showBox_img' />");
	let poster_url="";
	if(vo.s_posterimg!=null){
		let poster_img = vo.s_posterimg;
		let poster_dir = poster_img.img_dir;
		let poster_name = poster_img.img_name;
		let poster_type = poster_img.img_type;
		
		poster_url = "/uploadStorage"+poster_dir+"/"+poster_name+"."+poster_type;
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
		subtxt = Math.round(vo.s_point*100)/100;
	}else if(sub=='b_count'){
		subtxt = vo.b_count;
	}
	let $title = $("<p class='showBox_title'>"+s_name+"</p>");
	$title.css({"fontSize":"16px","fontWeight":"bold"})
	let $subtxt = $("<span class='showBox_subtxt'>"+subtxt+"</span>");
	if(sub=='s_point'){
		$subtxt.prepend("<br/>");
		makeStar($subtxt, Math.round(vo.s_point*100)/100);
	}else{
		$subtxt.append("<br/>")
	}
	if(sub=='b_count'){
		$subtxt.css({"color":"red", "fontSize":"16px"});
		$subtxt.prepend("&nbsp;&nbsp;");
		makeHeart($subtxt, "red", 10);
	}
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
		"width":point*20+"%",
		"position":"absolute",
		"left":"0",
		"color":"#f90",
		"overflow":"hidden",
		"pointer-events":"none"
	})
	$star.append($starpaint);
	$(item).prepend($star);
}

function makeHeart(item, color, size){
	let $Heart= $("<span>");
	$Heart.css({
		"display":"inline-block"
	})
	let $part0= $("<div>");
	$part0.css({
		"position":"relative",
		"width":size+"px",
		"height":size+"px",
		"backgroundColor":color,
		"transform":"rotate(45deg)"
	});
	let $part1 = $("<div>");
	$part1.css({
		"position":"absolute",
		"left":"-50%",
		"width":size+"px",
		"height":size+"px",
		"borderRadius":"50%",
		"backgroundColor":color
	});
	let $part2 = $("<div>");	
	$part2.css({
		"position":"absolute",
		"top":"-50%",
		"width":size+"px",
		"height":size+"px",
		"borderRadius":"50%",
		"backgroundColor":color	
	});
	$part0.append($part1).append($part2);
	$Heart.append($part0);
	$(item).prepend($Heart);
}