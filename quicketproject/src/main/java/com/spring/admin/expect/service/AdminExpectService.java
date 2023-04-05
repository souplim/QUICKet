package com.spring.admin.expect.service;

import java.util.List;

import com.spring.client.expect.vo.ExpectVO;

public interface AdminExpectService {
	public List<ExpectVO> adminExpectList(Integer s_num);
	//public ExpectVO expectDetail(ExpectVO evo);
	//public int expectListCnt(ExpectVO evo) throws Exception;
	public int adminExpectDelete(Integer s_num) throws Exception;
}
