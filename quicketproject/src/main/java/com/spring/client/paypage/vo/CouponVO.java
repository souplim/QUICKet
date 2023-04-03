package com.spring.client.paypage.vo;



import lombok.Data;

@Data
public class CouponVO {
	private String c_num; 			// 쿠폰 번호
	private String c_name; 		// 쿠폰 이름
	private int c_discount;		// 할인율
	private String c_enddate;	// 유효기간 종료일
	private String u_id;		// 사용자 아이디
	
}

