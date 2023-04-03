<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
 <link href="/resources/include/dist/css/styles.css" rel="stylesheet" />

	<script type="text/javascript">
	
		/*************** 글 등록하기 *****************/
		$(document).on("click", "#ex_writeFormBtn", function(){
			console.log("등록 버튼 클릭");
			$("ex_writeFormBtn input[type=button]").attr("id", "expectWriteBtn");	// 
		});
		
		$(document).on("click", "#expectWriteBtn", function(){
			if(!chkData("#ex_content", "내용을 ")) return;
			else{
				$("#ex_writeForm").attr({
					"method":"post",
					"action":"/expect/expectInsert"
				});
				$("#ex_writeForm").submit();
			}
		});
		
		/********** 글 수정하기 **************/
		$(".ex_upBtn").click(function(){
			console.log("수정버튼 클릭");
			let q_no = $(this).parents("div.ms-3").attr("data-no");	
			//수정할 번호를 받아와야 하므로, 수정할 댓글에서 누른 수정버튼이 있는 div에서 부모를 찾아서 그 data-no(<-qna.q_no 설정)를 받아오고, 그 값을 q_no에 담았음
			console.log("글번호: "+ ex_no);
			
			let content = $(this).parents("div.ms-3").find(".ex_content").html();
			// 수정할 댓글의 본문내용을 가져와야하므로, 부모로 가서(parents) -> 자식 div q_content클래스(특정할 수 있는 값) 찾아서 그 값을 content에 담는다.
			console.log("content: "+ content);
			$("#ex_content").val(content); 
			// 일반적 태그는 html() text(), input/textarea는 value로 값을 가져와서 설정해준다. 
			// $("#q_content").val(content) : 받아온 값을 담는것
			// $("#q_content").val() : #q_content에 있는 값을 가져오는 것 
			$("#ex_writeForm input[type=button]").attr("id", "expectUpdateBtn");
			//$("#q_writeForm input[type=button]").attr("data-no", q_no);
			$("#ex_no").val(ex_no);  	//hidden form에서 #q_no에 위에서 받아온 q_no 값을 설정해준다.
			$("#ex_writeForm input[type='button']").val("수정");
			
		});
		
		$(document).on("click", "#expectUpdateBtn", function(){
			//let q_no = $(this).attr("data-no");	hidden form이 있으므로 직접적으로 위에서 번호 넣어줬으므로 생략
			//console.log("수정 시 글번호 :"+q_no);
			
			if(!chkData("#ex_content", "내용을 ")) return;
			else{
				$("#ex_writeForm").attr({
					"method":"post",
					"action":"/expect/expectUpdate"
				});
				$("#ex_writeForm").submit();
			}
		});
		
		
		
		/********************* 글 삭제하기 ************************/
		$(".ex_delBtn").click(function(){
		console.log("삭제 버튼 클릭");
		let q_no = $(this).parents("div.ms-3").attr("data-no");	
		
		let goUrl = "";
		
		$("#ex_no").val(ex_no);
		
		
		if(confirm("정말 삭제하시겠습니까?")){
			goUrl = "/expect/expectDelete";
			$("#ex_writeForm").attr("action", goUrl);
			$("#ex_writeForm").submit();
		}
		  
		});
	
	
	
	</script>

</head>
<body>
	<div class="contentContainer container">
		<div>
			<div>
				<form id="ex_writeForm" name="ex_writeForm">
					<textarea class="form-control" rows="3" id="ex_content" name="ex_content" placeholder="내용을 작성해주세요"></textarea>
					<input type="button" id="ex_writeFormBtn" value="등록"/>
				    <input type="hidden" id="ex_no" name="ex_no" value="0" />
				</form>
			</div>
		</div>
	
          <div id="expectList" class="table-height">
            <table summary = "게시판 리스트" class="table table-striped">
              <thead>
                <tr>
                  <!--  <th data-value="ex_no" class="order text-center col-md-1">글번호</th> -->
                  <th class="text-center col-md-7">글내용</th>
                  <th th class="text-center col-md-2">아이디</th>
                  <th data-value="ex_regdate" class="order col-md-1">작성일</th>
                </tr>
              </thead>
              <tbody class="table-striped">
              
              	<c:forEach var="expect" items="${expectList}" varStatus="status">
                <tr class="text-center" data-num="${expect.ex_no}">
                 <!--   <td>${expect.ex_no}</td> -->
                  <td>${expect.ex_content}</td>
                  <td>${expect.u_id}</td>
                  <td>${expect.ex_regdate}</td>
          
                </tr>
                </c:forEach>
               
              </tbody>
            </table>
          </div>
        </div>
        
       
	

</body>
</html>