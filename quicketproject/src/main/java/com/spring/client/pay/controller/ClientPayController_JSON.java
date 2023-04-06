package com.spring.client.pay.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.spring.client.pay.service.ClientPayService;
import com.spring.client.pay.vo.PayVO;
import com.spring.client.paypage.vo.CouponVO;
import com.spring.client.paypage.vo.PayPageVO;
import com.spring.client.paypage.vo.SeatVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;

@SessionAttributes("userLogin")
@RestController
@RequestMapping("/client/payJson/*")
//@Log4j
@Slf4j
public class ClientPayController_JSON {
	
	@Setter(onMethod_ = @Autowired)
	private ClientPayService clientPayService;
	
	
	@PostMapping(value = "/payInsert", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public String payInsert(@RequestBody PayVO pvo){
		log.info("payInsert 호출 성공");
		
		int result =0;
		result = clientPayService.payInsert(pvo);
		int pay_num = 0;
		if(result ==0) {
			return "payInsertFail";
		}else {
			pay_num = clientPayService.paySelectPay_num();
			String StringPay_num = Integer.toString(pay_num);
			
			return StringPay_num;
		}
	}
	
	
	// 공연 상세 페이지 - 예매하기 객체 JSON I/O
	@GetMapping(value = "/payInfo/{pay_num}", produces =MediaType.APPLICATION_JSON_VALUE)
	public PayVO payInfo(@PathVariable("pay_num") Integer pay_num){
		log.info("payInfo 호출 성공");
		
		PayVO pvo = null;
		pvo = clientPayService.payInfo(pay_num);
		return pvo;
	}
	 
	
	@PostMapping(value = "/payDelete", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public String payDelete(@RequestBody PayVO pvo){
		log.info("payInsert 호출 성공");
		
		int result = 0;
		
		result = clientPayService.payDelete(pvo.getPay_num());
		return (result==1) ? "SUCCESS" : "FAILURE";
	}
	
	@PostMapping(value = "/payStatusUpdate", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public String payStatusUpdate(@RequestBody PayVO pvo){
		log.info("payStatusUpdate 호출 성공");
		
		int result = 0;
		
		result = clientPayService.payStatusUpdate(pvo);
		return (result==1) ? "SUCCESS" : "FAILURE";
	}

	@PostMapping(value = "/seatStatusUpdate", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public String seatStatusUpdate(@RequestBody ArrayList<String> seatData){
		log.info("seatStatusUpdate 호출 성공");
		int result = 0;
		
		  PayPageVO pvo = new PayPageVO(); List<SeatVO> seatList = pvo.getSeatList();
		  int z = 0; 
		  for(int i = 0; i < seatData.size(); i++) { 
			  SeatVO svo = new SeatVO();
			  if(i ==0) { 
			  svo.setSeat_num(Integer.parseInt(seatData.get(z)));
			  svo.setSeat_age(seatData.get(z+1));
			  svo.setHall_id(Integer.parseInt(seatData.get(z+2))); seatList.add(svo);
			  z=z+3; 
		  }else if(i ==1) {
		  
		  }else if(i%3 ==0 && i!=0) {
			  svo.setSeat_num(Integer.parseInt(seatData.get(z)));
			  svo.setSeat_age(seatData.get(z+1));
			  svo.setHall_id(Integer.parseInt(seatData.get(z+2))); seatList.add(svo);
			  z=z+3; 
		  }
		  
		  
		  } 
		  log.info(seatList.toString()); 
		  result = clientPayService.seatStatusUpdate(seatList);
		  
		 
		 
		return (result != 0) ? "SUCCESS" : "FAILURE";
	}
	
	@PostMapping(value = "/couponStatusUpdate", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public String couponStatusUpdate(@RequestBody CouponVO cvo){
		log.info("couponStatusUpdate 호출 성공");
		
		int result = -2;
		
		result = clientPayService.couponStatusUpdate(cvo);
		if(result == 1) {
			return "SUCESS";
		}else if(result == 0) {
			return "NOCHOICE";
		}else {
			return "FAIL";
		}
	}
	
	@PostMapping(value = "/ticketInsert", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public String ticketInsert(@RequestBody PayVO pvo){
		log.info("ticketInsert 호출 성공");
		
		int result = 0;
		
		result = clientPayService.ticketInsert(pvo);
		return (result==1) ? "SUCCESS" : "FAILURE";
	}
	
	@PostMapping(value = "/ticketSeatInsert", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public String ticketSeatInsert(@RequestBody ArrayList<String> seatData){
		log.info("ticketSeatInsert 호출 성공");
		int result = 0;
		
		  PayPageVO pvo = new PayPageVO(); 
		  List<SeatVO> seatList = pvo.getSeatList();
		  int z = 0; 
		  for(int i = 0; i < seatData.size(); i++) { 
			  SeatVO svo = new SeatVO();
			  if(i ==0) { 
			  svo.setSeat_num(Integer.parseInt(seatData.get(z)));
			  svo.setHall_id(Integer.parseInt(seatData.get(z+1)));
			  svo.setPay_num(Integer.parseInt(seatData.get(z+2)));  
			  seatList.add(svo);
			  z=z+3; 
		  }else if(i ==1) {
		  
		  }else if(i%3 ==0 && i!=0) {
			  svo.setSeat_num(Integer.parseInt(seatData.get(z)));
			  svo.setHall_id(Integer.parseInt(seatData.get(z+1)));
			  svo.setPay_num(Integer.parseInt(seatData.get(z+2)));  
			  seatList.add(svo);
			  z=z+3; 
		  }
		  
		  } 
		  log.info(seatList.toString()); 
		  result = clientPayService.ticketSeatInsert(seatList);
		  
		 
		 
		return (result != 0) ? "SUCCESS" : "FAILURE";
	}

	
}
