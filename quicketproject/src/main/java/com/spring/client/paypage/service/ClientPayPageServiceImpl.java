package com.spring.client.paypage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.admin.ticket.vo.HallVO;
import com.spring.client.paypage.dao.PayPageClientDao;
import com.spring.client.paypage.vo.CouponVO;
import com.spring.client.paypage.vo.PayPageVO;
import com.spring.client.paypage.vo.UserVO;

import lombok.Setter;

@Service
public class ClientPayPageServiceImpl implements ClientPayPageService {

	@Setter(onMethod_ = @Autowired)
	private PayPageClientDao payPageClientDao;
	
	
	@Override
	public PayPageVO hall_th_num(PayPageVO pvo) {
		PayPageVO hall_thNum = null;
		hall_thNum = payPageClientDao.hall_th_num(pvo);
		return hall_thNum;
	}
	
	@Override
	public List<PayPageVO> hall_list(int th_num) {
		List<PayPageVO> list = null;
		list = payPageClientDao.hall_list(th_num);
		return list;
		
	}

	@Override
	public PayPageVO pay_step2_list(PayPageVO pvo) {
		PayPageVO pay_step2_list = null;
		pay_step2_list = payPageClientDao.pay_step2_list(pvo);
		return pay_step2_list;
	}

	@Override
	public List<PayPageVO> pay_step2_seat(PayPageVO pvo) {
		List<PayPageVO> pay_step2_seat = null;
		pay_step2_seat = payPageClientDao.pay_step2_seat(pvo);
		return pay_step2_seat;
	}
	
	@Override
	public PayPageVO pay_step3_list(PayPageVO pvo) {
		PayPageVO pay_step3_list = null;
		pay_step3_list = payPageClientDao.pay_step3_list(pvo);
		return pay_step3_list;
	}

	@Override
	public List<CouponVO> pay_step3_coupon(String u_id) {
		List<CouponVO> pay_step3_coupon = null;
		pay_step3_coupon = payPageClientDao.pay_step3_coupon(u_id);
		return pay_step3_coupon;
	}
	
	@Override
	public PayPageVO pay_step4_list(PayPageVO pvo) {
		PayPageVO pay_step4_list = null;
		pay_step4_list = payPageClientDao.pay_step4_list(pvo);
		return pay_step4_list;
	}
	
	@Override
	public UserVO pay_step4_UserData(UserVO uvo) {
		UserVO pay_step4_UserData = null;
		pay_step4_UserData = payPageClientDao.pay_step4_UserData(uvo);
		return pay_step4_UserData;
	}
	
}
