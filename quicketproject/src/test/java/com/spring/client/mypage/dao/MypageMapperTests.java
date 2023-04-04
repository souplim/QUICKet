package com.spring.client.mypage.dao;

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
public class MypageMapperTests {
	
	@Setter(onMethod_=@Autowired)
	private MypageDao mypageDao;
	
	@Test
	public void testMyTicketList() {
		log.info("myTicketList() 메서드 실행");
		MypageVO mypageVO = new MypageVO();
		mypageVO.setU_id("user02");
//		mypageVO.setSearch("hall_date");
		mypageVO.setSearch("ti_regdate");
		mypageVO.setStart_date("2023-03-01");
		mypageVO.setEnd_date("2023-05-30");
		List<MypageVO> list = mypageDao.myTicketList(mypageVO);
		for(MypageVO vo : list)
			log.info(vo.toString());
	}
	
	/* @Test
	public void testTicketListCnt() {
		log.info("ticketListCnt() 메서드 실행");
		MypageVO mypageVO = new MypageVO();
		mypageVO.setU_id("userid");
		int count = mypageDao.ticketListCnt(mypageVO);
		log.info(String.valueOf(count));
	} */
	
	/* @Test
	public void testMyTicketDetail() {
		log.info("myTicketDetail() 메서드 실행");
		MypageVO mypageVO = new MypageVO();
		mypageVO.setU_id("user02");
		mypageVO.setTi_num(2);
		mypageVO.setS_num(1);
		MypageVO mypageVO2 = mypageDao.myTicketDetail(mypageVO);
		log.info(mypageVO2.toString());
	} */
	
	/* @Test
	public void testMySeatList() {
		log.info("mySeatList() 메서드 실행");
		List<Integer> list = mypageDao.mySeatList(3);
		for(Integer vo : list)
			log.info(vo.toString());
	} */
	
	/* @Test
	public void testFaqList() {
		log.info("faqList() 메서드 실행");
		List<MypageVO> list = mypageDao.faqList("공연");
		for(MypageVO vo : list)
			log.info(vo.toString());
	} */
	
	/* @Test
	public void testMyTicketDelete() {
		log.info("myTicketDeletele() 메서드 실행");
		
		int result = mypageDao.myTicketDelete(3);
		log.info(String.valueOf(result));
	} */ 
	
	/* @Test
	public void testAddlikes() {
		log.info("addlikes() 메서드 실행");
		
		MypageVO mypageVO = new MypageVO();
		mypageVO.setU_id("user02");
		mypageVO.setS_num(2);
		int result = mypageDao.addlikes(mypageVO);
		log.info(String.valueOf(result));
	} */
	
	/* @Test
	public void testCancelLikes() {
		log.info("cancelLikes() 메서드 실행");
		
		MypageVO mypageVO = new MypageVO();
		mypageVO.setU_id("user02");
		mypageVO.setS_num(2);
		int result = mypageDao.cancelLikes(mypageVO);
		log.info(String.valueOf(result));
	} */
	
	/* @Test
	public void testTicketList(){
		log.info("ticketList() 메서드 실행");
		List<MypageVO> list = mypageDao.ticketList("user02");
		for(MypageVO vo : list)
			log.info(vo.toString());
	} */
	
	/* @Test
	public void testMyLikeList() {
		log.info("myLikeList() 메서드 실행");
		MypageVO mypageVO = new MypageVO();
		mypageVO.setU_id("user02");
		List<MypageVO> list = mypageDao.myLikeList(mypageVO);
		for(MypageVO vo : list)
			log.info(vo.toString());
	} */
	
	/* @Test
	public void testLikesCount() {
		log.info("likesCount() 메서드 실행");
		int count = mypageDao.likesCount(1);
		log.info(String.valueOf(count));
	} */
	
	/* @Test
	public void testMyLikesListCnt() {
		log.info("myLikesListCnt() 메서드 실행");
		MypageVO mypageVO = new MypageVO();
		mypageVO.setU_id("user02");
		int count = mypageDao.myLikesListCnt(mypageVO);
		log.info(String.valueOf(count));
	} */
	
	/* @Test
	public void testQnaList() {
		log.info("qnaList() 메서드 실행");
		MypageVO mypageVO = new MypageVO();
		mypageVO.setU_id("user02");
		List<MypageVO> list = mypageDao.qnaList(mypageVO);
		for(MypageVO vo : list)
			log.info(vo.toString());
	} */
	
	/* @Test
	public void testQnaListCnt() {
		log.info("qnaListCnt() 메서드 실행");
		MypageVO mypageVO = new MypageVO();
		mypageVO.setU_id("user02");
		int count = mypageDao.qnaListCnt(mypageVO);
		log.info(String.valueOf(count));
	} */
	
	/* @Test
	public void testReviewList() {
		log.info("reviewList() 메서드 실행");
		MypageVO mypageVO = new MypageVO();
		mypageVO.setU_id("user02");
		List<MypageVO> list = mypageDao.reviewList(mypageVO);
		for(MypageVO vo : list)
			log.info(vo.toString());
	} */
	
	/* @Test
	public void testReviewListCnt() {
		log.info("reviewListCnt() 메서드 실행");
		MypageVO mypageVO = new MypageVO();
		mypageVO.setU_id("user02");
		int count = mypageDao.reviewListCnt(mypageVO);
		log.info(String.valueOf(count));
	} */
	
	/* @Test
	public void testCouponList() {
		log.info("couponList() 메서드 실행");
		MypageVO mypageVO = new MypageVO();
		mypageVO.setU_id("user02");
		List<MypageVO> list = mypageDao.couponList(mypageVO);
		for(MypageVO vo : list)
			log.info(vo.toString());
	} */
	
	/* @Test
	public void testCouponListN() {
		log.info("couponListN() 메서드 실행");
		MypageVO mypageVO = new MypageVO();
		mypageVO.setU_id("user02");
		List<MypageVO> list = mypageDao.couponListN(mypageVO);
		for(MypageVO vo : list)
			log.info(vo.toString());
	} */
}
