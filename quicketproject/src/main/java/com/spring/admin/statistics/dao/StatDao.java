package com.spring.admin.statistics.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.admin.statistics.vo.StatVO;

@Mapper
public interface StatDao {

	List<StatVO> showTicketCnt(); // 통계 조회하기
	
	List<StatVO> showSales(); // 공연별 매출비율 조회하기
	
	List<StatVO> showList(); // 공연명 리스트 조회
	
	List<StatVO> monthlySales(List<StatVO> nameList); // 주별 매출액 조회하기
}
