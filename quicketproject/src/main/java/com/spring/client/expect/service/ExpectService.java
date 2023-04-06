package com.spring.client.expect.service;

import java.util.List;

import com.spring.client.expect.vo.ExpectVO;

public interface ExpectService {
	public List<ExpectVO> expectList(Integer s_num);
	public int expectInsert(ExpectVO evo) throws Exception;
	public int expectUpdate(ExpectVO evo) throws Exception;
	public int expectDelete(int s_num) throws Exception;

	//public int readCntUpdate(ExpectVO evo);
}
