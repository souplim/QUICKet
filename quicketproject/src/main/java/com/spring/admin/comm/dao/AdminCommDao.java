package com.spring.admin.comm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.show.vo.ShowVO;

@Mapper
public interface AdminCommDao {
	public List<ShowVO> showCommList(ShowVO vo);
	public int showListCnt(ShowVO vo);
}
