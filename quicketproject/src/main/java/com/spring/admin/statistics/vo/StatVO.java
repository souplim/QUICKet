package com.spring.admin.statistics.vo;

import lombok.Data;

@Data
public class StatVO {
	private int s_num=0;
	private String s_name="";
	private int s_price=0;
	private int s_ticketcnt=0; // 공연별 예매횟수
	private int s_ticketcntRatio=0; // 공연별 예매 비율
	
	private int th_num=0;
	
	private String u_id="";
//	private String u_gender="";
	
	private int ti_num=0;
	private String ti_regidate; // 예매일
	private int ti_status=0; // 예매상태
//	private String stat_year; // 예매연도
	private int s_sales=0; // 공연별 매출액
	private int s_salesRatio=0; // 공연 매출액 비율
	
	private String stat_date=""; // 월
	private double stat_sales=0;
	
	private String s1="";
	private String s2="";
	private String s3="";
}
