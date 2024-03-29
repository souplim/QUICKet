package com.spring.admin.statistics.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.admin.statistics.dao.StatDao;
import com.spring.admin.statistics.vo.StatVO;

import lombok.Setter;

@Service
public class StatServiceImpl implements StatService {
	
	@Setter(onMethod_=@Autowired)
	private StatDao statDao;

	// 공연별 예매비율 조회하기
	@Override
	public List<StatVO> showTicketCnt() {
		List<StatVO> list = statDao.showTicketCnt();
		return list;
	}

	// 공연별 매출비율 조회하기
	@Override
	public List<StatVO> showSales() {
		List<StatVO> list = statDao.showSales();
		return list;
	}
	
	// 공연별 예매비율, 매출비율 조회하기
	@Override
	public List<StatVO> showTicketSales() {
		List<StatVO> list = statDao.showTicketSales();
		return list;
	}
	

	// 공연명 리스트 조회
	@Override
	public List<StatVO> showList() {
		List<StatVO> list = statDao.showList();
		return list;
	}
	
	// 월별 매출
	@Override
	public List<StatVO> monthlySales(List<StatVO> nameList) {
		List<StatVO> list = statDao.monthlySales(nameList);
		return list;
	}

	// 예매자 성비 조회
	@Override
	public List<StatVO> genderCnt() {
		List<StatVO> list = statDao.genderCnt();
		return list;
	}

	// 예매자 연령비 조회
	@Override
	public List<StatVO> ageGroupCnt() {
		List<StatVO> list = statDao.ageGroupCnt();
		return list;
	}
	
	// 회원 성비 조회
	@Override
	public List<StatVO> userGenderCnt() {
		List<StatVO> list = statDao.userGenderCnt();
		return list;
	}

	// 회원 연령비 조회
	@Override
	public List<StatVO> userAgeGroupCnt() {
		List<StatVO> list = statDao.userAgeGroupCnt();
		return list;
	}

	// 일반회원 탈퇴회원 비율
	@Override
	public List<StatVO> userMemberQuitCount() {
		List<StatVO> list = statDao.userMemberQuitCount();
		return list;
	}

}
