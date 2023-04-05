package com.spring.client.paypage.vo;



import lombok.Data;

@Data
public class ticketSuccessVO {
	private int pay_num;			// 예매번호
	private String s_name;			// 공연이름
	private String th_name;			// 공연장이름
	private String hall_place;			// 공연관
	private String hall_turn;		// 공연회차
	private String hall_date;		// 공연날짜
	private String hall_time;		// 공연시간
	private String pay_name;		// 사용자 이름
	private int s_price;			// 공연가격
	private String ti_date;			// 예약날짜
	private String s_opendate;		// 공연시작날짜
	private String s_closedate;		// 공연종료날짜
	
}

