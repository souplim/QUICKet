package com.spring.admin.user.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.admin.user.service.AdminUserService;
import com.spring.client.coupon.service.ClientCouponService;
import com.spring.client.mypage.service.MypageService;
import com.spring.client.mypage.vo.MypageVO;
import com.spring.client.user.vo.UserVO;
import com.spring.common.mail.MailService;
import com.spring.common.vo.PageDTO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@SessionAttributes("adminLogin")
@RequestMapping("/admin/user/*")
@Slf4j
public class AdminUserController {

	@Setter(onMethod_ = @Autowired)
	private AdminUserService adminUserService;
	
	
	@Setter(onMethod_ = @Autowired)
	private MailService mailService;
	
	@Setter(onMethod_ = @Autowired)
	private ClientCouponService clientCouponService;
	
	@Setter(onMethod_ = @Autowired)
	private MypageService mypageService;
	
	/***
	 * 회원관리 페이지
	 */
	@GetMapping("/userList")
	public String userList(@ModelAttribute("data") UserVO vo, Model model) {
		log.info("회원 리스트 출력");
		
		List<UserVO> userList = adminUserService.userList(vo);
		model.addAttribute("userList",userList);
		
		int total = adminUserService.userListCnt(vo);
		model.addAttribute("pageMaker", new PageDTO(vo, total));
		
		int count = total - (vo.getPageNum() - 1) * vo.getAmount();
		model.addAttribute("count", count);
		
		return "admin/user/userList";
	}
	
	/**
	 * 회원 탈퇴 처리 (상태 변경) 메소드
	 */
	@GetMapping("/userDelete")
	public String userDelete(int u_num, RedirectAttributes ras) throws Exception {
		log.info("회원 탈퇴 처리 메소드 실행");
		
		int result = 0;
		
		UserVO vo = new UserVO();
		vo.setU_num(u_num);
	
		result = adminUserService.userDelete(vo);
		ras.addFlashAttribute("userVO", vo);
		
		if (result == 1) {
			//ras.addFlashAttribute("errorMsg", "탈퇴처리가 완료되었습니다.");
		}

		return "redirect:/admin/user/userList";
		
	}
	
	/**
	 * 탈퇴 처리 메일 전송 메소드
	 */
	@PostMapping("/mailDelete")
	@ResponseBody
	public String mailDelete(String email) throws Exception {
		String result = "";
		result = mailService.mailDelete(email);
		log.info("result");
		return result;
	}
	
	/** 회원 쿠폰 내역 이동 */
	@GetMapping("/userCouponList")
	public String userCouponList(String u_id, Model model) {
		log.info("회원 쿠폰 내역");
		
		List<MypageVO> userCouponList = adminUserService.userCouponList(u_id);
		model.addAttribute("couponList",userCouponList);
		
		return "/admin/user/userCouponList";
	}
	
	@GetMapping(value="/userTicketList")
	public String userTicketList(String u_id, @ModelAttribute MypageVO mypageVO, Model model ) {
		log.info("예매내역 화면");
		
		mypageVO.setU_id(u_id);
		
		// 회원 문의글 리스트 조회
		List<MypageVO> ticketList = null;
		ticketList = mypageService.myTicketList(mypageVO);
		model.addAttribute("ticketList", ticketList);
		
		// 페이징 처리
		/*
		int total = mypageService.ticketListCnt(mypageVO);
		model.addAttribute("pageMaker", new PageDTO(mypageVO, total));
			*/	
		return "/admin/user/userTicketList"; // /WEB-INF/views/client/mypage/myTicketList.jsp
	}
	
 
}
