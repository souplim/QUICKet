package com.spring.error.ticket.controller;

import java.io.IOException;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonObject;
import com.spring.admin.ticket.service.AdminTicketService;
import com.spring.admin.ticket.vo.HallVO;
import com.spring.client.pay.service.PaymentService;
import com.spring.client.pay.vo.PayVO;
import com.spring.client.paypage.vo.SeatVO;
import com.spring.common.vo.PageDTO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/error/ticket/*")
//@Log4j
@Slf4j
public class errorTicketController {
	
	
	@RequestMapping(value="/childhallError")
	public String childError(@ModelAttribute HallVO hvo, Model model) {
		log.info("childError 호출 성공");
		model.addAttribute("hvo",hvo);
		return "admin/ticket/ticketError/childhallError";
	}
	
	@RequestMapping(value="/childseatError")
	public String childError(@ModelAttribute SeatVO svo, Model model) {
		log.info("childError 호출 성공");
		model.addAttribute("svo",svo);
		return "admin/ticket/ticketError/childseatError";
	}
	
}
