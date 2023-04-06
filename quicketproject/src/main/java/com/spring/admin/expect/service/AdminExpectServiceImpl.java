package com.spring.admin.expect.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.client.expect.dao.ExpectDao;
import com.spring.client.expect.vo.ExpectVO;

import lombok.Setter;

@Service
public class AdminExpectServiceImpl implements AdminExpectService {

	@Setter(onMethod_ = @Autowired)
	private ExpectDao expectDao;
	
	// 댓글 목록
	@Override
	public List<ExpectVO> adminExpectList(ExpectVO evo) {
		List<ExpectVO> list = null;
		list = expectDao.adminExpectList(evo);
		return list;
	}


	@Override
	public int adminExpectDelete(int ex_no) throws Exception {
		int result = 0;
		result = expectDao.expectDelete(ex_no);
		return result;
	}

	// 상세페이지
	@Override
	public ExpectVO adminExpectDetail(ExpectVO evo) throws Exception {
		ExpectVO detail = null;
		
		detail = expectDao.adminExpectDetail(evo);
		if(detail != null) {
			detail.setEx_content(detail.getEx_content().replaceAll("\n",  "<br />")); 
			}
		return detail;
	}

	// 전체 글 개수
	@Override
	public int adminExpectListCnt(ExpectVO evo) throws Exception {
		return expectDao.adminExpectListCnt(evo);
	}

	
}
