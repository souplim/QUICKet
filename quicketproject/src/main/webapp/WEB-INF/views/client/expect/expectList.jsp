<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>

<style type="text/css">
   #expect-template{display: none;}
   .inline{display:inline-block;}
   
</style>


<script type = "text/javascript">
      $(function(){
         
         /* 기본 댓글 목록 불러오기 */
         let s_num = ${detailData.s_num};
         
         expectListAll(s_num);
         
         /** 글 입력을 위한 Ajax 연동 처리 */
         $(document).on("click", "#expectReplyInsertBtn", function(){
            let id = "${userLogin.u_id}";
            
            if(id != ""){
               let insertUrl = "/expect/expectInsert";
               
               let value = JSON.stringify({
                  ex_title:$("#ex_title").val(),
                  ex_content:$("#ex_content").val(),
                  s_num:s_num
               });
               {}
               $.ajax({
                  url: insertUrl,
                  type: "post",
                  headers : {
                     "Content-Type":"application/json"
                  },
                  dataType:"text",
                  data : value,
                  error: function(xhr, textStatus, errorThrown){
                     alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
                  },
                  beforeSend: function(){   
                     if(!checkForm("#ex_title","댓글 제목을 "))   return false;
                     if(!checkForm("#ex_content", "댓글 내용을 ")) return false;
                  },
                  success : function(result){
                     if(result == "SUCCESS"){
                        alert("댓글 등록이 완료되었습니다.");
                        dataReset();
                        expectListAll(s_num);
                     }
                  }
               });
            } else {
               alert("로그인 후 서비스를 이용하실 수 있습니다.");
               location.href = "/user/login";
            }
         });
         
         /** 수정 클릭  */
         $(document).on("click", ".upBtn", function(){
            let panel = $(this).parents("div.panel");
            let ex_no = panel.attr("data-num");
            console.log("ex_no: " + ex_no);
            
            expectUpdateForm(ex_no, panel);
         });
         
         /** 삭제 클릭  */
         $(document).on("click", ".delBtn", function(){
            let panel = $(this).parents("div.panel");
            let ex_no = panel.attr("data-num");
            //console.log("q_r_no: " + q_r_no);
            //console.log("q_no: " + q_no);
            
            deleteBtn(s_num, ex_no);
         });
         
         /** 수정 폼 화면 구현 함수 */
         function expectUpdateForm(ex_no, panel){
            //$("#replyForm" .resetBtn).detach();
            
            let content = panel.find(".panel-body").html();
            let title = panel.find(".panel-heading > .panel-title > .title").html();
            content = content.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n');   
            $("#ex_content").val(content);
            $("#ex_title").val(title);
            
            $("#expectReplyForm button[type='button']").attr("id", "expectReplyUpdateBtn");   // 등록버튼에 id=replyUpdateBtn으로 속성 부여
            $("#expectReplyForm button[type='button']").attr("data-num", ex_no);
            $("#expectReplyForm button[type='button']").html("수정");   // 등록 -> 수정 버튼으로 변경
            
            let resetButton = $("<button type='button' class='btn btn-primary resetBtn'>");   //취소버튼 생성?
            resetButton.html("취소");
            $("#expectReplyForm .sendBtn").after(resetButton);   // 기존등록버튼 뒤에 취소버튼 추가. .after() - 선택한 요소 뒤에 새 요소를 추가하거나, 다른 곳에 있는 요소를 이동시키는 메서드
         }
         
         $(document).on("click", ".resetBtn", function(){
            dataReset();
         });
      
         
         /** 수정을 위한 Ajax 연동 처리 */
         $(document).on("click", "#expectReplyUpdateBtn", function(){
            let ex_no = $(this).attr("data-num");
            $.ajax({
               url:'/expect/'+ex_no,
               type: 'put',
               headers: {
                  "Content-Type": "application/json",
                  "X-HTTP-Method-Override":"PUT"
               },
               data:JSON.stringify({   
                  ex_content:$("#ex_content").val(),
                  ex_title:$("#ex_title").val(),
               }),
               dataType:'text',
               error: function(xhr, textStatus, errorThrown){
                  alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
                  
               },
               beforeSend: function(){
                  if(!checkForm("#ex_title", "댓글 제목을 ")) return false;
                  if(!checkForm("#ex_content", "댓글 내용을 ")) return false;   
               },
               success:function(result){
                  console.log("result: "+result);
                  if(result == "SUCCESS"){
                     alert("댓글 수정이 완료 되었습니다.");
                     dataReset();
                     expectListAll(s_num);
                  }
               }
            });
         });
      });
      
      /** 댓글 목록 보여주는 함수 - 서버로부터 리스트 받아오기 위한 요청함수 */
      function expectListAll(s_num){
         $(".expectReply").detach();   //선택한 요소를 DOM트리에서 삭제
         
         let url = "/expect/all/"+ s_num;
         
         $.getJSON(url, function(data){
            $(data).each(function(){
               let ex_no = this.ex_no;
               let ex_title = this.ex_title;
               let u_id = this.u_id;
               let ex_content = this.ex_content;
               let ex_regdate = this.ex_regdate;
               ex_content = ex_content.replace(/(\r\n|\r|\n)/g, "<br />");
               expectTemplate(ex_no, ex_title, u_id, ex_content, ex_regdate);
            });
         }).fail(function(){
            alert("댓글 목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해주세요");
         });
      }
      
      /** 새로운 글을 화면에 추가하여 보여주기 위한 함수 **/
      function expectTemplate(ex_no, ex_title, u_id, ex_content, ex_regdate){
         
         let id = "${userLogin.u_id}";
         let $div = $('#expectList');
         
         let $element = $('#expect-template').clone().removeAttr('id');
         $element.attr("data-num", ex_no);
         $element.addClass("expectReply");
         $element.find('.panel-heading > .panel-title > .title').html(ex_title);
         $element.find('.panel-heading > .panel-title > .id').html("&nbsp&nbsp|&nbsp&nbsp" + u_id);
         $element.find('.panel-heading > .panel-title > .date').html("&nbsp&nbsp|&nbsp&nbsp" + ex_regdate);
         
         if(id == u_id){
            $element.find('.panel-heading > .panel-title > button').show();
            
         } else {
            
            $element.find('.panel-heading > .panel-title > button').hide();
         }
         $element.find('.panel-body').html(ex_content);
         
         $div.append($element);
      }
      
      /* 입력 폼 초기화 */
      function dataReset(){
         $("#expectReplyForm").each(function(){
            this.reset();
         });
         
         $("#u_id").prop("readonly", false);
         $("#expectReplyForm button[type='button']").removeAttr("data-num");
         $("#expectReplyForm button[type='button']").attr("id", "expectReplyInsertBtn");
         $("#expectReplyForm button[type='button'].sendBtn").html("등록");
         $("#expectReplyForm button[type='button'].resetBtn").detach();
      }
      
      /** 글 삭제를 위한 Ajax 연동 처리 **/
      function deleteBtn(s_num, ex_no){
         if(confirm("선택하신 댓글을 삭제하시겠습니까?")){
            $.ajax({
               url : '/expect/'+ex_no,
               type: 'delete',
               headers : {
                  "X-HTTP-Method-Override" : "DELETE"
               },
               dataType : 'text',
               error: function(xhr, textStatus, errorThrown){
                  alert(textStatus + " (HTTP-" +xhr.status + "/ " + errorThrown + ")");
               },
               success : function(result){
                  console.log("result: "+result);
                  if(result == 'SUCCESS'){
                     alert("댓글 삭제가 완료되었습니다.");
                     expectListAll(s_num);
                  }
               }
            });
         } else {
            formHide();
         }
      }
   </script>

   </head>
   <body>

   <div id = "replyContainter">
         <div class="expectNotice">
            <div id="noticeHeader">
            <h4>꼭 읽어주세요(운영규정)</h4>
            </div>
            <div id="noticeText">
            게시판 운영 규정에 어긋난다고 판단되는 게시글은 사전 통보없이 블라인드 처리될 수 있습니다.<br/>
            특히 티켓 매매 및 양도의 글은 발견 즉시 임의 삭제되며 전화번호, 이메일 등의 개인정보는 악용될 우려가 있으므로 게시를 삼가 주시기 바랍니다.<br/>
            사전 경고에도 불구하고 불량 게시물을 계속적으로 게재한 게시자의 경우 QUICKet 게시판 작성 권한이 제한됩니다. <br/> <br/>
            </div>
         </div>

         <%-- 댓글 작성하는 화면 --%>
         <form id = "expectReplyForm" name="expectReplyForm">
            <div class="panel panel-default">
               <table class="table">
                  <tbody>
                     <tr>
                        <td class="col-md-2">작성자</td>
                        <td class="col-md-3 text-left">
                           ${userLogin.u_id}
                        </td>
                        <td class="col-md-1">제목</td>
                        <td class="col-md-3">
                           <input type="text" name="ex_title" id="ex_title" class="form-control">
                        </td>
                           <td class="col-md-4-btnArea">
                              <button type="button" id="expectReplyInsertBtn" class="btn btn-primary gap sendBtn">등록</button>
                           </td>
                     </tr>
                     <tr>
                        <td class="col-md-1">내용</td>
                        <td colspan="4" class="col-md-11 text-left">
                           <textarea name="ex_content" id="ex_content" class="form-control" rows="3"></textarea>
                        </td>
                     </tr>
                  </tbody>
               </table>
            </div>
         </form>
         
         
         <%-- 댓글 리스트 출력되는 영역 --%>
         <div id="expectList">
            <div id="expect-template" class="panel panel-primary">
               <div class="panel-heading">
                  <h3 class="panel-title">
                     <span class="title"></span>
                     <span class="id"></span>
                     <span class="date"></span>
                        <button type="button" data-btn="upBtn" class="btn btn-default gap upBtn">수정하기</button>
                        <button type="button" data-btn="delBtn" class="btn btn-default gap delBtn">삭제하기</button>
                  </h3>
               </div>
               <div class="panel-body"></div>
            </div>
         </div>
      </div>

</body>
</html>