package com.spring.admin.statistics.vo;

import lombok.Data;

@Data
public class StatVO {
	private int s_num=0;
	private String s_name="";
	private int s_price=0;
	private int s_ticketcnt=0; // 공연별 예매횟수
	
	private int th_num=0;
	
	private String u_id="";
//	private String u_gender="";
	
	private int ti_num=0;
	private String ti_regidate; // 예매일
	private int ti_status=0; // 예매상태
//	private String stat_year; // 예매연도
	private double s_sales=0; // 공연별 매출액
	
	private String stat_date="";
	private double stat_sales=0;
	
	private int 베토벤=0;
	private int 인터뷰=0;
}
