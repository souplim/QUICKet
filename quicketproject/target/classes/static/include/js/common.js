/* 함수명 : chkData(유효성 체크 대상, 메시지 내용)
 * 출력영역 : alert
 * 예시 : if(!chkData("#keyword","검색이름")) return;
 */
function chkData(item, msg){
	if($(item).val().replace(/s/g,"")==""){
		alert(msg+" 입력해 주세요.");
		$(item).val("");
		$(item).focus();
		return false;
	} else
		return true;
}

/* 함수명 : dataCheck(유효성 체크 대상, 메시지 영역, 메시지 내용)
 * 출력영역 : 
 * 예시 : if(!dataCheck("#keyword","#area","검색이름")) return;
 */
function dataCheck(item, area, msg){
	if($(item).val().replace(/s/g,"")==""){
		$(area).text(msg+" 입력해 주세요.").css("color","red");
		$(item).select();
		return false;
	} else
		return true;
}

/* 함수명 : checkForm(유효성 체크 대상, 메시지 내용)
 * 출력영역 : placeholder 속성 이용
 * 예시 : if(!checkForm("#keyword","검색이름")) return;
 */
function checkForm(item, msg){
	let message = "";
	if($(item).val().replace(/\s/g,"")==""){
		message = msg + " 입력해주세요.";
		$(item).attr("placeholder",message);
		return false;
	} else
		return true;
}

/* 함수명: forCheck(유효성 체크 대상, 출력 영역, 메시지 내용) 
 * 출력영역 : 매개변수 두번째 출력영역
 * 예시 : if(!formCheck('#keyword','#msg','검색어를')) return;
 */
function formCheck(main, item, msg){
	if($(main).val().replace(/\s/g,"")==""){
		$(item).css("color","#000099").html(msg+"입력해주세요");
		$(main).val("");
		return false;
	} else 
		return true;
}

/* 함수명 : chkFile(파일명 객체) 
 * 설명 : 이미지 파일 여부를 확인하기 위해 확장자 확인 함수
 * if(!chkFile($("#file"))) return; */
function chkFile(item){
	/*let idx = $(item).val().lastIndexOf(".");
	let formatName = $(item).val().substr(idx+1);
	
	if(formatName!='png' || formatName!='jpg' || formatName!='gif'){
		alert("확장자가 png, jpg, gif 외 파일을 업로드 없습니다.");
		$(item).val("");
		return false;
	} else
		return true;*/
		
	/* 참고사항
	 * jQuery.inArray(찾을 값, 검색 대상의 배열): 배열내의 값을 찾아서 인덱스를 반환(요소가 없을 경우 -1 반환)
	 * pop(): 배열의 마지막 요소를 제거한 후, 제거한 요소를 반환 
	 * 함수 적용 잘 되었는지 알아보기 위한 방법 : writeForm.jsp - network - F5 - common.js - response - 함수 확인
	 */
	let ext = item.val().split('.').pop().toLowerCase();
	if(jQuery.inArray(ext, ['gif','png','jpg']) == -1){
		alert("확장자가 png, jpg, gif 외 파일을 업로드 할 수 없습니다.");
		item.val("");
		return false;
	} else
		return true;	
}

/* 함수명 : getDateFormat(날짜 데이터)
 * 설명 : dataValue의 값을 년-월-일 형식(예시: 2018-01-01)으로 반환 */
function getDateFormat(dateValue){
	let year = dateValue.getFullYear();
	
	let month = dateValue.getMonth()+1;
	month = (month<10) ? "0"+month : month;
	
	let day = dateValue.getDate();
	day = (day<10) ? "0"+day : day;
	
	let result = year+"-"+month+"-"+day;
	return result;
}

/* 함수명 : chkSubmit(유효성 체크 대상, 메시지 내용)
 * 출력영역 : alert
 * 예시 : if(!chkSubmit($('#keyword'), "검색어를")) return; */
function chkSubmit(item, msg){
	if(item.val().replace(/\s/g,"")==""){
		alert(msg+"입력해주세요.");
		item.val("");
		item.focus();
		return false;
	} else 
		return true;
}

function getDateFormat(dateValue){
	let year = dateValue.getFullYear();
	
	let month = dateValue.getMonth()+1;
	month = (month<10) ? "0"+month : month;
	
	let day = dateValue.getDate();
	day = (day<10) ? "0"+day : day;
	
	let result = year+"-"+month+"-"+day;
	return result;
}