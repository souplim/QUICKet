package com.spring.client.paypage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.client.paypage.service.ClientPayPageService;
import com.spring.client.paypage.vo.AmountVO;
import com.spring.client.paypage.vo.CouponVO;
import com.spring.client.paypage.vo.PayPageVO;
import com.spring.client.paypage.vo.SeatVO;
import com.spring.client.paypage.vo.ticketSuccessVO;
import com.spring.client.show.service.ClientShowService;
import com.spring.client.show.vo.ShowVO;
import com.spring.client.user.vo.UserVO;
import com.spring.common.vo.PageDTO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/client/payPage/*")
@SessionAttributes("userLogin")
//@Log4j
@Slf4j
public class ClientPayPageController {

	@Setter(onMethod_ = @Autowired)
	private ClientPayPageService clientPayPageService;
	@Setter(onMethod_=@Autowired)
	private ClientShowService clientShowService;
	// 공연상세페이지
	@RequestMapping(value = "/pay_step1", method = RequestMethod.GET)
	public String pay_step1(@ModelAttribute("data") PayPageVO pvo, Model model) {
		log.info("pay_step1 호출 성공");
		PayPageVO hall_list = clientPayPageService.hall_th_num(pvo);
		model.addAttribute("hall_list", hall_list);
		
		ShowVO vo = new ShowVO();
		vo.setS_num(hall_list.getS_num());
		ShowVO detailData = clientShowService.showDetail(vo);
		model.addAttribute("detailData", detailData);
		 
			
		return "/client/payPage/pay_step1";

	}

	// 공연상세페이지
	@RequestMapping(value = "/pay_step2", method = RequestMethod.GET)
	public String pay_step2(@ModelAttribute("data") PayPageVO pvo,ShowVO vo, Model model) {
		log.info("pay_step2 호출 성공");
		
		PayPageVO pay_step2_list = clientPayPageService.pay_step2_list(pvo);
		model.addAttribute("pay_step2_list", pay_step2_list);

		List<PayPageVO> pay_step2_seat = clientPayPageService.pay_step2_seat(pvo);
		model.addAttribute("pay_step2_seat", pay_step2_seat);

		vo.setS_num(vo.getS_num());
		ShowVO detailData = clientShowService.showDetail(vo);
		model.addAttribute("detailData", detailData);
		
		return "/client/payPage/pay_step2";

	}

	// pay_step3 가기

	@RequestMapping(value = "/pay_step3", method = RequestMethod.POST)
	public String pay_step3(@ModelAttribute PayPageVO pvo,ShowVO vo, Model model,HttpSession session) {
		log.info("pay_step3 호출 성공");
		
		PayPageVO pay_step3_list = clientPayPageService.pay_step3_list(pvo);
		model.addAttribute("pay_step3_list", pay_step3_list);
		
		model.addAttribute("SeatMapData", pvo.getSeatList());
		
		// 아이디 세션 값 get
		UserVO sessionVal = (UserVO)session.getAttribute("userLogin");
		
		List<CouponVO> pay_step3_coupon = null; 
		if(sessionVal.getU_id() == null) {
			return "/client/payPage/paypageError/uIdNullError";
		}
		else {
			pay_step3_coupon = clientPayPageService.pay_step3_coupon(sessionVal.getU_id());
			model.addAttribute("pay_step3_coupon", pay_step3_coupon);
			 
			vo.setS_num(vo.getS_num());
			ShowVO detailData = clientShowService.showDetail(vo);
			model.addAttribute("detailData", detailData);
			
			return "/client/payPage/pay_step3";
		}

	}
	// pay_step4 가기
	
	@RequestMapping(value = "/pay_step4", method = RequestMethod.POST)
	public String pay_step4(@ModelAttribute PayPageVO pvo, CouponVO cvo,ShowVO vo, AmountVO avo, Model model, HttpSession session) {
		log.info("pay_step4 호출 성공");
		
		PayPageVO pay_step4_list = clientPayPageService.pay_step4_list(pvo);
		model.addAttribute("pay_step4_list", pay_step4_list);
		
		model.addAttribute("SeatMapData", pvo.getSeatList());
		
		model.addAttribute("CouponVOData", cvo);
		
		model.addAttribute("AmountVOData", avo);
		
		
		// 아이디 세션 값 get 
		UserVO uvo = (UserVO)session.getAttribute("userLogin");
		  
		model.addAttribute("pay_step4_UserData", uvo);
		
		vo.setS_num(vo.getS_num());
		ShowVO detailData = clientShowService.showDetail(vo);
		model.addAttribute("detailData", detailData);
		 
		return "/client/payPage/pay_step4";
		
	}
	
	@RequestMapping(value = "/ticketSuccessPage", method = RequestMethod.GET)
	public String ticketSuccessPage(@ModelAttribute ticketSuccessVO tsvo,ShowVO vo, Model model) {
		log.info("ticketSuccessPage 호출 성공");
		
		ticketSuccessVO ticketSuccessPage = clientPayPageService.ticketSuccessPage(tsvo);
		model.addAttribute("ticketSuccessPage", ticketSuccessPage);
		
		vo.setS_num(vo.getS_num());
		ShowVO detailData = clientShowService.showDetail(vo);
		model.addAttribute("detailData", detailData);
		return "/client/payPage/ticketSuccessPage";
		
	}

	
	 

}
