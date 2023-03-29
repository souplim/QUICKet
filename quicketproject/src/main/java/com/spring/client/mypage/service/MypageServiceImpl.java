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
	public Integer myTicketDelete(Integer ti_num) {
		int result = mypageDao.myTicketDelete(ti_num);
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
	public List<Integer> mySeatList(int ti_num) {
		List<Integer> list = mypageDao.mySeatList(ti_num);
		return list;
	}

	// 관심공연 리스트 조회
	@Override
	public List<MypageVO> myLikeList(MypageVO mypageVO) {
		List<MypageVO> list = mypageDao.myLikeList(mypageVO);
		return list;
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

	
	
}
