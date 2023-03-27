package com.spring.admin.theater.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.admin.theater.service.AdminTheaterService;
import com.spring.client.theater.vo.TheaterVO;
import com.spring.common.vo.PageDTO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/theater/*")
public class AdminTheaterController {
	@Setter(onMethod_=@Autowired)
	private AdminTheaterService adminTheaterService;

	@ResponseBody
	@GetMapping(value="/theaterSelectList", produces="application/json; charset=UTF-8")
	public List<TheaterVO> theaterList() {
		log.info("theaterList 메서드 실행");
		
		List<TheaterVO> list = adminTheaterService.theaterSelectList();
		return list;
	}
	 
	@GetMapping("/theaterList")
	public String theaterList(@ModelAttribute TheaterVO vo, Model model) {
		log.info("theaterList 메서드 실행");
		
		List<TheaterVO> theaterList = adminTheaterService.theaterList(vo);
		model.addAttribute("theaterList", theaterList);
		
		int total = adminTheaterService.theaterListCnt(vo);
		model.addAttribute("pageMaker", new PageDTO(vo,total));
		
		return "admin/theater/theaterList";
	}

	@GetMapping("/insertTheater")
	public String genrePage() {
		return "admin/theater/popup/insertTheater";
	}
	
}
