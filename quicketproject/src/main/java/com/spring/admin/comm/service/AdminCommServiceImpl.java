package com.spring.admin.comm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.admin.comm.dao.AdminCommDao;
//import com.spring.client.show.vo.ImgVO;
import com.spring.client.show.vo.ShowVO;

import lombok.Setter;

@Service
public class AdminCommServiceImpl implements AdminCommService {
	
	@Setter(onMethod_ = @Autowired)
	private AdminCommDao adminCommDao;

	@Override
	public List<ShowVO> showCommList(ShowVO vo) {
		List<ShowVO> showList = null;
		showList = adminCommDao.showCommList(vo);
		return showList;
	}


	@Override
	public int showListCnt(ShowVO vo) {
		int countNum = 0;
		countNum = adminCommDao.showListCnt(vo);
		return countNum;
	}
}
