
package com.spring.admin.review.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.admin.review.dao.AdminReviewDao;
import com.spring.client.review.vo.ReviewVO;

import lombok.Setter;

@Service
public class AdminReviewServiceImpl implements AdminReviewService {
	
	@Setter(onMethod_=@Autowired)
	private AdminReviewDao adminreviewDao;

		
	// 리스트  구현 		
	@Override
	public List<ReviewVO> adminreviewList(ReviewVO rvo) {
		List<ReviewVO> list = null;
		list = adminreviewDao.adminreviewList(rvo);
		return list;
		}

	// 글상세 구현
	@Override
	public ReviewVO adminreviewDetail(ReviewVO rvo) {
		ReviewVO detail = null;
		
		//조회수 증가 멤서드 호출  추가
	//	boardDao.readCntUpdate(bvo);
		
		detail = adminreviewDao.adminreviewDetail(rvo);
		
		if(detail!=null){
			detail.setR_content(detail.getR_content().toString().replaceAll("\n", "<br />"));
		}
		return detail;
	}

	@Override
	public int adminrevewDelete(ReviewVO rvo) {
		int result = 0;
		result = adminreviewDao.adminreviewDelete(rvo.getR_no());
		return result;
	}
	


}



