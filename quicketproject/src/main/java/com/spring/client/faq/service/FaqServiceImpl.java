package com.spring.client.faq.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.client.faq.dao.FaqDao;
import com.spring.client.faq.vo.FaqVO;

import lombok.Setter;

@Service
public class FaqServiceImpl implements FaqService {

	
		@Setter(onMethod_=@Autowired)
		private FaqDao faqDao;
	
			
		// 리스트  구현 		
		@Override
		public List<FaqVO> faqList(FaqVO fvo) {
			List<FaqVO> list = null;
			list = faqDao.faqList(fvo);
			return list;
			}
		
		
	// 글상세 구현
		@Override
		public FaqVO faqDetail(FaqVO fvo) {
			FaqVO detail = null;
			
			//조회수 증가 멤서드 호출  추가
		//	boardDao.readCntUpdate(bvo);
			
			detail = faqDao.faqDetail(fvo);
			
			if(detail!=null){
				detail.setF_content(detail.getF_content().toString().replaceAll("\n", "<br />"));
			}
			return detail;
		}

}





/* 글목록 구현 
@Override
public List<FaqVO> faqList() {
	
	List<FaqVO>  list = null;
	list = faqDao.faqList();	
	
	return list;
}
*/

