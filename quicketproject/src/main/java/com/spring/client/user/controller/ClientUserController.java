package com.spring.client.user.controller;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
//import java.util.List;
<<<<<<< HEAD
import java.util.List;
=======
>>>>>>> 3426caeb608bf1188635703f62a14c7ccddc2022

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
<<<<<<< HEAD
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
=======
>>>>>>> 3426caeb608bf1188635703f62a14c7ccddc2022
///import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.client.user.service.ClientUserService;
import com.spring.client.user.vo.UserVO;
import com.spring.common.mail.MailService;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@SessionAttributes("userLogin")
@RequestMapping("/user/*")
@Slf4j
public class ClientUserController {
	
	@Setter(onMethod_ = @Autowired)
	private ClientUserService clientUserService;
	
	@Setter(onMethod_ = @Autowired)
	private MailService mailService;

	@ModelAttribute
	public UserVO userLogin() {
		return new UserVO();
	}
	
	/*************************************************************
	 * 로그인 화면 구현 메서드
	 * 요청 URL : http://localhost:8080/user/login 으로 요청
	 *************************************************************/
	@GetMapping("/login")
	public String loginForm() {
		log.info("client 로그인 화면 호출");
		return "client/user/login"; 	// views/client/login.jsp
	}
	
	/*************************************************************
	 * 회원가입 화면 구현 메서드
	 * 요청 URL : http://localhost:8080/user/join 으로 요청
	 *************************************************************/
<<<<<<< HEAD
=======
	/*
>>>>>>> 3426caeb608bf1188635703f62a14c7ccddc2022
	@GetMapping("/join")
	public String joinForm() {
		log.info("client 회원가입 화면 호출");
		return "client/user/join"; 	// views/client/login.jsp
<<<<<<< HEAD
	}
=======
	}*/
>>>>>>> 3426caeb608bf1188635703f62a14c7ccddc2022
	
	/*************
	 * 회원가입 처리 메서드
	 */
<<<<<<< HEAD
	@PostMapping("/userJoin")
=======
	/*@PostMapping("/userJoin")
>>>>>>> 3426caeb608bf1188635703f62a14c7ccddc2022
	public String userJoin(UserVO user, Model model, RedirectAttributes ras) throws Exception {
		log.info("회원가입 처리 메소드 호출 userJoin() ");
		
		int result = 0;
		String path = "";
		
		result = clientUserService.userJoin(user);
		if(result == 1) {
			ras.addFlashAttribute("errorMsg", "회원가입이 완료되었습니다.");
			path = "/user/login";
		} else {
			path = "/user/join";
		}
		return "redirect:" + path;
	}
<<<<<<< HEAD
	
=======
	*/
>>>>>>> 3426caeb608bf1188635703f62a14c7ccddc2022
	@PostMapping("/login")
	public String userLoginProcess(UserVO login, Model model, RedirectAttributes ras, HttpSession session) {
		String url = "";
		log.info("client 로그인 처리 호출");
		
		UserVO userLogin = clientUserService.userLoginProcess(login);
		
		boolean dateResult = false;
		try {
			/* 시간 계산 */
			// 비밀번호 변경 날짜 String -> Date 로 변경
			SimpleDateFormat sdformat = new SimpleDateFormat("YYYY-MM-DD");
			String u_pwddate = userLogin.getU_pwddate();
			Date pwddate = sdformat.parse(u_pwddate);
	        log.info("비밀번호 변경 날짜 :" + pwddate); // Sat Jun 19 21:05:07 KST 2021
			// 오늘 날짜 계산
			Date now = new Date();
			Calendar today = Calendar.getInstance();
			today.setTime(now);
	        
	        //String setPwdDate = "";
	        Calendar setPwdDate = Calendar.getInstance();
	        setPwdDate.setTime(pwddate);
	        setPwdDate.add(Calendar.MONTH, 3);
	        log.info("비밀번호 변경 주기 날짜 : " +  new Date(setPwdDate.getTimeInMillis()));
	        
	        // 날짜 비교
	        dateResult = setPwdDate.before(today);
	        ////////////////
	        log.info("날짜 비교 결과 : " + dateResult);
		} catch (ParseException ex){
			ex.printStackTrace();
		} 
		
		if(userLogin != null && userLogin.getU_state() == 1 && dateResult == false) {
			model.addAttribute("userLogin", userLogin);
			log.info("사용자 상태 : " + userLogin.getU_state());
			url = "/user/userInfo?u_num=" + userLogin.getU_num(); 	// 메인페이지로 이동하도록 설정.
		} else if (userLogin.getU_state() == 0) {
			ras.addFlashAttribute("errorMsg", "탈퇴 회원입니다.");
			url = "/user/login";
		}else if (dateResult == true) {
			ras.addFlashAttribute("errorMsg", "비밀번호 변경 주기가 지났습니다. 비밀번호를 변경해주세요.");
			model.addAttribute("userLogin", userLogin);
			url = "/user/setPwdForm?u_num=" + userLogin.getU_num();
		} else {
			ras.addFlashAttribute("errorMsg", "로그인 실패");
			url = "/user/login";
		}
		return "redirect:"+url;
		
	}
	
	 /*************************************************************
	  * 로그아웃 처리 메서드
	  * setComplete() 메서드 활용하여 세션을 할당 해지
	 *************************************************************/
	@RequestMapping("/logout")
	public String logout(SessionStatus sessionStatus) {
		log.info("client 로그인 아웃 처리");
		sessionStatus.setComplete();
		return "redirect:/user/login";
	}

	
	/*************************************************************
	 * 회원 정보 조회 화면 구현 메서드
	 * 요청 URL : http://localhost:8080/user/join 으로 요청
	 *************************************************************/
	@GetMapping("/userInfo")
	public String userInfo(@ModelAttribute UserVO uvo, Model model) {
		
		UserVO userinfo = clientUserService.userInfo(uvo);
		model.addAttribute("userInfo",userinfo);
		
		log.info("client 회원정보 화면 호출");
		return "client/user/userInfo"; 	// views/client/userInfo.jsp
	}

	/*************************************************************
	 * 회원 정보 수정 화면 구현 메서드
	 * 요청 URL : http://localhost:8080/user/userUpdateForm 으로 요청
	 *************************************************************/
<<<<<<< HEAD
	@GetMapping("/userUpdateForm")
=======
	/*@GetMapping("/userUpdateForm")
>>>>>>> 3426caeb608bf1188635703f62a14c7ccddc2022
	public String userUpdateForm(@ModelAttribute UserVO uvo, Model model) {
		
		UserVO userinfo = clientUserService.userInfo(uvo);
		model.addAttribute("userInfo",userinfo);
		
		log.info("client 회원정보수정 화면 호출");
		return "client/user/userUpdateForm"; 	// views/client/userUpdateForm.jsp
	}
	
	@PostMapping("/userUpdate")
	public String userUpdate(@ModelAttribute UserVO vo, Model model, RedirectAttributes ras) throws Exception {
		log.info("회원정보 수정 처리 userUpdate() ");
		
		int result = 0;
		String path = "";
		
		result = clientUserService.userUpdate(vo);
		if(result == 1) {
			ras.addFlashAttribute("errorMsg", "회원 정보 수정이 완료되었습니다.");
			path = "/user/userInfo?u_num=" + vo.getU_num();
		} else {
			path = "/user/userUpdateForm?u_num=" + vo.getU_num();
		}
		return "redirect:" + path;
	}
<<<<<<< HEAD
	
=======
	*/
>>>>>>> 3426caeb608bf1188635703f62a14c7ccddc2022
	
	/****
	 * 인증메일 전송 메소드
	 */
<<<<<<< HEAD
	@PostMapping("/mailConfirm")
=======
	/*@PostMapping("/mailConfirm")
>>>>>>> 3426caeb608bf1188635703f62a14c7ccddc2022
	@ResponseBody
	public String mailConfirm(String email) throws Exception {
	    String code = mailService.sendMessage(email);
	    log.info("인증코드 : " + code);
	    return code;
	}
<<<<<<< HEAD
	
	/**
	 * 비밀번호 재설정 폼 화면 
	 */
	@GetMapping("/setPwdForm")
=======
	*/
	/**
	 * 비밀번호 재설정 폼 화면 
	 */
	/*@GetMapping("/setPwdForm")
>>>>>>> 3426caeb608bf1188635703f62a14c7ccddc2022
	public String setPwdForm(@ModelAttribute UserVO uvo, Model model) {
		
			UserVO userinfo = clientUserService.userInfo(uvo);
			model.addAttribute("userInfo",userinfo);
			
			log.info("client 회원정보 화면 호출");
			return "client/user/setPwdForm"; 	// views/client/userInfo.jsp
<<<<<<< HEAD
	}
	
	/**
	 * 비밀번호 재설정 처리
	 */
=======
	}*/
	
	/**
	 * 비밀번호 재설정 처리
	 
>>>>>>> 3426caeb608bf1188635703f62a14c7ccddc2022
	@PostMapping("/setNewPwd")
	public String setNewPwd(@ModelAttribute UserVO uvo, Model model, RedirectAttributes ras) throws Exception {
		log.info("비밀번호 재설정 메소드 호출");
		
		int result = 0;
		String path = "";
		
		result = clientUserService.setNewPwd(uvo);
		if(result == 1) {
			ras.addFlashAttribute("errorMsg", "비밀번호가 변경되었습니다.");
			path = "/user/userInfo?u_num=" + uvo.getU_num();
		} else {
			ras.addFlashAttribute("errorMsg", "오류 발생");
			path = "/user/setPwdForm?u_num=" + uvo.getU_num();
		}
		return "redirect:" + path;
<<<<<<< HEAD
	}
	
	/**
	 * 회원 탈퇴 처리
	*/
=======
	}*/
	
	/**
	 * 회원 탈퇴 처리
	
>>>>>>> 3426caeb608bf1188635703f62a14c7ccddc2022
	@GetMapping("/userDelete")
	public String userDelete(@ModelAttribute UserVO uvo, Model model, RedirectAttributes ras) throws Exception {
		log.info("회원 탈퇴 처리 메소드 호출");
	
		int result = 0;
		String path = "";
		
		result = clientUserService.userDelete(uvo);
		
		if(result == 1) {
			ras.addFlashAttribute("errorMsg", "회원 탈퇴를 완료하였습니다.");
			path = "/user/logout";
		} else {
			ras.addFlashAttribute("errorMsg", "탈퇴 처리에 실패했습니다.");
			path = "/user/userInfo?u_num=" + uvo.getU_num();
		}
		
		return "redirect:"+path;
	}
<<<<<<< HEAD
	 
=======
	 */
>>>>>>> 3426caeb608bf1188635703f62a14c7ccddc2022
	/*************************************************************
	 * 아이디 비밀번호 찾기 (아이디 찾기) 화면 구현 메서드
	 * 요청 URL : http://localhost:8080/user/join 으로 요청
	 *************************************************************/
<<<<<<< HEAD
	@GetMapping("/searchIdForm")
=======
	/*@GetMapping("/searchIdForm")
>>>>>>> 3426caeb608bf1188635703f62a14c7ccddc2022
	public String searchIdForm() {
		log.info("아이디 찾기 화면 호출");
		return "client/user/searchIdForm"; 	// views/client/login.jsp
	}
	
	@PostMapping("/searchIdPhone")
	@ResponseBody
	public List<UserVO> searchIdPhone(@RequestParam("u_name") String u_name, @RequestParam("u_phone") String u_phone, Model model) {
		log.info("전화번호로 아이디 찾기 메소드 실행");
		
		List<UserVO> list = clientUserService.searchIdPhone(u_name, u_phone);
		model.addAttribute("list",list);
		
		return list;
	}
	
	@PostMapping("/searchIdEmail")
	@ResponseBody
	public List<UserVO> searchIdEmail(@RequestParam("u_name") String u_name, @RequestParam("u_email") String u_email, Model model) {
		log.info("전화번호로 아이디 찾기 메소드 실행");
		
		List<UserVO> list = clientUserService.searchIdEmail(u_name, u_email);
		model.addAttribute("list",list);
		
		return list;
	}
	
	@PostMapping("/userConfirm")
	@ResponseBody
	public int userConfirm(@RequestParam("u_name") String u_name, @RequestParam("u_id") String u_id, @RequestParam("u_email") String u_email, Model model) {
		int result = 0;
		
		log.info("비밀번호 찾기 - 회원정보 존재 여부 확인");
		
		result = clientUserService.userConfirm(u_name, u_id, u_email);
		//model.addAttribute("data", result);
		
		return result;
<<<<<<< HEAD
	}
=======
	}*/
>>>>>>> 3426caeb608bf1188635703f62a14c7ccddc2022

}
