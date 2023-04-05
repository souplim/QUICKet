package com.spring.admin.inq.dao;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.spring.client.inq.dao.InqDao;
import com.spring.client.inq.reply.vo.InqReplyVO;
import com.spring.client.inq.vo.InqVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@SpringBootTest
@Slf4j
public class AdminInqMapperTests {
	
	@Setter(onMethod_=@Autowired)
	private AdminInqDao adminInqDao;
	
	@Setter(onMethod_=@Autowired)
	private InqDao inqDao;
	
	/* @Test
	public void testInqList() {
		log.info("inqList() 메서드 실행");
		InqVO inqVO = new InqVO();
		inqVO.setU_id("yubin");
		List<InqVO> list = adminInqDao.inqList(inqVO);
		for(InqVO vo : list)
			log.info(vo.toString());
	} */
	
	/* @Test
	public void testInqCateList() {
		log.info("inqCateList() 메서드 실행");
		InqVO inqVO = new InqVO();
		inqVO.setI_category("그 외");
		inqVO.setI_reply(1);
		List<InqVO> list = adminInqDao.inqCateList(inqVO);
		for(InqVO vo : list)
			log.info(vo.toString());
	} */
	
	/* @Test
	public void testInqDelete() {
		log.info("inqDelete() 메서드 실행");
		int result = adminInqDao.inqDelete(120);
		log.info(String.valueOf(result));
	} */
	
	/* @Test
	public void testInqDetail() {
		log.info("inqDetail() 메서드 실행");
		InqVO inqVO = inqDao.inqDetail(1);
		log.info(inqVO.toString());
	} */
	
	/* @Test
	public void testInqReplyUpdate() {
		log.info("inqReplyUpdate() 메서드 실행");
		InqReplyVO inqReplyVO = new InqReplyVO();
		inqReplyVO.setPay_num(1);
		inqReplyVO.setI_r_content("홈버튼을 누르지 마세요");
		int result = adminInqDao.inqReplyUpdate(inqReplyVO);
		log.info(String.valueOf(result));
	} */
	
	
}
