package com.spring.admin.expect.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.expect.vo.ExpectVO;

@Mapper
public interface AdminExpectDao {
	public List<ExpectVO> expectList(int s_num);
	public ExpectVO adminExpectDetail(ExpectVO evo) throws Exception;
	public int adminExpectListCnt(ExpectVO evo) throws Exception;
	//public int expectInsert(ExpectVO evo);
	//public int expectUpdate(ExpectVO evo);
	public int expectDelete(int s_num);
}
