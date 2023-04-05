package com.spring.client.pay.service;

import java.util.List;

import com.spring.client.pay.vo.PayVO;
import com.spring.client.paypage.vo.CouponVO;
import com.spring.client.paypage.vo.SeatVO;


public interface ClientPayService {
	public int payInsert(PayVO pvo);
	public int paySelectPay_num(); 
	public PayVO payInfo(int pay_num); 
	public int payDelete(int pay_num); 
	public int payStatusUpdate(int pay_num); 
	public int seatStatusUpdate(List<SeatVO> sv);
	public int couponStatusUpdate(CouponVO cvo);
	public int ticketInsert(PayVO pvo);
	public int ticketSeatInsert(List<SeatVO> sv);
}
