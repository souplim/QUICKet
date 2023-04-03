package com.spring.client.inq.reply.dao;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.spring.client.inq.reply.vo.InqReplyVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@SpringBootTest
@Slf4j
public class InqReplyMapperTests {
	
	@Setter(onMethod_=@Autowired)
	private InqReplyDao inqReplyDao;
	
	@Test
	public void testInqReplyList() {
		log.info("inqReplyList() 메서드 실행");
		List<InqReplyVO> list = inqReplyDao.inqReplyList(1);
		for(InqReplyVO vo : list)
			log.info(vo.toString());
	}
}
