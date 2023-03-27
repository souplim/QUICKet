package com.spring.admin.theater.service;

import java.util.List;

import com.spring.client.theater.vo.TheaterVO;

public interface AdminTheaterService {
	public List<TheaterVO> theaterSelectList();
	
	public List<TheaterVO> theaterList(TheaterVO vo);
	public TheaterVO theaterOne(TheaterVO vo); 
	public int theaterInsert(TheaterVO vo);
	public int theaterUpdate(TheaterVO vo);
	public int theaterDelete(TheaterVO vo);
	public int theaterListCnt(TheaterVO vo);
}
