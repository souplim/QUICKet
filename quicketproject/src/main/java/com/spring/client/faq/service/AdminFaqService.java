package com.spring.client.faq.service;

import java.util.List;

import com.spring.client.faq.vo.FaqVO;

public interface AdminFaqService {
	
	// public List<FaqVO> faqList();
	public List<FaqVO> adminfaqList(FaqVO fvo); 
	//상세 페이지 이동
	
	public FaqVO adminfaqDetail(FaqVO fvo);

	public int adminfaqInsert(FaqVO fv) throws Exception;

	public FaqVO adminfaqupdateForm(FaqVO fvo);
	public int adminfaqUpdate(FaqVO fvo);

	public int adminfaqDelete(FaqVO fvo);


}
