package com.spring.admin.ticket.service;

import java.util.List;

import com.spring.admin.ticket.vo.HallVO;
import com.spring.client.pay.vo.PayVO;
import com.spring.client.paypage.vo.SeatVO;

public interface AdminTicketService {
	public List<HallVO> hall_list();
	public List<PayVO> payCancelPage();

	public List<HallVO> hall_list(HallVO hvo); /* 검색 포함 리스트 */
	public int hall_listCnt(HallVO hvo);
	public List<HallVO> updateForm(HallVO hvo);
	public HallVO updateForm2(HallVO hvo);
	public List<SeatVO> seat_updateForm(HallVO hvo);
	public SeatVO seat_updateForm2(SeatVO svo);
	public int hallUpdate(HallVO hvo);
	public int hall_delete(HallVO hvo);
	public int seat_delete(SeatVO svo);
	public int hall_write(HallVO hvo);
	public int seat_write(SeatVO svo);
	public int seatUpdate(SeatVO svo);
	
	public PayVO payToken(int pay_num);
	public int payStatus(int pay_num);
	public int ticketStatus(int pay_num);
}
