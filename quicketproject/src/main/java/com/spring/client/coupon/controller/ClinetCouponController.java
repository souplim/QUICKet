package com.spring.client.coupon.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.admin.coupon.service.AdminCouponService;
import com.spring.admin.coupon.vo.AdminCouponVO;
import com.spring.client.coupon.service.ClientCouponService;
//import com.spring.common.vo.PageDTO;
import com.spring.client.coupon.vo.UserCouponVO;
import com.spring.client.user.vo.UserVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("user/coupon/*")
@SessionAttributes("userLogin")
@Slf4j
public class ClinetCouponController {
	
	@Setter(onMethod_ = @Autowired)
	private ClientCouponService clientCouponService;
	
	@Setter(onMethod_ = @Autowired)
	private AdminCouponService adminCouponService;
	
	@GetMapping("/")
	public String main(@ModelAttribute("userLogin") UserVO userLogin, AdminCouponVO avo, UserCouponVO uvo, Model model) {
		log.info("사용자 쿠폰 메인 페이지 (쿠폰 리스트) 호출 및 실행");
		
		List<AdminCouponVO> couponList = adminCouponService.couponList(avo);
		model.addAttribute("couponList", couponList);
		/*
		String id = userLogin.getU_id();
		List<UserCouponVO> userCoupon = clientCouponService.userCoupon(id);
		model.addAttribute("userCoupon", userCoupon);
		*/
		/*
		int total = adminCouponService.couponListCnt(avo);
		model.addAttribute("pageMaker", new PageDTO(avo, total));
		
		int count = total - (avo.getPageNum() - 1) * avo.getAmount();
		model.addAttribute("count", count);
		*/
		
		return "client/coupon/main";
	}
	
	@PostMapping("/getCoupon")
	public String getCoupon(UserCouponVO vo, Model model, RedirectAttributes ras) throws Exception {
		log.info("쿠폰 발급 getCoupon() ");
		
		int result = 0;
		
		result = clientCouponService.getCoupon(vo);
		if(result == 1) {
			log.info("쿠폰 발급 성공");
			ras.addFlashAttribute("errorMsg", "쿠폰 발급이 완료되었습니다.");
		} else {
			log.info("쿠폰 발급 실패");
			ras.addFlashAttribute("errorMsg", "쿠폰 발급에 실패했습니다.");
		}
		
		return "redirect:/user/coupon/";
	}
	
	@PostMapping("/couponChk")
	public ResponseEntity<String> couponChk(@ModelAttribute UserCouponVO vo, RedirectAttributes ras) throws Exception {
		log.info("쿠폰 보유 여부 확인");
		ResponseEntity<String> entity = null;
		int result = 0;
		result = clientCouponService.couponChk(vo);
		entity = new ResponseEntity<String>(String.valueOf(result), HttpStatus.OK);
		return entity;
	}	

}
