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
	
	//public int expectAdminDelete(int ex_no);
	//public ExpectVO expectUpdateForm(ExpectVO evo);
}
