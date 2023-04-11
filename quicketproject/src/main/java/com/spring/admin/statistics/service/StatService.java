package com.spring.admin.statistics.service;

import java.util.List;

import com.spring.admin.statistics.vo.StatVO;

public interface StatService {

	List<StatVO> showTicketCnt();  // 공연별 예매비율 조회하기

	List<StatVO> showSales(); // 공연별 매출비율 조회하기

	List<StatVO> showTicketSales(); // 공연별 예매비율, 매출비율 조회하기
	
	
	List<StatVO> showList(); // 공연명 리스트 조회
	
	List<StatVO> monthlySales(List<StatVO> nameList); // 월별 매출액 조회하기

	List<StatVO> genderCnt(); // 예매자 성비 조회

	

}
