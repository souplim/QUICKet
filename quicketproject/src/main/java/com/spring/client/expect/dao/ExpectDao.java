package com.spring.client.expect.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.expect.vo.ExpectVO;

@Mapper
public interface ExpectDao {
	public List<ExpectVO> expectList(Integer s_num);
	public int expectInsert(ExpectVO evo);
	public int expectUpdate(ExpectVO evo);
	public int expectDelete(int s_num);
	
	public List<ExpectVO> adminExpectList(ExpectVO evo);
	public ExpectVO adminExpectDetail(ExpectVO evo) throws Exception;
	public int adminExpectListCnt(ExpectVO evo) throws Exception;
	public int adminExpectDelete(int ex_no) throws Exception;
}


