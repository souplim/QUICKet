package com.spring.client.user.controller;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
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
	
	@GetMapping("/join")
	public String joinForm() {
		log.info("client 회원가입 화면 호출");
		return "client/user/join"; 	// views/client/login.jsp
	}
	
	/*************
	 * 회원가입 처리 메서드
	 */
	@PostMapping("/userJoin")
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
	
	@PostMapping("/login")
	public String userLoginProcess(UserVO login, Model model, RedirectAttributes ras, HttpSession session, HttpServletRequest request) {
		String url = "";
		log.info("client 로그인 처리 호출");
		
		UserVO userLogin = null;
		userLogin = clientUserService.userLoginProcess(login);
		
		boolean dateResult = false;
		try {
			if(userLogin != null)
			{
				/* 시간 계산 */
				// 비밀번호 변경 날짜 String -> Date 로 변경
				SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
				String u_pwddate = userLogin.getU_pwddate();
				Date pwddate = dateformat.parse(u_pwddate);
		        log.info("비밀번호 변경 날짜 :" + u_pwddate + " / " + pwddate); // Sat Jun 19 21:05:07 KST 2021
		        log.info(">> " + dateformat.format(pwddate));
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
		        
		      
			}
			
		} catch (ParseException ex){
			ex.printStackTrace();
		} 
		if (userLogin == null) {
			ras.addFlashAttribute("errorMsg", "입력한 아이디가 존재하지 않거나 아이디 비밀번호가 올바르지 않습니다.");
			url = "/user/login";
		} else if(userLogin != null && userLogin.getU_state() == 1 && dateResult == false) {
			model.addAttribute("userLogin", userLogin);
			log.info("사용자 상태 : " + userLogin.getU_state());
			
			// 기존 요청 존재하는지 체크 후 원래 요청 페이지로 리다이렉트
			String original_dest = (String) session.getAttribute("dest");
			if(original_dest != null && original_dest.length() > 0) {
				System.out.println("redirect:" + original_dest);
			    url = "http://localhost:8080"+original_dest;
			    session.removeAttribute("dest");
			} else {
				url = "http://localhost:8080/";	// 메인 페이지로 redirect
			}
			
		} else if (userLogin.getU_state() == 0) {
			ras.addFlashAttribute("errorMsg", "탈퇴 회원입니다.");
			url = "/user/login";
		} else if (dateResult == true) {
			ras.addFlashAttribute("errorMsg", "비밀번호 변경 주기가 지났습니다. 비밀번호를 변경해주세요.");
			model.addAttribute("userLogin", userLogin);
			url = "/user/setPwdForm";
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
	public String userInfo(@SessionAttribute("userLogin") UserVO uvo, RedirectAttributes ras, HttpServletRequest request) {

		String url = "";
		
		if(uvo.getU_id() == null) {
			ras.addFlashAttribute("errorMsg", "로그인이 필요합니다.");
	        url = "redirect:" + request.getHeader("Referer");
		} else {		
			log.info(uvo.getU_pwddate());
			log.info("client 회원정보 화면 호출");
			url = "client/user/userInfo";
		}
		return url; 	// views/client/userInfo.jsp
	}

	/*************************************************************
	 * 회원 정보 수정 화면 구현 메서드
	 * 요청 URL : http://localhost:8080/user/userUpdateForm 으로 요청
	 *************************************************************/
	@GetMapping("/userUpdateForm")
	public String userUpdateForm(@ModelAttribute("userLogin") UserVO uvo, Model model) {
		/*
		UserVO userinfo = clientUserService.userInfo(uvo);
		model.addAttribute("userInfo",userinfo);
		*/
		log.info("client 회원정보수정 화면 호출");
		return "client/user/userUpdateForm"; 	// views/client/userUpdateForm.jsp
	}
	
	/*
	@GetMapping("/pwdConfirm")
	public String pwdConfirm() {
		log.info("비밀번호 확인 화면");
		return "client/user/pwdConfirm";
	}
	*/
	
	@PostMapping("/userUpdate")
	public String userUpdate(@ModelAttribute("userLogin") UserVO vo, Model model, RedirectAttributes ras) throws Exception {
		log.info("회원정보 수정 처리 userUpdate() ");
		
		int result = 0;
		String path = "";
		
		result = clientUserService.userUpdate(vo);
		
		
		
		if(result == 1) {
			ras.addFlashAttribute("errorMsg", "회원 정보 수정이 완료되었습니다.");
			path = "/user/userInfo";
		} else {
			path = "/user/userUpdateForm";
		}
		return "redirect:" + path;
	}
	
	
	/****
	 * 인증메일 전송 메소드
	 */
	@PostMapping("/mailConfirm")
	@ResponseBody
	public String mailConfirm(String email) throws Exception {
	    String code = mailService.sendMessage(email);
	    log.info("인증코드 : " + code);
	    return code;
	}

	
	/**
	 * 비밀번호 재설정 폼 화면 
	 */
	@GetMapping("/setPwdForm")
	public String setPwdForm(@ModelAttribute("userLogin") UserVO uvo, Model model) {
			log.info("client 비밀번호 변경 폼 호출");
			return "client/user/setPwdForm"; 	// views/client/userInfo.jsp
	}
	
	
	/**
	 * 비밀번호 재설정 처리
	 */
	@PostMapping("/setNewPwd")
	public String setNewPwd(@ModelAttribute("userLogin") UserVO uvo, Model model, RedirectAttributes ras, SessionStatus sessionStatus) throws Exception {
		log.info("비밀번호 재설정 메소드 호출");
		
		int result = 0;
		String path = "";
		
		result = clientUserService.setNewPwd(uvo);
		
		if(result == 1) {
			ras.addFlashAttribute("errorMsg", "변경된 비밀번호로 다시 로그인해주세요.");
			//model.addAttribute("userLogin", uvo);
			sessionStatus.setComplete();
			path = "/user/login";
		} else {
			ras.addFlashAttribute("errorMsg", "오류 발생");
			path = "/user/setPwdForm";
		}
		return "redirect:" + path;
	}
	
	/**
	 * 회원 탈퇴 처리
	*/
	@GetMapping("/userDelete")
	public String userDelete(@ModelAttribute("userLogin") UserVO uvo, Model model, RedirectAttributes ras) throws Exception {
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
	
	/*************************************************************
	 * 아이디 비밀번호 찾기 (아이디 찾기) 화면 구현 메서드
	 * 요청 URL : http://localhost:8080/user/join 으로 요청
	 *************************************************************/
	@GetMapping("/searchIdForm")
	public String searchIdForm() {
		log.info("아이디 찾기 화면 호출");
		return "client/user/searchIdForm"; 	// views/client/login.jsp
	}
	
	@PostMapping("/searchIdPhone")
	@ResponseBody
	public List<UserVO> searchIdPhone(@RequestParam("u_name") String u_name, @RequestParam("u_phone") String u_phone, Model model) {
		log.info("전화번호로 아이디 찾기 메소드 실행");
		
		List<UserVO> list = null;
		list = clientUserService.searchIdPhone(u_name, u_phone);
		if(list.isEmpty()) {
			log.info("결과 없음"+ list);
		} else {
			model.addAttribute("list",list);
			log.info("결과 : " + list);
		}
		
		return list;
	}
	
	@PostMapping("/searchIdEmail")
	@ResponseBody
	public List<UserVO> searchIdEmail(@RequestParam("u_name") String u_name, @RequestParam("u_email") String u_email, Model model) {
		log.info("전화번호로 아이디 찾기 메소드 실행");
		
		List<UserVO> list = null;
		list = clientUserService.searchIdEmail(u_name, u_email);
		if(list.isEmpty()) {
			log.info("결과 없음" + list);
		} else {
			model.addAttribute("list",list);
			log.info("결과 : " + list);
		}
		
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
	}
	
	

	
	/**
	 * 임시 비밀번호 전송 후 비밀번호 변경
	 */
	@PostMapping("/sendTempPwd")
	public String sendTempPwd(String email, String id) throws Exception {
		String pwd = mailService.sendTempPwd(email);
		log.info("임시 비밀번호 전송 완료");
		
		UserVO user = new UserVO();
		user.setU_id(id);
		user.setU_pwd(pwd);
		clientUserService.setNewPwd(user);
		log.info("비밀번호 변경 완료 >> " + pwd );
		
		return "client/user/login";
	}
	
	// 아이디 중복 체크
	@ResponseBody
	@PostMapping("/idCheck")
	public int idCheck(String u_id) {
		log.info("아이디 중복 체크");
		String value = "";
		
		int result = clientUserService.idCheck(u_id);
		if (result == 1) {
			value = "결과 : 중복되는 아이디";
		} else {
			value = "결과 : 유일한 아이디";
		}
		log.info("result : " + result + ", value : " + value );
		return result;
	}
	
	// 비밀번호 일치 여부 확인
	@PostMapping("/pwdConfirm")
	public ResponseEntity<String> pwdConfirm(@ModelAttribute UserVO vo, RedirectAttributes ras) {
		log.info("비밀번호 일치 여부 확인");
		ResponseEntity<String> entity = null;
		int result = 0;
		result = clientUserService.pwdConfirm(vo);
		entity = new ResponseEntity<String>(String.valueOf(result), HttpStatus.OK);
		return entity;
	}

}