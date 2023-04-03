package com.spring.client.coupon.vo;

import lombok.Data;

@Data
public class UserCouponVO {
	private String u_id;
	private String c_num;
	private String uc_date;
	private int uc_state = 0;
}
