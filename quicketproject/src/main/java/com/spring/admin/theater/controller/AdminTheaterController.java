package com.spring.admin.theater.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.admin.theater.service.AdminTheaterService;
import com.spring.client.show.vo.ShowVO;
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
	public String insertTheater() {
		return "admin/theater/popup/insertTheater";
	}
	
	@ResponseBody
	@PostMapping("/theaterInsert")
	public String theaterInsert(@RequestBody TheaterVO vo) throws Exception {
		log.info("theaterInsert 호출 성공");
		log.info("vo : " + vo);
		int result = 0;
		
		result = adminTheaterService.theaterInsert(vo);
		return (result==1)?"SUCCESS":"FAILURE";
	}
	
	@GetMapping("/updateTheater")
	public String updateTheater(@ModelAttribute TheaterVO vo, Model model) {
		TheaterVO updateData = adminTheaterService.theaterOne(vo);
		model.addAttribute("updateData", updateData);
		return "admin/theater/popup/updateTheater";
	}
	
	@ResponseBody
	@PostMapping("/theaterUpdate")
	public String theaterUpdate(@RequestBody TheaterVO vo) throws Exception {
		log.info("theaterUpdate 호출 성공");
		log.info("vo : " + vo);
		int result = 0;
		
		result = adminTheaterService.theaterUpdate(vo);
		return (result==1)?"SUCCESS":"FAILURE";
	}
	
	
	@GetMapping("/theaterMap")
	public String theaterMap(@ModelAttribute TheaterVO vo, Model model) {
		log.info("theaterMap 호출 성공");
		log.info("vo : " + vo);
		
		TheaterVO theaterVO = adminTheaterService.theaterOne(vo);
		model.addAttribute("theaterVO", theaterVO);
		
		return "admin/theater/popup/theaterMap";
	}
	
	@ResponseBody
	@PostMapping("/theaterDelete")
	public String theaterDelete(@RequestBody TheaterVO vo) {
		log.info("theaterDelete 메서드 실행");
		log.info("vo : " + vo);
		
		int result = 0;
		result = adminTheaterService.theaterDelete(vo);

		return (result==1)?"SUCCESS":(result==500)?"CANCELED":"FAILURE";
	}
	
	
}
