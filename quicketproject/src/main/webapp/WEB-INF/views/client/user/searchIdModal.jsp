<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="modal" class="modal">
        <div class="modal-dialog">
            <div class="title">
                <h2>아이디 조회 결과</h2>
            </div>
            <div class="close-area">X</div>
            	<table id="id-table">
            		<tr id="result-id" class="result">
            			<td class="r-id">ㅇ</td>
            			<td class="r-regdate">ㅇ</td>
            		</tr>
            	</table>
        </div>
    </div>
    
<div class="modal fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">아이디 찾기 결과</h4>
      </div>
      <div class="modal-body">
      	<table id="id-table">
       		<tr id="result-id" class="result">
       			<td class="r-id">ㅇ</td>
       			<td class="r-regdate">ㅇ</td>
       		</tr>
       	</table>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</body>
</html>