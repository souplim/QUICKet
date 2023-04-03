package com.spring.admin.comm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.admin.comm.service.AdminCommService;
import com.spring.client.show.vo.ShowVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/comm/*")
@Slf4j
public class AdminCommController {
	
	@Setter(onMethod_ = @Autowired)
	private AdminCommService adminCommService;
	
	@GetMapping("/main")
	public String showCommList(@ModelAttribute("showList") ShowVO vo, Model model) {
		log.info("커뮤니티관리 메인페이지 실행");
		
		List<ShowVO> showList = adminCommService.showCommList(vo);
		model.addAttribute("showList",showList);
		
		
		return "admin/comm/main";
	}
}
