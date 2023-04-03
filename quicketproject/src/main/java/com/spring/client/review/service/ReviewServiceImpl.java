package com.spring.client.review.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.client.review.dao.ReviewDao;
import com.spring.client.review.vo.ReviewVO;

import lombok.Setter;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Setter(onMethod_ = @Autowired)
    private ReviewDao reviewDao;
		
	// 글목록 구현
	
	@Override
	public List<ReviewVO> reviewList(Integer s_num){
		List<ReviewVO> list = null;
		list = reviewDao.reviewList(s_num);
		return list;
	}


	
	// 글입력 구현
	@Override
	public int reviewInsert(ReviewVO rvo) {
		int result = 0;
		result = reviewDao.reviewInsert(rvo);
		return result;
	}

	

	// 글수정 구현
	@Override
	public int reviewUpdate(ReviewVO rvo) {
		int result = 0;
		result = reviewDao.reviewUpdate(rvo);
		return result;
	}

	// 글삭제 구현
	@Override
	public int reviewDelete(int s_num) {
		int result = 0;
		result = reviewDao.reviewDelete(s_num);
		return result;
	}



}
