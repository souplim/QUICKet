package com.spring.admin.comm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.admin.comm.service.AdminCommService;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/comm/*")
@Slf4j
public class AdminCommController {
	
	@Setter(onMethod_ = @Autowired)
	private AdminCommService adminCommService;
	
	@GetMapping("/main")
	public String commMain() {
		log.info("커뮤니티관리 메인 페이지 호출");
		return "admin/comm/main";
	}
}
