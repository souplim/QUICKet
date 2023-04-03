package com.spring.client.pay.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.client.pay.dao.PayClientDao;
import com.spring.client.pay.vo.PayVO;

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
	
	/*
	 * @Override public int paySelectPay_num() {
	 * 
	 * int pay_num = payClientDao.paySelectPay_num(); return pay_num; }
	 */
}
