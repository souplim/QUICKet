package com.spring.client.show.service;

import java.util.List;

import com.spring.client.show.vo.RankVO;
import com.spring.client.show.vo.ShowVO;

public interface ClientShowService {
	public List<ShowVO> showList(ShowVO vo);
	public List<RankVO> rankList(RankVO vo);
	public ShowVO showDetail(ShowVO vo); 
	
	public List<ShowVO> mainSlideList(ShowVO vo);
	public List<ShowVO> pointRankList(ShowVO vo);
	public List<RankVO> ticketRankList(RankVO vo);
	public List<ShowVO> newList(ShowVO vo);
	
	public int showListCnt(ShowVO vo);

} 
