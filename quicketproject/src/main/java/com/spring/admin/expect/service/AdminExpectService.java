package com.spring.admin.expect.service;

import java.util.List;

import com.spring.client.expect.vo.ExpectVO;

public interface AdminExpectService {
	public List<ExpectVO> adminExpectList(ExpectVO evo);
	public ExpectVO adminExpectDetail(ExpectVO evo) throws Exception;
	public int adminExpectListCnt(ExpectVO evo) throws Exception;
	public int adminExpectDelete(int ex_no) throws Exception;
}
