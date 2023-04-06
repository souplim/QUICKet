package com.spring.client.pay.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.pay.vo.PayVO;
import com.spring.client.paypage.vo.CouponVO;
import com.spring.client.paypage.vo.SeatVO;

@Mapper
public interface PayClientDao {
	public int payInsert(PayVO pvo);
	public int paySelectPay_num(); 
	public PayVO payInfo(int pay_num); 
	public int payDelete(int pay_num); 
	public int payStatusUpdate(PayVO pvo); 
	public int seatStatusUpdate(List<SeatVO> sv); 
	public int couponStatusUpdate(CouponVO cvo);
	public int ticketInsert(PayVO pvo);
	public int ticketSeatInsert(List<SeatVO> sv);
}
