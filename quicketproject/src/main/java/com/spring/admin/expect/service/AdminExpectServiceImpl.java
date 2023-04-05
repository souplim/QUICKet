package com.spring.admin.expect.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.admin.expect.dao.AdminExpectDao;
import com.spring.client.expect.vo.ExpectVO;

import lombok.Setter;

@Service
public class AdminExpectServiceImpl implements AdminExpectService {

	@Setter(onMethod_ = @Autowired)
	private AdminExpectDao adminExpectDao;
	
	// 댓글 목록
	@Override
	public List<ExpectVO> adminExpectList(Integer s_num) {
		List<ExpectVO> list = null;
		list = adminExpectDao.adminExpectList(s_num);
		return list;
	}


	@Override
	public int adminExpectDelete(Integer ex_no) throws Exception {
		int result = 0;
		result = adminExpectDao.adminExpectDelete(ex_no);
		return result;
	}

	
}
