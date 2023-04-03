package com.spring.client.pay.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.client.pay.service.ClientPayService;
import com.spring.client.pay.vo.PayVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/client/pay/*")
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
		
		return (result==1) ? "SUCCESS" : "FAILURE";

	}
	
	/*
	 * @PostMapping(value = "/ticketSeatInsert", consumes = "application/json",
	 * produces = MediaType.TEXT_PLAIN_VALUE) public String
	 * ticketSeatInsert(@RequestBody PayVO pvo){ log.info("ticketSeatInsert 호출 성공");
	 * 
	 * int result =0; result = clientPayService.payInsert(pvo);
	 * 
	 * return (result==1) ? "SUCCESS" : "FAILURE";
	 * 
	 * }
	 */
	
	
}
