package com.spring.client.ticket.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.client.ticket.dao.HallClientDao;
import com.spring.admin.ticket.vo.HallVO;

import lombok.Setter;

@Service
public class ClientTicketServiceImpl implements ClientTicketService {

	@Setter(onMethod_ = @Autowired)
	private HallClientDao hallClientDao;
	
	
	@Override
	public HallVO hall_th_num(HallVO hvo) {
		HallVO hall_thNum = null;
		hall_thNum = hallClientDao.hall_th_num(hvo);
		return hall_thNum;
	}
	
	@Override
	public List<HallVO> hall_list(int th_num) {
		List<HallVO> list = null;
		list = hallClientDao.hall_list(th_num);
		return list;
		
	}
	
	
	
}
