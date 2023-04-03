package com.spring.client.pay.dao;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.pay.vo.PayVO;

@Mapper
public interface PayClientDao {
	public int payInsert(PayVO pvo);
	/* public int paySelectPay_num(); */
}
