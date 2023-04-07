package com.spring.client.show.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.review.vo.ReviewVO;
import com.spring.client.show.vo.ImgVO;
import com.spring.client.show.vo.RankVO;
import com.spring.client.show.vo.ShowVO;

@Mapper
public interface ClientShowDao {
	public List<ShowVO> showList(ShowVO vo);
	public ShowVO showDetail(ShowVO vo);
	public List<ImgVO> detailImg(ShowVO vo);
	public ImgVO posterImg(ShowVO vo);
	public int showListCnt(ShowVO vo);
	
	public List<ShowVO> hotShowList(ShowVO vo);
	
	public List<RankVO> rankList(ShowVO vo);
	
	public int showPointUpdate(ReviewVO vo);
}
