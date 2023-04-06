package com.spring.admin.ticket.vo;

import com.spring.client.paypage.vo.PayPageVO;

import com.spring.common.vo.CommonVO;

import lombok.Data;
@Data
public class HallVO extends CommonVO {
	private int    hall_id     	= 0;  	// 공연홀ID
	private String hall_place   = ""; 	// 공연관
	
	private String s_name = ""; 		// 공연명
	private int s_num = 0;				// 공연번호
	private String th_name = "";		// 공연장
	
	private String hall_turn   	= ""; 	// 상영회차
	private int    hall_seatNum = 0; 	// 좌석수
	private String hall_date 	= "";   // 예매날짜
	private String hall_start 	= "";   // 관람시작날짜
	private String hall_end  	= ""; 	// 관람종료날짜
	private String    hall_regdate;		// 등록일
	private String    hall_update;		// 수정일
	private int    th_num 		= 0;	// 공연장ID 외래키
	
	private String hall_time 	= "";   // 공연시
	
	private int date_gap = 0; 			// 일수 차이
	private int data_num = 0; 			// 데이터 개수
	
//	client
	private int remaining_seatNum = 0; 	// 남은 좌석 수
	
}