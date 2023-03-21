package com.spring.client.inq.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.inq.vo.InqVO;

@Mapper
public interface InqDao {

	public List<InqVO> inqList(); /* 리스트 */
}
