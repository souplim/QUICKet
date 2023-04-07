package com.spring.admin.faq.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.faq.vo.FaqVO;

@Mapper
public interface AdminFaqDao {
	
	public List<FaqVO> adminfaqList(FaqVO fvo); /* 검색 포함 리스트 */

	public FaqVO adminfaqDetail(FaqVO fvo);  //Detail 호출 

	public int adminfaqInsert(FaqVO fvo);

	public int adminfaqUpdate(FaqVO fvo);

	public int adminfaqDelete(int f_no);

	public int adminfaqListCnt(FaqVO fvo);
	
}

