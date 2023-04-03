package com.spring.client.faq.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.faq.vo.FaqVO;

@Mapper
public interface FaqDao {
	
	public List<FaqVO> faqList(FaqVO fvo); /* 검색 포함 리스트 */

	public FaqVO faqDetail(FaqVO fvo);  //Detail 호출 
	
    // public List<FaqVO> faqList();

}


