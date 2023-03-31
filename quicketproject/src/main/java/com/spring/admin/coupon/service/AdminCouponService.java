package com.spring.admin.coupon.service;

import java.util.List;

import com.spring.admin.coupon.vo.AdminCouponVO;

public interface AdminCouponService {
	public List<AdminCouponVO> couponList(AdminCouponVO vo);
	public int couponListCnt(AdminCouponVO vo);
}
