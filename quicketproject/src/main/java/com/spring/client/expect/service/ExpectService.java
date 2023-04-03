package com.spring.client.expect.service;

import java.util.List;

import com.spring.client.expect.vo.ExpectVO;

public interface ExpectService {
	public List<ExpectVO> expectList(ExpectVO evo);
	public int expectInsert(ExpectVO evo) throws Exception;
	public int expectUpdate(ExpectVO evo) throws Exception;
	public int expectDelete(ExpectVO evo) throws Exception;
}
