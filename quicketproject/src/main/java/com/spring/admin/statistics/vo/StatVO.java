package com.spring.admin.statistics.vo;

import lombok.Data;

@Data
public class StatVO {
//	private int s_num=0;
	private String s_name="";
	private int s_price=0;
	private int s_ticketcnt=0; // 공연별 예매횟수
//	private int th_num=0;
//	private String u_id="";
//	private String u_gender="";
//	private int ti_num=0;
	
	private double s_sales=0; // 공연별 매출액
	
	private String stat_date="";
	private double stat_sales=0;
	
}
