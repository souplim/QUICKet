package com.spring.admin.comm.service;

import java.util.List;

import com.spring.client.show.vo.ShowVO;

public interface AdminCommService {
	public List<ShowVO> showCommList(ShowVO vo);
	public int showListCnt(ShowVO vo);
}
