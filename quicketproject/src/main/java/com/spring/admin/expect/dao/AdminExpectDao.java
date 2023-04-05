package com.spring.admin.expect.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.expect.vo.ExpectVO;

@Mapper
public interface AdminExpectDao {
	public List<ExpectVO> adminExpectList(Integer s_num);
	//public ExpectVO expectDetail(ExpectVO evo);
	//public int expectListCnt(ExpectVO evo) throws Exception;
	public int adminExpectDelete(Integer s_num) throws Exception;
}
