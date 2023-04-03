package com.spring.client.ticket.service;

import java.util.List;

import com.spring.admin.ticket.vo.HallVO;

public interface ClientTicketService {
	public HallVO hall_th_num(HallVO hvo);

	public List<HallVO> hall_list(int th_num); 
}
