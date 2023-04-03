package com.spring.client.coupon.service;

import java.util.List;

import com.spring.client.coupon.vo.UserCouponVO;

public interface ClientCouponService {
	public List<UserCouponVO> userCoupon(String u_id);
	public int getCoupon(UserCouponVO vo) throws Exception;
	public int couponChk(UserCouponVO vo) throws Exception;
}
