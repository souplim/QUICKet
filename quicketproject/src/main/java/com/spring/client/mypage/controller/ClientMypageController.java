package com.spring.client.mypage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import lombok.extern.slf4j.Slf4j;

@Controller
@SessionAttributes("userLogin")
@RequestMapping("/user/mypage/*")
@Slf4j
public class ClientMypageController {

	@GetMapping("/")
	public String main() {
		log.info("마이페이지 메인 화면 호출");
		return "client/mypage/main";
	}
}
