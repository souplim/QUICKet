package com.spring.admin.ticket.controller;

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

import com.spring.admin.ticket.service.AdminTicketService;
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
@RequestMapping("/admin/payJson2/*")
//@Log4j
@Slf4j
public class AdminTicketController_JSON {
	
	@Setter(onMethod_ = @Autowired)
	private AdminTicketService adminTicketService;	
	// 공연 상세 페이지 - 예매하기 객체 JSON I/O
		@GetMapping(value = "/payToken/{pay_num}", produces =MediaType.APPLICATION_JSON_VALUE)
		public PayVO payInfo(@PathVariable("pay_num") Integer pay_num){
			log.info("payInfo 호출 성공");
			
			PayVO pvo = null;
			pvo = adminTicketService.payToken(pay_num);
			return pvo;
		}
		
		@PostMapping(value = "/payStatus", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
		public String payStatus(@RequestBody String pay_num){
			log.info("payStatus 호출 성공");
			int result = 0;
			result = adminTicketService.payStatus(Integer.parseInt(pay_num));
			return (result==1) ? "SUCCESS" : "FAILURE";
		}

		@PostMapping(value = "/ticketStatus", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
		public String ticketStatus(@RequestBody String pay_num){
			log.info("ticketStatus 호출 성공");
			int result = 0;
			result = adminTicketService.ticketStatus(Integer.parseInt(pay_num));
			return (result==1) ? "SUCCESS" : "FAILURE";
		}

	
}
