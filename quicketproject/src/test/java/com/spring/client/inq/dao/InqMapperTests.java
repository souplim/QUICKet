package com.spring.client.inq.dao;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.spring.client.inq.vo.InqVO;
import com.spring.client.mypage.vo.MypageVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@SpringBootTest
@Slf4j
public class InqMapperTests {

	@Setter(onMethod_=@Autowired)
	private InqDao inqDao;

	/* @Test
	public void testInqList() {
		log.info("inqList() 메서드 실행");
		InqVO inqVO = new InqVO();
		inqVO.setU_id("yubin");
		List<InqVO> list = inqDao.inqList(inqVO);
		for(InqVO vo : list)
			log.info(vo.toString());
	} */
	
 	/* @Test
	public void testInqDetail() {
		log.info("inqDetail() 메서드 실행");
		
		InqVO inqVO = inqDao.inqDetail(1);
		log.info(inqVO.toString());
	} */
	
	/* @Test
	public void testInqUpdate() {
		log.info("inqUpdate() 메서드 실행");
		InqVO inqVO = inqDao.inqDetail(1);
		inqVO.setI_title("로그인 안됨");
		inqVO.setI_content("로그인안돼요");
		int result = inqDao.inqUpdate(inqVO);
		log.info(String.valueOf(result));
	} */

	/*@Test
	 public void testInqInsert() {
		log.info("inqInsert() 메서드 실행");
		InqVO inqVO = inqDao.inqDetail(1);
		inqVO.setU_id("yubin");
		inqVO.setI_category("회원정보");
		inqVO.setI_cate_detail("로그인");
		inqVO.setI_title("예매오류");
		inqVO.setI_content("예매오류");
		int result = inqDao.inqInsert(inqVO);
		log.info(String.valueOf(result));
	} */
	
	/* @Test
	public void testInqListCnt() {
		log.info("inqListCnt() 메서드 실행");
		InqVO inqVO = new InqVO();
		inqVO.setU_id("yubin");
		int result = inqDao.inqListCnt(inqVO);
		log.info(String.valueOf(result));
	} */
	
	
	
}
