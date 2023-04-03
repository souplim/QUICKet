package com.spring.client.paypage.vo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.spring.admin.ticket.vo.HallVO;

//import lombok.Data;
import lombok.Getter;
import lombok.Setter;

//@Data
@Setter
@Getter
public class PayPageVO extends HallVO  {
	private String s_opendate 	= "";		// 공연 시작일
	private String s_closedate 	= "";		// 공연 종료일
	
	private int seat_num = 0; 	   //좌석번호
	private String seat_name = ""; //좌석명
	private int seat_status = 0 ;  //좌석상태
	private String seat_age = "";  //성인/아동
	private int s_price = 0; 	   //티켓가격
	private List<SeatVO> SeatList;
	
	public PayPageVO() {
		  SeatList = new ArrayList<>();
	  }
	
}