package com.spring.client.paypage.vo;



import lombok.Data;

@Data
public class AmountVO {
//	결제내역 리스트 편하게 보내려고 만든 VO
	private String ticketAmount;
	private String discountCoupon;
	private String discountChildren;
	private String discountAmount;
	private String totalAmount1;
	private String totalAmount2;
	
	
}

