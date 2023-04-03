package com.spring.client.review.service;

import java.util.List;

import com.spring.client.review.vo.ReviewVO;

public interface ReviewService {

	public List<ReviewVO> reviewList(Integer s_num) ;

	public int reviewDelete(int s_num);

	public int reviewUpdate(ReviewVO rvo);

	public int reviewInsert(ReviewVO rvo);

}
