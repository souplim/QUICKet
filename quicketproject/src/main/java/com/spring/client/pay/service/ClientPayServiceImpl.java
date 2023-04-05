package com.spring.client.pay.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.client.pay.dao.PayClientDao;
import com.spring.client.pay.vo.PayVO;
import com.spring.client.paypage.vo.CouponVO;
import com.spring.client.paypage.vo.PayPageVO;
import com.spring.client.paypage.vo.SeatVO;

import lombok.Setter;

@Service
public class ClientPayServiceImpl implements ClientPayService {

	@Setter(onMethod_ = @Autowired)
	private PayClientDao payClientDao;
	
	
	@Override
	public int payInsert(PayVO pvo) {
		int result = 0;
		result = payClientDao.payInsert(pvo);
		return result;
	}	
	
	
  @Override
  public int paySelectPay_num() {
	  int pay_num = payClientDao.paySelectPay_num();
	  return pay_num;
  }


	@Override
	public PayVO payInfo(int pay_num) {
		PayVO payInfo = null;
		payInfo = payClientDao.payInfo(pay_num);
		return payInfo;
	}


	@Override
	public int payDelete(int pay_num) {
		int result = 0;
		result = payClientDao.payDelete(pay_num);
		return result;
	}
	
	@Override
	public int payStatusUpdate(int pay_num) {
		int result = 0;
		result = payClientDao.payStatusUpdate(pay_num);
		return result;
	}


	@Override
	public int seatStatusUpdate(List<SeatVO> sv) {
		int result = 0;
		result = payClientDao.seatStatusUpdate(sv);
		return result;
	}


	@Override
	public int couponStatusUpdate(CouponVO cvo) {
		int result = 0;
		result = payClientDao.couponStatusUpdate(cvo);
		return result;
	}


	@Override
	public int ticketInsert(PayVO pvo) {
		int result = 0;
		result = payClientDao.ticketInsert(pvo);
		return result;
	}


	@Override
	public int ticketSeatInsert(List<SeatVO> sv) {
		int result = 0;
		result = payClientDao.ticketSeatInsert(sv);
		return result;
	}
	 
}
