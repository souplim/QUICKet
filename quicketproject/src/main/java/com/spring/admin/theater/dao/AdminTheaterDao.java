package com.spring.admin.theater.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.theater.vo.TheaterVO;

@Mapper
public interface AdminTheaterDao {
	public List<TheaterVO> theaterSelectList();
	public int showHasTheater(TheaterVO vo);
	
	public List<TheaterVO> theaterList(TheaterVO vo);
	public TheaterVO theaterOne(TheaterVO vo);
	public int theaterInsert(TheaterVO vo);
	public int theaterUpdate(TheaterVO vo);
	public int theaterDelete(TheaterVO vo);
	public int theaterListCnt(TheaterVO vo);
}
