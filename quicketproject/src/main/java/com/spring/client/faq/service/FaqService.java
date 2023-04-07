package com.spring.client.faq.service;

import java.util.List;

import com.spring.client.faq.vo.FaqVO;

public interface FaqService {
	
	// public List<FaqVO> faqList();
		public List<FaqVO> faqList(FaqVO fvo); 
		//상세 페이지 이동
		
		public FaqVO faqDetail(FaqVO fvo);

		public int faqListCnt(FaqVO fvo);

	
		
}
