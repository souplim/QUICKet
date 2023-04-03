package com.spring.admin.faq.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.admin.faq.dao.AdminFaqDao;
import com.spring.client.faq.vo.FaqVO;

import lombok.Setter;

@Service
public class AdminFaqServiceImpl implements AdminFaqService {
	
	@Setter(onMethod_=@Autowired)
	private AdminFaqDao adminfaqDao;

		
	// 리스트  구현 		
	@Override
	public List<FaqVO> adminfaqList(FaqVO fvo) {
		List<FaqVO> list = null;
		list = adminfaqDao.adminfaqList(fvo);
		return list;
		}

	
// 글상세 구현
	@Override
	public FaqVO adminfaqDetail(FaqVO fvo) {
		FaqVO detail = null;
		
		//조회수 증가 멤서드 호출  추가
	//	boardDao.readCntUpdate(bvo);
		
		detail = adminfaqDao.adminfaqDetail(fvo);
		
		if(detail!=null){
			detail.setF_content(detail.getF_content().toString().replaceAll("\n", "<br />"));
		}
		return detail;
	}
	
	

	// 글입력 구현
		@Override
		public int adminfaqInsert(FaqVO fvo) throws Exception{
			int result = 0;
			
					
			/* 예외를 발생시킬 코드 작성 
			bvo.setB_num(0);
				if(bvo.getB_num() == 0){
				throw new IllegalArgumentException("0번 글은 등록할 수 없습니다.");				
			}			
			 */		

			result = adminfaqDao.adminfaqInsert(fvo);
			return result;
		}


		@Override
		public FaqVO adminfaqupdateForm(FaqVO fvo) {
			FaqVO updateData = null;
			updateData = adminfaqDao.adminfaqDetail(fvo);
			return updateData;
		}
		
		// 글수정 구현
		@Override
		public int adminfaqUpdate(FaqVO fvo) {
			int result = 0;		
		
			result = adminfaqDao.adminfaqUpdate(fvo);
			return result;
		 }


		/* 글삭제 구현 */
		@Override
		/* public int boardDelete(int b_num){ */
		public int adminfaqDelete(FaqVO fvo) {
			int result = 0;
						
			result = adminfaqDao.adminfaqDelete(fvo.getF_no());
			return result;
		}




}
