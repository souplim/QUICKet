package com.spring.admin.show.service;

import java.util.List;

import com.spring.client.show.vo.RankVO;
import com.spring.client.show.vo.ShowVO;

public interface AdminShowService {
	public List<ShowVO> showList(ShowVO vo);
	public ShowVO showDetail(ShowVO vo);
	public int showInsert(ShowVO vo) throws Exception;
	public int showUpdate(ShowVO vo) throws Exception;
	public int showDelete(ShowVO vo) throws Exception;
	
	public int showListCnt(ShowVO vo);
}
