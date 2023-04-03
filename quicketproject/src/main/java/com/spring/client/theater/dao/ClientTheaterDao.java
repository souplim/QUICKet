package com.spring.client.theater.dao;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.show.vo.ShowVO;
import com.spring.client.theater.vo.TheaterVO;

@Mapper
public interface ClientTheaterDao {
	public TheaterVO theaterOne(ShowVO vo);
}
