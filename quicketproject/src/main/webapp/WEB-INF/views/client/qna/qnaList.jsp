<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>


</head>
<body>
	<!--  
		<div id="boardList" class="table-height">
			<table summary="게시판 리스트" class="table table-hover">
				<thead>
					<tr>
						<th data-value="q_no" class="order text-center col-md-1">글번호</th>
						<th class="text-center col-md-4">글제목</th>
						<th class="text-center col-md-2">작성자</th>
						<th data-value="b_date" class="order col-md-1">작성일</th>	
						<th class="text-center col-md-1">조회수</th>
						<th class="text-center col-md-3">이미지</th>
					</tr>
				</thead>
				<tbody id="list" class="table-hover"> -->
					<!-- 데이터 출력 -->
					<!--<c:choose>
						<c:when test="${not empty qnaList}">
							<c:forEach var="qna" items="${qnaList}" varStatus="status">
								<tr class="text-center" data-num="${qna.q_title }">
									<td>${qna.q_title}</td>
									<td class="goDetail text-left">${qna.q_title}
										
										<!--<c:if test="${qna.q_r_cnt > 0 }">
											<span class="reply_count">[${board.r_cnt}]</span>
										</c:if> -->
									<!--  </td>  
									<td class="userid">${qna.u_id }</td>
									<td class="text-left">${qna.q_regdate}</td>
									
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="4" class="tac text-center">등록된 게시글이 존재하지 않습니다.</td>
							</tr>
						</c:otherwise>
					</c:choose>
				
				</tbody>
			</table>
			</div> -->
			
			<div class="container-fluid mt-100">
<div class="d-flex flex-wrap justify-content-between">
<div> <button type="button" class="btn btn-shadow btn-wide btn-primary"> <span class="btn-icon-wrapper pr-2 opacity-7"> <i class="fa fa-plus fa-w-20"></i> </span> New thread </button> </div>
<div class="col-12 col-md-3 p-0 mb-3"> <input type="text" class="form-control" placeholder="Search..."> </div>
</div>
<div class="card mb-3">
<div class="card-header pl-0 pr-0">
<div class="row no-gutters w-100 align-items-center">
<div class="col ml-3">Topics</div>
<div class="col-4 text-muted">
<div class="row no-gutters align-items-center">
<div class="col-4">Replies</div>
<div class="col-8">Last update</div>
</div>
</div>
</div>
</div>
<div class="card-body py-3">
<div class="row no-gutters align-items-center">
<div class="col"> <a href="javascript:void(0)" class="text-big" data-abc="true">How can i change the username?</a>
<div class="text-muted small mt-1">Started 25 days ago &nbsp;·&nbsp; <a href="javascript:void(0)" class="text-muted" data-abc="true">Neon Mandela</a></div>
</div>
<div class="d-none d-md-block col-4">
<div class="row no-gutters align-items-center">
<div class="col-4">12</div>
<div class="media col-8 align-items-center"> <img src="https://res.cloudinary.com/dxfq3iotg/image/upload/v1574583246/AAA/2.jpg" alt="" class="d-block ui-w-30 rounded-circle">
<div class="media-body flex-truncate ml-2">
<div class="line-height-1 text-truncate">1 day ago</div> <a href="javascript:void(0)" class="text-muted small text-truncate" data-abc="true">by Tim cook</a>
</div>
</div>
</div>
</div>
</div>
</div>
<hr class="m-0">
 <div class="card-body py-3">
<div class="row no-gutters align-items-center">
<div class="col"> <a href="javascript:void(0)" class="text-big" data-abc="true">How to change the theme to dark mode?</a> <span class="badge badge-success align-text-bottom ml-1">Solved</span>
<div class="text-muted small mt-1">Started 5 days ago &nbsp;·&nbsp; <a href="javascript:void(0)" class="text-muted" data-abc="true">Allize Rome</a></div>
</div>
<div class="d-none d-md-block col-4">
<div class="row no-gutters align-items-center">
<div class="col-4">43</div>
<div class="media col-8 align-items-center"> <img src="https://res.cloudinary.com/dxfq3iotg/image/upload/v1574583319/AAA/3.jpg" alt="" class="d-block ui-w-30 rounded-circle">
<div class="media-body flex-truncate ml-2">
<div class="line-height-1 text-truncate">1 day ago</div> <a href="javascript:void(0)" class="text-muted small text-truncate" data-abc="true">by Steve smith</a>
</div>
</div>
</div>
</div>
</div>
</div>
<hr class="m-0">
<div class="card-body py-3">
<div class="row no-gutters align-items-center">
<div class="col"> <a href="javascript:void(0)" class="text-big" data-abc="true">Is it possible to get the refund of the product i purhcased today?</a> <span class="badge badge-default align-text-bottom ml-1">Locked</span>
<div class="text-muted small mt-1">Started 21 days ago &nbsp;·&nbsp; <a href="javascript:void(0)" class="text-muted" data-abc="true">Kane William</a></div>
</div>
<div class="d-none d-md-block col-4">
<div class="row no-gutters align-items-center">
<div class="col-4">42</div>
<div class="media col-8 align-items-center"> <img src="https://res.cloudinary.com/dxfq3iotg/image/upload/v1574583336/AAA/4.jpg" alt="" class="d-block ui-w-30 rounded-circle">
<div class="media-body flex-truncate ml-2">
<div class="line-height-1 text-truncate">2 day ago</div> <a href="javascript:void(0)" class="text-muted small text-truncate" data-abc="true">by Brethwett sonm</a>
</div>
</div>
</div>
</div>
</div>
</div>
<hr class="m-0">
<div class="card-body py-3">
<div class="row no-gutters align-items-center">
<div class="col"> <a href="javascript:void(0)" class="text-big" data-abc="true">Do you have android application for this tool?</a>
<div class="text-muted small mt-1">Started 56 days ago &nbsp;·&nbsp; <a href="javascript:void(0)" class="text-muted" data-abc="true">Glen Maxwell</a></div>
</div>
<div class="d-none d-md-block col-4">
<div class="row no-gutters align-items-center">
<div class="col-4">632</div>
<div class="media col-8 align-items-center"> <img src="https://res.cloudinary.com/dxfq3iotg/image/upload/v1574583246/AAA/2.jpg" alt="" class="d-block ui-w-30 rounded-circle">
<div class="media-body flex-truncate ml-2">
<div class="line-height-1 text-truncate">11 day ago</div> <a href="javascript:void(0)" class="text-muted small text-truncate" data-abc="true">by Neil patels</a>
</div>
</div>
</div>
</div>
</div>
</div>
<hr class="m-0">
<div class="card-body py-3">
<div class="row no-gutters align-items-center">
<div class="col"> <a href="javascript:void(0)" class="text-big" data-abc="true">How can i transfer my fund to my friend</a> <span class="badge badge-secondary align-text-bottom ml-1">Closed</span>
<div class="text-muted small mt-1">Started 25 days ago &nbsp;·&nbsp; <a href="javascript:void(0)" class="text-muted" data-abc="true">Marry Tom</a></div>
</div>
<div class="d-none d-md-block col-4">
<div class="row no-gutters align-items-center">
<div class="col-4">53</div>
<div class="media col-8 align-items-center"> <img src="https://res.cloudinary.com/dxfq3iotg/image/upload/v1574583336/AAA/4.jpg" alt="" class="d-block ui-w-30 rounded-circle">
<div class="media-body flex-truncate ml-2">
<div class="line-height-1 text-truncate">1 day ago</div> <a href="javascript:void(0)" class="text-muted small text-truncate" data-abc="true">by Tibok tom</a>
</div>
</div>
</div>
</div>
</div>
</div>
<hr class="m-0">
<div class="card-body py-3">
<div class="row no-gutters align-items-center">
<div class="col"> <a href="javascript:void(0)" class="text-big" data-abc="true">How can i delete my account?</a> <span class="badge badge-danger align-text-bottom ml-1">Hot!</span>
<div class="text-muted small mt-1">Started 25 days ago &nbsp;·&nbsp; <a href="javascript:void(0)" class="text-muted" data-abc="true">Bob bulmer</a></div>
</div>
<div class="d-none d-md-block col-4">
<div class="row no-gutters align-items-center">
<div class="col-4">12</div>
<div class="media col-8 align-items-center"> <img src="https://res.cloudinary.com/dxfq3iotg/image/upload/v1574583246/AAA/2.jpg" alt="" class="d-block ui-w-30 rounded-circle">
<div class="media-body flex-truncate ml-2">
 <div class="line-height-1 text-truncate">1 day ago</div> <a href="javascript:void(0)" class="text-muted small text-truncate" data-abc="true">by Ross taylor</a>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
<nav>
<ul class="pagination mb-5">
<li class="page-item disabled"><a class="page-link" href="javascript:void(0)" data-abc="true">«</a></li>
<li class="page-item active"><a class="page-link" href="javascript:void(0)" data-abc="true">1</a></li>
<li class="page-item"><a class="page-link" href="javascript:void(0)" data-abc="true">2</a></li>
<li class="page-item"><a class="page-link" href="javascript:void(0)" data-abc="true">3</a></li>
<li class="page-item"><a class="page-link" href="javascript:void(0)" data-abc="true">»</a></li>
</ul>
</nav>
</div> 
</body>
</html>