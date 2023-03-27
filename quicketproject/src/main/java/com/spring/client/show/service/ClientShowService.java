package com.spring.client.show.service;

import java.util.List;

import com.spring.client.show.vo.RankVO;
import com.spring.client.show.vo.ShowVO;

public interface ClientShowService {
	public List<ShowVO> showList(ShowVO vo);
	public List<RankVO> rankList(RankVO vo);
	public ShowVO showDetail(ShowVO vo);
	
} 
