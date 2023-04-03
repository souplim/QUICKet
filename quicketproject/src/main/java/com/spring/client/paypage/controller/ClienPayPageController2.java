package com.spring.client.paypage.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.admin.ticket.vo.HallVO;
import com.spring.client.paypage.service.ClientPayPageService;
import com.spring.client.paypage.vo.PayPageVO;
import com.spring.common.vo.PageDTO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/client/payPage/*")
//@Log4j
@Slf4j
public class ClienPayPageController2 {
	
	@Setter(onMethod_ = @Autowired)
	private ClientPayPageService clientPayPageService;
	
	
	// 공연 상세 페이지 - 예매하기 객체 JSON I/O
	@GetMapping(value = "/all/{th_num}", produces =MediaType.APPLICATION_JSON_VALUE)
	public List<PayPageVO> replyList(@PathVariable("th_num") Integer th_num){
		log.info("list 호출 성공");
		
		List<PayPageVO> entity = null;
		entity = clientPayPageService.hall_list(th_num);
		return entity;
	}
	
	
}
