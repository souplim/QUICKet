package com.spring.admin.ticket.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.admin.ticket.vo.HallVO;
import com.spring.client.pay.vo.PayVO;

@Mapper
public interface HallDao {

	public List<HallVO> hall_list();
	public List<PayVO> payCancelPage();
	public List<HallVO> hall_list(HallVO hvo); /* 검색 포함 리스트 */

	/* public int hall_listCnt(HallVO hvo); hall 테이블의 전체 레코드 수 */

	public int hallUpdate(HallVO hallVO);
	public List<HallVO> hallDetail(HallVO hallVO);
	public HallVO hallDetail2(HallVO hallVO);
	public PayVO payToken(int pay_num); 
	public int payStatus(int pay_num);
////	public int readCntUpdate(BoardVO bvo);
//	public void readCount(String num);
//	
//	
//	public int pwdConfirm(TicketVO boardVO);
//	public int boardUpdate(TicketVO bvo);
//	public int boardDelete(int b_num);
//	
//	public List<TicketVO> boardListExcel(TicketVO bvo);
}
