package com.spring.admin.theater.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.admin.theater.dao.AdminTheaterDao;
import com.spring.client.theater.vo.TheaterVO;

import lombok.Setter;

@Service
public class AdminTheaterServiceImpl implements AdminTheaterService{

	@Setter(onMethod_=@Autowired)
	private AdminTheaterDao adminTheaterDao;

	@Override
	public List<TheaterVO> theaterList(TheaterVO vo) {
		List<TheaterVO> list = adminTheaterDao.theaterList(vo);
		return list;
	}

	@Override
	public List<TheaterVO> theaterSelectList() {
		List<TheaterVO> list = adminTheaterDao.theaterSelectList();
		return list;
	}
	
	@Override
	public TheaterVO theaterOne(TheaterVO vo) {
		TheaterVO result = adminTheaterDao.theaterOne(vo);
		return result;
	}

	@Override
	public int theaterInsert(TheaterVO vo) {
		int result = 0;
		result = adminTheaterDao.theaterInsert(vo);
		return result;
	}

	@Override
	public int theaterUpdate(TheaterVO vo) {
		int result = 0;
		result = adminTheaterDao.theaterUpdate(vo);
		return result;
	}

	@Override
	public int theaterDelete(TheaterVO vo) {
		int checkNum = adminTheaterDao.showHasTheater(vo);
		int result = 0;
		if(checkNum>0) {
			result = 500;
		}else {
			result = adminTheaterDao.theaterDelete(vo);
		}
		return result;
	}
	
	@Override
	public int theaterListCnt(TheaterVO vo) {
		int result = adminTheaterDao.theaterListCnt(vo);
		return result;
	}
}
