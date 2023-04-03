package com.spring.client.review.service;


import java.util.List;

import com.spring.client.review.vo.ReviewVO;

public interface AdminReviewService {

	public List<ReviewVO> adminreviewList(ReviewVO rvo);

	public ReviewVO adminreviewDetail(ReviewVO rvo);

	public int adminrevewDelete(ReviewVO rvo); 

}


