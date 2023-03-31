package com.spring.admin.coupon.vo;

import com.spring.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class AdminCouponVO extends CommonVO{
	
	private String c_num;
	private String c_name;
	private int c_discount;
	private String c_startdate;
	private String c_enddate;
	private String c_img;
	private String c_regdate;
	private String c_update;

}
