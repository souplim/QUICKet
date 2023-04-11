package com.spring.client.qna.dao;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.spring.client.qna.vo.QnaVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@SpringBootTest
@Slf4j
public class QnaDaoTests {

	@Setter(onMethod_ = @Autowired)
	private QnaDao qnaDao;
	
	/**/
	@Test
	public void testQnaList(Integer s_num) {
		List<QnaVO> list = null;
		list = qnaDao.qnaList(s_num);
		
		for(QnaVO qvo : list) {
			log.info(qvo.toString());
		}
	} 
	
	/*
	@Test
	public void testQnaDelete() {
		int result = qnaDao.qnaDelete(30);
		log.info("삭제결과: " + result);
	} */
	

	
}
