package com.spring.admin.ticket.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.admin.ticket.dao.HallDao;
import com.spring.admin.ticket.vo.HallVO;
import com.spring.client.pay.vo.PayVO;
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
	public int hallUpdate(HallVO hvo){
		int result = 0;
		result = hallDao.hallUpdate(hvo);
		return result;
	}
	
	@Override
	public List<PayVO> payCancelPage() {
		List<PayVO> updateData = null;
		updateData = hallDao.payCancelPage();
		return updateData;
	}
	
}
