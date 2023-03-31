package com.spring.admin.coupon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.admin.coupon.dao.AdminCouponDao;
import com.spring.admin.coupon.vo.AdminCouponVO;

import lombok.Setter;

@Service
public class AdminCouponServiceImpl implements AdminCouponService {

	@Setter(onMethod_ = @Autowired)
	private AdminCouponDao adminCouponDao;
	
	@Override
	public List<AdminCouponVO> couponList(AdminCouponVO vo) {
		List<AdminCouponVO> list = null;
		list = adminCouponDao.couponList(vo);
		return list;
	}

}
