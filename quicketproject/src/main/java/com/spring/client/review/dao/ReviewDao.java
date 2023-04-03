package com.spring.client.review.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.review.vo.ReviewVO;

@Mapper
public interface ReviewDao {
	public List<ReviewVO> reviewList(Integer s_num);

	public int reviewInsert(ReviewVO rvo);

	public int reviewUpdate(ReviewVO rvo);

	public int reviewDelete(int s_num);
}
