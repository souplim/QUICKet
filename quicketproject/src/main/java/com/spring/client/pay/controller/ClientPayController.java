package com.spring.client.pay.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.client.pay.service.ClientPayService;
import com.spring.client.paypage.service.ClientPayPageService;
import com.spring.client.paypage.vo.AmountVO;
import com.spring.client.paypage.vo.CouponVO;
import com.spring.client.paypage.vo.PayPageVO;
import com.spring.client.paypage.vo.SeatVO;
import com.spring.common.vo.PageDTO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/client/pay/*")
//@Log4j
@Slf4j
public class ClientPayController {

	@Setter(onMethod_ = @Autowired)
	private ClientPayService clientPayService;

	/*
	 * // 공연상세페이지
	 * 
	 * @RequestMapping(value = "/pay_step1", method = RequestMethod.GET) public
	 * String pay_step1(@ModelAttribute("data") PayPageVO pvo, Model model) {
	 * log.info("pay_step1 호출 성공"); PayPageVO hall_list =
	 * clientPayService.hall_th_num(pvo); model.addAttribute("hall_list",
	 * hall_list);
	 * 
	 * return "/client/payPage/pay_step1";
	 * 
	 * }
	 */


	
	 

}
