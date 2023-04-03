package com.spring.client.ticket.controller;

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
import com.spring.client.ticket.service.ClientTicketService;
import com.spring.common.vo.PageDTO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/client/ticket/*")
//@Log4j
@Slf4j
public class ClientTicketController_JSON {
	
	@Setter(onMethod_ = @Autowired)
	private ClientTicketService clientTicketService;
	
	
	// 공연 상세 페이지 - 예매하기 객체 JSON I/O
	@GetMapping(value = "/all/{th_num}", produces =MediaType.APPLICATION_JSON_VALUE)
	public List<HallVO> replyList(@PathVariable("th_num") Integer th_num){
		log.info("list 호출 성공");
		
		List<HallVO> entity = null;
		entity = clientTicketService.hall_list(th_num);
		return entity;
	}
	
	
}
