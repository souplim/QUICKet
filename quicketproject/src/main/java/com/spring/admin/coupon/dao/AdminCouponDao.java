package com.spring.admin.coupon.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.admin.coupon.vo.AdminCouponVO;

@Mapper
public interface AdminCouponDao {
	public List<AdminCouponVO> couponList(AdminCouponVO vo);
	public int couponListCnt(AdminCouponVO vo);
	public int insertCoupon(AdminCouponVO vo) throws Exception;
}
