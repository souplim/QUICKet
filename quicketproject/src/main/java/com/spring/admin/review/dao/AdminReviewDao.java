package com.spring.admin.review.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.review.vo.ReviewVO;

@Mapper
public interface AdminReviewDao {

	public List<ReviewVO> adminreviewList(ReviewVO rvo); /* 검색 포함 리스트 */

	public int reviewCnt(ReviewVO rvo);
	
	public ReviewVO adminreviewDetail(ReviewVO rvo);

	public int adminreviewDelete(int r_no);
	
}
