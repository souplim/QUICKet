package com.spring.client.mypage.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.mypage.vo.MypageVO;


@Mapper
public interface MypageDao {

	List<MypageVO> myTicketList(MypageVO mypageVO); /* 예매내역 조회 */
	Integer ticketListCnt(MypageVO mypageVO); /* 예매내역 개수 */
	MypageVO myTicketDetail(MypageVO mypageVO); /* 예매내역 상세정보 조회 */
	Integer myTicketDelete(Integer ti_num); /* 예매내역 취소 */
	
	int addlikes(MypageVO mypageVO); /* 관심공연 등록 */
	int cancelLikes(MypageVO mypageVO); /* 관심공연 취소 */
	
	public List<MypageVO> ticketList(String u_id); /* 등록 폼에서 조회할 회원 예매번호, 공연이름 */
	
	List<Integer> mySeatList(int ti_num); /* 좌석번호 리스트 조회 */
	
	List<MypageVO> myLikeList(MypageVO mypageVO); /* 관심공연 리스트 조회 */
	
	int likesCount(int s_num); /* 상세페이지 - 공연의 관심수 조회 */
	int myLikesListCnt(MypageVO mypageVO); /* 페이징 위한 나의 관심공연 수 */
	
	List<MypageVO> qnaList(MypageVO mypageVO); /* qna 리스트 조회 */
	int qnaListCnt(MypageVO mypageVO); /* 페이징 처리 위한 qna 글 개수 */
}
