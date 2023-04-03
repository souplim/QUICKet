package com.spring.admin.show.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.admin.show.service.AdminShowService;
import com.spring.client.show.vo.ShowVO;
import com.spring.common.vo.PageDTO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/show/*")
public class AdminShowController {
	
	@Setter(onMethod_=@Autowired)
	private AdminShowService adminShowService; 
	
	@GetMapping("/showList")
	public String showList(@ModelAttribute ShowVO vo, Model model) {
		log.info("showList 호출 성공");
		List<ShowVO> showList = adminShowService.showList(vo);
		model.addAttribute("showList", showList);
		
		int total = adminShowService.showListCnt(vo);
		model.addAttribute("pageMaker", new PageDTO(vo,total));
		
		return "admin/show/showList";
	}
	
	@GetMapping("/insertShow")
	public String genrePage() {
		return "admin/show/insertShow";
	}
	
	@PostMapping("/showInsert")
	public String showInsert(@ModelAttribute ShowVO vo, Model model) throws Exception {
		log.info("showInsert 호출 성공");
		
		int result = 0;
		String url = "";
		
		result = adminShowService.showInsert(vo);
		if(result>0) {
			url = "/admin/show/showList";
		}else {
			url = "/admin/show/insertShow";
		}
		return "redirect:"+url;
	}
	
	@GetMapping("/showDetail")
	public String showDetail(@ModelAttribute ShowVO vo, Model model) {
		log.info("showDetail 호출 성공");
		
		ShowVO detail = adminShowService.showDetail(vo);
		model.addAttribute("detail", detail);
		return "admin/show/showDetail";
	}
	
	@GetMapping("/updateShow")
	public String updateShow(@ModelAttribute ShowVO vo, Model model) {
		
		ShowVO updateData = adminShowService.showDetail(vo);
		model.addAttribute("updateData", updateData);
		
		return "admin/show/updateShow";
	}
	
	@PostMapping("/showUpdate")
	public String showUpdate(@ModelAttribute ShowVO vo, Model model) throws Exception {
		log.info("showUpdate 호출 성공");
		
		int result = 0;
		String url = "";
		
		result = adminShowService.showUpdate(vo);
		if(result>0) {
			url = "/admin/show/showDetail?s_num="+vo.getS_num();
		}else {
			url = "/admin/show/updateShow?s_num="+vo.getS_num();
		}
		return "redirect:"+url;
	}
	
	@PostMapping("/showDelete")
	public String showDelete(@ModelAttribute ShowVO vo) throws Exception {
		log.info("showDelete 호출 성공");
		
		int result = 0;
		String url = "";
		
		result = adminShowService.showDelete(vo);
		
		if(result==1) {
			url= "/admin/show/showList";
		}else {
			url="/admin/show/showDetail?s_num="+vo.getS_num();
		}
		return "redirect:"+url;
	}
	
}
