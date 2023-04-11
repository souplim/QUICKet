package com.spring.client.mypage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.client.mypage.dao.MypageDao;
import com.spring.client.mypage.vo.MypageVO;

@Service
public class MypageServiceImpl implements MypageService {

	private final MypageDao mypageDao;
	
	@Autowired
	public MypageServiceImpl(MypageDao mypageDao) {
		this.mypageDao = mypageDao;
	} 
	
	// 예매내역 조회
	@Override
	public List<MypageVO> myTicketList(MypageVO mypageVO) {
		List<MypageVO> list = null;
		list = mypageDao.myTicketList(mypageVO);
		return list;
	}

	// 예매내역 개수
	@Override
	public Integer ticketListCnt(MypageVO mypageVO) {
		return mypageDao.ticketListCnt(mypageVO);
	}

	// 예매내역 상세정보
	@Override
	public MypageVO myTicketDetail(MypageVO mypageVO) {
		MypageVO mypageVO2 = mypageDao.myTicketDetail(mypageVO);
		return mypageVO2;
	}

	// 예매내역 취소
	@Override
	public Integer myTicketDelete(int pay_num) {
		int result = mypageDao.myTicketDelete(pay_num);
		return result;
	}

	
	/* 관심공연 등록 */
	@Override
	public int likes(MypageVO mypageVO, String likes) {
		
		int result = 0;
		
		if(likes.equals("on"))
			result = mypageDao.addlikes(mypageVO);
		else
			result = mypageDao.cancelLikes(mypageVO);
		
		return result;
	}
	
	// 등록폼에서 조회할 회원의 예매번호, 공연이름
	@Override
	public List<MypageVO> ticketList(String u_id) {
		List<MypageVO> list = null;
		list = mypageDao.ticketList(u_id);
		return list;
	}

	// 좌석번호 리스트 조회
	@Override
	public List<Integer> mySeatList(int pay_num) {
		List<Integer> list = mypageDao.mySeatList(pay_num);
		return list;
	}
	
	// 좌석 연령 리스트 조회
	@Override
	public List<MypageVO> seatAgeList(int pay_num) {
		List<MypageVO> list = mypageDao.seatAgeList(pay_num);
		return list;
	}

	// 관심공연 리스트 조회
	@Override
	public List<MypageVO> myLikeList(MypageVO mypageVO) {
		List<MypageVO> list = mypageDao.myLikeList(mypageVO);
		return list;
	}

	// 상세페이지의 관심공연 등록 여부 조회
	@Override
	public MypageVO myShowLike(MypageVO mypageVO) {
		MypageVO vo = mypageDao.myShowLike(mypageVO);
		return vo;
	}
	
	// 공연 상세페이지 공연의 관심 수 조회
	@Override
	public int likesCount(int s_num) {
		int likesCount = mypageDao.likesCount(s_num);
		return likesCount;
	}

	// 페이징 처리 위한 나의 관심공연 수 
	@Override
	public int myLikesListCnt(MypageVO mypageVO) {
		int myLikesListCnt = mypageDao.myLikesListCnt(mypageVO);
		return myLikesListCnt;
	}

	// qna 리스트 조회
	@Override
	public List<MypageVO> qnaList(MypageVO mypageVO) {
		List<MypageVO> list = mypageDao.qnaList(mypageVO);
		return list;
	}

	// qna 리스트 개수 
	@Override
	public int qnaListCnt(MypageVO mypageVO) {
		int qnaListCnt = mypageDao.qnaListCnt(mypageVO);
		return qnaListCnt;
	}

	// 관람후기 리스트 조회
	@Override
	public List<MypageVO> reviewList(MypageVO mypageVO) {
		List<MypageVO> list = mypageDao.reviewList(mypageVO);
		return list;
	}

	// 관람후기 글 개수
	@Override
	public int reviewListCnt(MypageVO mypageVO) {
		int reviewListCnt = mypageDao.reviewListCnt(mypageVO);
		return reviewListCnt;
	}

	//문의글 등록 폼에서 조회할 faq 리스트
	@Override
	public List<MypageVO> faqList(String f_category) {
		List<MypageVO> list = mypageDao.faqList(f_category);
		return list;
	}

	// 발급쿠폰 리스트 조회
	@Override
	public List<MypageVO> couponList(MypageVO mypageVO) {
		List<MypageVO> list = mypageDao.couponList(mypageVO);
		return list;
	}

	// 발급쿠폰 개수
	@Override
	public int couponListCnt(MypageVO mypageVO) {
		int couponListCnt = mypageDao.couponListCnt(mypageVO);
		return couponListCnt;
	}

	// 사용완료 쿠폰 리스트 조회
	@Override
	public List<MypageVO> couponListN(MypageVO mypageVO) {
		List<MypageVO> list = mypageDao.couponListN(mypageVO);
		return list;
	}

	// 사용완료 쿠폰 개수
	@Override
	public int couponListCntN(MypageVO mypageVO) {
		int couponListCntN = mypageDao.couponListCntN(mypageVO);
		return couponListCntN;
	}

}
