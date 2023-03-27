package com.spring.admin.show.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.show.vo.ImgVO;
import com.spring.client.show.vo.RankVO;
import com.spring.client.show.vo.ShowVO;

@Mapper
public interface AdminShowDao {
	public List<ShowVO> showList(ShowVO vo);
	public List<RankVO> rankList(RankVO vo);
	public ShowVO showDetail(ShowVO vo);
	public int showInsert(ShowVO vo);
	public int showUpdate(ShowVO vo);
	public int showDelete(ShowVO vo);
	
	public int showListCnt(ShowVO vo);
}
