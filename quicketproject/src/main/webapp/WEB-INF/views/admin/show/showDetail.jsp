<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<style type="text/css">
	.btnBox button{
		width:200px;
	}
	th{
		text-align:center;
	}
	.detailImgHolder>img{max-width:100%;}
</style>
<script type="text/javascript">
	$(function(){
		//배역 변수의 json 변환 처리
		let s_actor_str = "<c:out value='${detail.s_actor}' />";
		//html로 decoding (안하면 따옴표를 제데로 못 읽어서 에러가 남)
		let $txt = $("<textarea></textarea>");
		$txt.html(s_actor_str)
		let s_actor_txt = $txt.val();
		
		let s_actor = JSON.parse(s_actor_txt);
		if(s_actor!=null){
			for(let act of s_actor){
				$("#s_actor").append("<p>"+act.actor+" - "+act.role+" 역</p>")
			}
		}
		//버튼 클릭시 동작 구현
		$("#returnBtn").click(function(){
			location.href="/admin/show/showList";
		});
		$("#updateShowBtn").click(function(){
			$("#f_data").attr({
				method:"get",
				action:"/admin/show/updateShow"
			});
			$("#f_data").submit();
		})
		$("#deleteShowBtn").click(function(){
			if(confirm("정말로 삭제하시겠습니까?")){
				$("#f_data").attr({
					method:"post",
					action:"/admin/show/showDelete"
				});
				$("#f_data").submit();
			}
		})
	})

</script>
</head>
<body>
	<div class="container">
	<div class="row text-center">
		<h1>${detail.s_name}</h1>
	</div>
	<div class="row">
		<span class="col-xs-3 col-xs-offset-9" >
			<strong>최초등록일자 :</strong> ${detail.s_regdate}<br/>
			<strong>최종수정일자 :</strong> ${detail.s_update}
		</span>
	</div>
	<br/>
	<div class="row">
		<div class="col-xs-8">
			<div class="row">
				<table class="table table-bordered">
					<tr>
						<th>공연명</th>
						<td>${detail.s_name}</td>
					</tr>
					<tr>
						<th>공연장</th> 
						<td>${detail.th_name}</td>
					</tr>
					<tr>
						<th>장르</th> 
						<td>${detail.s_genre}</td>
					</tr>				
					<tr>
						<th>공연기간</th>
						<td>${detail.s_opendate} ~ ${detail.s_closedate}</td>
					</tr>
					<tr>
						<th>공연시간</th>
						<td>${detail.s_time}</td>
					</tr>
					<tr>
						<th>티켓가격</th>
						<td>${detail.s_price}원</td>
					</tr>
					<tr>
						<th>캐스팅</th>
						<td id="s_actor"></td>
					</tr>
					<tr>
						<th>주최·주관</th>
						<td>${detail.s_sponsor}</td>
					</tr>
					<tr>
						<th>기획·제작</th>
						<td>${detail.s_director}</td>
					</tr>
					<tr>
						<th colspan="2" class="text-center">안내 사항</th>
					</tr>
					<tr>
						<td colspan="2">
							${detail.s_guide}
						</td>
					</tr>	
					<tr>
						<th colspan="2" class="text-center">상세 이미지</th>
					</tr>
					<tr>
						<td colspan="2" class="text-center detailImgHolder">
							<c:if test="${detail.s_detailimg ne null and not empty detail.s_detailimg}">
								<c:forEach var="detailimg" items="${detail.s_detailimg}">
									<img src="/uploadStorage/show/${detail.s_num}/detail/${detailimg.img_name}.${detailimg.img_type}" /><br/>
								</c:forEach>
							</c:if>
							<c:if test="${detail.s_detailimg eq null or empty detail.s_detailimg}">
								(상세 이미지 없음)
							</c:if>
						</td>
					</tr>		
				</table>
			</div>
		</div>
		
		<div class="col-xs-4">
			<div class="text-center detailImgHolder">
				<c:if test="${detail.s_posterimg ne null}">
					<img src="/uploadStorage/show/${detail.s_num}/poster/${detail.s_posterimg.img_name}.${detail.s_posterimg.img_type}" />
				</c:if>
				<c:if test="${detail.s_posterimg eq null}">
					(포스터 이미지 없음)
				</c:if>
			</div>
			<br />
			<div class="btnBox text-center">
				<button type="button" id="returnBtn" class="btn btn-default">돌아가기</button><br/>
				<form id="f_data">
					<input type="hidden" id="s_num" name="s_num" value="${detail.s_num}"/>
					<button type="button" id="updateShowBtn" class="btn btn-default">데이터 수정</button><br/>
					<button type="button" id="deleteShowBtn" class="btn btn-default">데이터 삭제</button>
				</form>
			</div>
		</div>
	</div>
	</div>
</body>
</html>