package com.spring.client.paypage.controller;

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

import com.spring.client.paypage.service.ClientPayPageService;
import com.spring.client.paypage.vo.AmountVO;
import com.spring.client.paypage.vo.CouponVO;
import com.spring.client.paypage.vo.PayPageVO;
import com.spring.client.paypage.vo.SeatVO;
import com.spring.client.paypage.vo.UserVO;
import com.spring.common.vo.PageDTO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/client/payPage/*")
//@Log4j
@Slf4j
public class ClientPayPageController {

	@Setter(onMethod_ = @Autowired)
	private ClientPayPageService clientPayPageService;

	// 공연상세페이지
	@RequestMapping(value = "/pay_step1", method = RequestMethod.GET)
	public String pay_step1(@ModelAttribute("data") PayPageVO pvo, Model model) {
		log.info("pay_step1 호출 성공");
		PayPageVO hall_list = clientPayPageService.hall_th_num(pvo);
		model.addAttribute("hall_list", hall_list);

		return "/client/payPage/pay_step1";

	}

	// 공연상세페이지
	@RequestMapping(value = "/pay_step2", method = RequestMethod.GET)
	public String pay_step2(@ModelAttribute("data") PayPageVO pvo, Model model) {
		log.info("pay_step2 호출 성공");
		
		PayPageVO pay_step2_list = clientPayPageService.pay_step2_list(pvo);
		model.addAttribute("pay_step2_list", pay_step2_list);

		List<PayPageVO> pay_step2_seat = clientPayPageService.pay_step2_seat(pvo);
		model.addAttribute("pay_step2_seat", pay_step2_seat);

		return "/client/payPage/pay_step2";

	}

	// pay_step3 가기

	@RequestMapping(value = "/pay_step3", method = RequestMethod.POST)
	public String pay_step3(@ModelAttribute PayPageVO pvo, Model model) {
		log.info("pay_step3 호출 성공");
		
		PayPageVO pay_step3_list = clientPayPageService.pay_step3_list(pvo);
		model.addAttribute("pay_step3_list", pay_step3_list);
		
		model.addAttribute("SeatMapData", pvo.getSeatList());
	
		// 아이디 세션이 없어서 임시방편으로 set u_id
		String u_id = "user02";
		List<CouponVO> pay_step3_coupon = clientPayPageService.pay_step3_coupon(u_id);
		model.addAttribute("pay_step3_coupon", pay_step3_coupon);
		
		return "/client/payPage/pay_step3";

	}
	// pay_step4 가기
	
	@RequestMapping(value = "/pay_step4", method = RequestMethod.POST)
	public String pay_step4(@ModelAttribute PayPageVO pvo, CouponVO cvo, AmountVO avo, Model model) {
		log.info("pay_step4 호출 성공");
		
		PayPageVO pay_step4_list = clientPayPageService.pay_step4_list(pvo);
		model.addAttribute("pay_step4_list", pay_step4_list);
		
		model.addAttribute("SeatMapData", pvo.getSeatList());
		
		model.addAttribute("CouponVOData", cvo);
		
		model.addAttribute("AmountVOData", avo);
		
		// 아이디 세션이 없어서 임시방편으로 set u_id
		String u_id = "user02";
		UserVO uvo = new UserVO();
		uvo.setU_id(u_id);
		UserVO pay_step4_UserData = clientPayPageService.pay_step4_UserData(uvo);
		
		model.addAttribute("pay_step4_UserData", pay_step4_UserData);
		return "/client/payPage/pay_step4";
		
	}

	
	 

}
