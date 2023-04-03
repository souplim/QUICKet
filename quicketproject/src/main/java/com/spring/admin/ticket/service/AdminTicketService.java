package com.spring.admin.ticket.service;

import java.util.List;

import com.spring.admin.ticket.vo.HallVO;

public interface AdminTicketService {
	public List<HallVO> hall_list();

	public List<HallVO> hall_list(HallVO hvo); /* 검색 포함 리스트 */
//	public int hall_listCnt(HallVO hvo);
	public List<HallVO> updateForm(HallVO hvo);
	public HallVO updateForm2(HallVO hvo);
	public int hallUpdate(HallVO hvo);
}
