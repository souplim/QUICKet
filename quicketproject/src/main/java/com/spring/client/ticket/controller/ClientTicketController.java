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

@Controller
@RequestMapping("/client/ticket/*")
//@Log4j
@Slf4j
public class ClientTicketController {
	
	/*
	@Setter(onMethod_ = @Autowired)
	private ClientTicketService clientTicketService;
	
	// 공연상세페이지
	@RequestMapping(value="/showDetail", method = RequestMethod.GET)
	public String ticketDetail(@ModelAttribute("data") HallVO hvo, Model model) {
		log.info("ticketDetail 호출 성공");
		HallVO hall_list = clientTicketService.hall_th_num(hvo);
		model.addAttribute("hall_list",hall_list);
		
		return "client/ticket/showDetail"; 
		
	}
	*/
	
	
}
