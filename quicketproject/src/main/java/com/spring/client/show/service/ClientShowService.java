package com.spring.client.show.service;

import java.util.List;

import com.spring.client.review.vo.ReviewVO;
import com.spring.client.show.vo.RankVO;
import com.spring.client.show.vo.ShowVO;

public interface ClientShowService {
	//메인페이지, 장르 페이지지의 슬라이드와 랭킹박스 관련 서비스
	public List<ShowVO> mainSlideList(ShowVO vo);
	public List<ShowVO> pointRankList(ShowVO vo);
	public List<RankVO> ticketRankList(ShowVO vo);
	public List<ShowVO> newList(ShowVO vo);
	public List<ShowVO> hotShowList(ShowVO vo);
	
	//검색페이지의 검색리스트 관련 서비스
	public List<ShowVO> showList(ShowVO vo);
	public int showListCnt(ShowVO vo);
	
	//상세페이지의 정보 관련 서비스
	public ShowVO showDetail(ShowVO vo); 
  
	//랭킹 페이지의 랭킹 정보 관련 서비스
	public List<RankVO> rankList(ShowVO vo);
	
	public int showPointUpdate(ReviewVO vo);
	
} 
