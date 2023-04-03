package com.spring.client.coupon.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.coupon.vo.UserCouponVO;

@Mapper
public interface ClientCouponDao {
	public List<UserCouponVO> userCoupon(String u_id);
	public int getCoupon(UserCouponVO vo) throws Exception;
	public int couponChk(UserCouponVO vo) throws Exception;
}
