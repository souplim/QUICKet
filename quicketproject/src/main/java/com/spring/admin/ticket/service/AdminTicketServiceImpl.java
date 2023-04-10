package com.spring.admin.ticket.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.admin.ticket.dao.HallDao;
import com.spring.admin.ticket.vo.HallVO;
import com.spring.client.pay.vo.PayVO;
import com.spring.client.paypage.vo.SeatVO;
import com.spring.common.file.FileUploadUtil;

import lombok.Setter;

@Service
public class AdminTicketServiceImpl implements AdminTicketService {

	@Setter(onMethod_ = @Autowired)
	private HallDao hallDao;
	
	
	@Override
	public List<HallVO> hall_list() {
		// 글목록 구현
		List<HallVO> list = null;
		list = hallDao.hall_list();
		return list;
		
	}
	@Override
	public List<HallVO> hall_list(HallVO hvo) {
		// 글목록 구현
		List<HallVO> list = null;
		list = hallDao.hall_list(hvo);
		return list;
		
	}
	
	/*
	 * //전체 레코드 수 구현
	 * 
	 * @Override public int hall_listCnt(HallVO bvo) { return
	 * hallDao.hall_listCnt(bvo); }
	 */

	@Override
	public List<HallVO> updateForm(HallVO hvo) {
		List<HallVO> updateData = null;
		updateData = hallDao.hallDetail(hvo);
		return updateData;
	}
	@Override
	public HallVO updateForm2(HallVO hvo) {
		HallVO updateData = null;
		updateData = hallDao.hallDetail2(hvo);
		return updateData;
	}
	@Override
	public List<SeatVO> seat_updateForm(HallVO hvo) {
		List<SeatVO> seat_updateForm = null;
		seat_updateForm = hallDao.seat_updateForm(hvo);
		return seat_updateForm;
	}
	@Override
	public SeatVO seat_updateForm2(SeatVO svo) {
		SeatVO seat_updateForm2 = null;
		seat_updateForm2 = hallDao.seat_updateForm2(svo);
		return seat_updateForm2;
	}
	@Override
	public int hallUpdate(HallVO hvo){
		int result = 0;
		result = hallDao.hallUpdate(hvo);
		return result;
	}
	@Override
	public int hall_delete(HallVO hvo) {
		int result = 0;
		result = hallDao.hall_delete(hvo);
		return result;
	}
	@Override
	public int seat_delete(SeatVO svo) {
		int result = 0;
		result = hallDao.seat_delete(svo);
		return result;
	}
	@Override
	public int hall_write(HallVO hvo) {
		int result = 0;
		result = hallDao.hall_write(hvo);
		return result;
	}
	@Override
	public int seat_write(SeatVO svo) {
		int result = 0;
		result = hallDao.seat_write(svo);
		return result;
	}
	@Override
	public int seatUpdate(SeatVO svo) {
		int result = 0;
		result = hallDao.seatUpdate(svo);
		return result;
	}
	
	@Override
	public List<PayVO> payCancelPage() {
		List<PayVO> updateData = null;
		updateData = hallDao.payCancelPage();
		return updateData;
	}
	@Override
	public PayVO payToken(int pay_num) {
		PayVO payToken = null;
		payToken = hallDao.payToken(pay_num);
		return payToken;
		
	}
	@Override
	public int payStatus(int pay_num) {
		int result = 0;
		result = hallDao.payStatus(pay_num);
		return result;
	}
	@Override
	public int ticketStatus(int pay_num) {
		int result = 0;
		result = hallDao.ticketStatus(pay_num);
		return result;
	}
	
	
}
