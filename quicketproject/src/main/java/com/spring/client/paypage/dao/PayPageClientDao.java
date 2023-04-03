package com.spring.client.paypage.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.paypage.vo.CouponVO;
import com.spring.client.paypage.vo.PayPageVO;
import com.spring.client.paypage.vo.UserVO;

@Mapper
public interface PayPageClientDao {
	public PayPageVO hall_th_num(PayPageVO pvo);

	public List<PayPageVO> hall_list(int th_num); /* 검색 포함 리스트 */
	
	public PayPageVO pay_step2_list(PayPageVO pvo);
	public List<PayPageVO> pay_step2_seat(PayPageVO pvo);
	
	public PayPageVO pay_step3_list(PayPageVO pvo);
	
	public List<CouponVO> pay_step3_coupon(String u_id);
	
	public PayPageVO pay_step4_list(PayPageVO pvo);
	
	public UserVO pay_step4_UserData(UserVO uvo);
}
