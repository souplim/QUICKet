package com.spring.client.coupon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.client.coupon.dao.ClientCouponDao;
import com.spring.client.coupon.vo.UserCouponVO;

import lombok.Setter;

@Service
public class ClientCouponServiceImpl implements ClientCouponService {
	
	
	@Setter(onMethod_ = @Autowired)
	private ClientCouponDao clientCouponDao;
	
	
	@Override
	public List<UserCouponVO> userCoupon(String u_id) {
		List<UserCouponVO> userCoupon = null;
		userCoupon = clientCouponDao.userCoupon(u_id);
		return userCoupon;
	}
	
	@Override
	public int getCoupon(UserCouponVO vo) throws Exception {
		int result = 0;
		
		result = clientCouponDao.getCoupon(vo);
		return result;
	}

	@Override
	public int couponChk(UserCouponVO vo) throws Exception {
		int result = 0;
		result = clientCouponDao.couponChk(vo);
		return result;
	}


	
}
