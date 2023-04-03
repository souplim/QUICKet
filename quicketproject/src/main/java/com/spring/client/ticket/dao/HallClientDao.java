package com.spring.client.ticket.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.admin.ticket.vo.HallVO;

@Mapper
public interface HallClientDao {
	public HallVO hall_th_num(HallVO hvo);

	public List<HallVO> hall_list(int th_num); /* 검색 포함 리스트 */
}
