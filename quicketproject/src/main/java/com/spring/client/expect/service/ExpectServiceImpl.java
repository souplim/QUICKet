package com.spring.client.expect.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.client.expect.dao.ExpectDao;
import com.spring.client.expect.vo.ExpectVO;

import lombok.Setter;

@Service
public class ExpectServiceImpl implements ExpectService {
	
	@Setter(onMethod_ = @Autowired)
	private ExpectDao expectDao;

	// 글 목록 구현
	@Override
	public List<ExpectVO> expectList(ExpectVO evo) {
		List<ExpectVO> list = null;
		list = expectDao.expectList(evo);
		return list;
	}

	// 글 입력 구현
	@Override
	public int expectInsert(ExpectVO evo) throws Exception {
		int result = 0;
		
		result = expectDao.expectInsert(evo);
		return result;
	}

	// 글 수정 구현
	@Override
	public int expectUpdate(ExpectVO evo) throws Exception {
		int result = 0;
		result = expectDao.expectUpdate(evo);
		return result;
	}

	// 글 삭제 구현
	@Override
	public int expectDelete(ExpectVO evo) throws Exception {
		int result = 0;
		result = expectDao.expectDelete(evo.getEx_no());
		return result;
	}
	
	
}
