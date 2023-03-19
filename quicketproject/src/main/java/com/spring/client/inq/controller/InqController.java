package com.spring.client.inq.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping(value="/inq/*")
@Slf4j
public class InqController {
	
	@GetMapping(value="/inqList")
	public String inqList() {
		log.info("1대1문의 리스트 화면");
		
		return "client/inq/inqList"; // /WEB-INF/views/client/inq/inqList.jsp -> client 폴더 삭제?
	}
}
