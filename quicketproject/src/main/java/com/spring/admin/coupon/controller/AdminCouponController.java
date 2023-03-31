package com.spring.admin.coupon.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.admin.coupon.service.AdminCouponService;
import com.spring.admin.coupon.vo.AdminCouponVO;
import com.spring.common.vo.PageDTO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/coupon/*")
@Slf4j
public class AdminCouponController {
	
	@Setter(onMethod_ = @Autowired)
	private AdminCouponService adminCouponService;

	@GetMapping("/main")
	public String couponList(@ModelAttribute("data") AdminCouponVO vo, Model model) {
		log.info("관리자 쿠폰 메인 페이지 (쿠폰 리스트) 호출 및 실행");
		
		List<AdminCouponVO> couponList = adminCouponService.couponList(vo);
		model.addAttribute("couponList", couponList);
		
		int total = adminCouponService.couponListCnt(vo);
		model.addAttribute("pageMaker", new PageDTO(vo, total));
		
		int count = total - (vo.getPageNum() - 1) * vo.getAmount();
		model.addAttribute("count", count);
		
		return "admin/coupon/main";
	}
}

