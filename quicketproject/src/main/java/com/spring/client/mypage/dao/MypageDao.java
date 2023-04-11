package com.spring.client.mypage.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.mypage.vo.MypageVO;


@Mapper
public interface MypageDao {

	List<MypageVO> myTicketList(MypageVO mypageVO); /* 예매내역 조회 */
	Integer ticketListCnt(MypageVO mypageVO); /* 예매내역 개수 */
	MypageVO myTicketDetail(MypageVO mypageVO); /* 예매내역 상세정보 조회 */
	Integer myTicketDelete(int pay_num); /* 예매내역 취소 */
	
	int addlikes(MypageVO mypageVO); /* 관심공연 등록 */
	int cancelLikes(MypageVO mypageVO); /* 관심공연 취소 */
	
	public List<MypageVO> ticketList(String u_id); /* 등록 폼에서 조회할 회원 예매번호, 공연이름 */
	List<MypageVO> faqList(String f_category); /* 문의글 등록 폼에서 조회할 faq 리스트 */
	
	List<Integer> mySeatList(int pay_num); /* 좌석번호 리스트 조회 */
	List<MypageVO> seatAgeList(int pay_num); /* 좌석연령 리스트 조회 */
	
	List<MypageVO> myLikeList(MypageVO mypageVO); /* 관심공연 리스트 조회 */
	
	MypageVO myShowLike(MypageVO mypageVO); /* 상세페이지의 관심공연 등록 여부 조회 */
	int likesCount(int s_num); /* 상세페이지 - 공연의 관심수 조회 */
	int myLikesListCnt(MypageVO mypageVO); /* 페이징 위한 나의 관심공연 수 */
	
	List<MypageVO> qnaList(MypageVO mypageVO); /* qna 리스트 조회 */
	int qnaListCnt(MypageVO mypageVO); /* 페이징 처리 위한 qna 글 개수 */
	List<MypageVO> reviewList(MypageVO mypageVO); /* 관람후기 리스트 조회 */
	int reviewListCnt(MypageVO mypageVO); /* 관람후기 글 개수 */
	
	List<MypageVO> couponList(MypageVO mypageVO); /* 발급쿠폰 리스트 조회 */
	int couponListCnt(MypageVO mypageVO); /* 발급쿠폰 개수 */
	
	List<MypageVO> couponListN(MypageVO mypageVO); /* 사용완료 쿠폰 리스트 조회 */
	int couponListCntN(MypageVO mypageVO); /* 사용완료 쿠폰 개수 */
	
}
