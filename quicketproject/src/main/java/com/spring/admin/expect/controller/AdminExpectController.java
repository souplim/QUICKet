package com.spring.admin.expect.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.admin.expect.service.AdminExpectService;
import com.spring.client.expect.vo.ExpectVO;
//import com.spring.client.qna.vo.QnaVO;
import com.spring.common.vo.PageDTO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/expect/*")
@Slf4j
public class AdminExpectController {

	@Setter(onMethod_ = @Autowired)
	private AdminExpectService adminExpectService;
	
	/***********************
	 * 글 목록 구현
	@GetMapping(value="/all/{s_num}", produces=MediaType.APPLICATION_JSON_VALUE)
	public List<ExpectVO> adminExpectList(@RequestParam("s_num") Integer s_num, @ModelAttribute ExpectVO evo, Model model) {
		log.info("admin expectList 호출 성공");
		List<ExpectVO> entity = null;
		entity = adminExpectService.adminExpectList(s_num);
		
		return entity; 
	}  */
	
	@GetMapping("/adminExpectList")
	public String expectList(@ModelAttribute ExpectVO evo, Model model) throws Exception{
		log.info("admin expectList 호출 성공");
		int s_num = evo.getS_num();
		log.info("s_num : " + s_num);
		
		
		// 리스트 조회
		List<ExpectVO> expectList = adminExpectService.adminExpectList(evo);
		model.addAttribute("expectList", expectList);
		model.addAttribute("s_num", s_num);
		
		// 전체 레코드수 구현
		int total = adminExpectService.adminExpectListCnt(evo);
		model.addAttribute("pageMaker", new PageDTO(evo, total));
		
		// 리스트 번호 부여를 위한 속성
		int count = total - (evo.getPageNum()-1) * evo.getAmount();
		model.addAttribute("count", count);
				
		return "admin/expect/adminExpectList";
	}
	
	@GetMapping("/adminExpectDetail")
	public String adminExpectDetail(@ModelAttribute ExpectVO evo, Model model) throws Exception {
		log.info("admin expectDetail 호출 성공");
		int s_num = evo.getS_num();
		log.info("s_num : " + s_num);
		model.addAttribute("s_num", s_num);
		
		ExpectVO detail = adminExpectService.adminExpectDetail(evo);
		model.addAttribute("detail",detail);
		
		return "admin/expect/adminExpectDetail";
	}
	
	
	
	/***************************
	 * 댓글 삭제
	 **********************
	@DeleteMapping(value="/{ex_no}", produces= MediaType.TEXT_PLAIN_VALUE)
	public String expectDelete(@PathVariable("ex_no") int ex_no) throws Exception{
		log.info("expectDelete 호출 성공");
		log.info("ex_no : " + ex_no);
		
		int result = adminExpectService.expectDelete(ex_no);
		
		
		return (result == 1) ? "SUCCESS" : "FAILURE";
	 } ***/
	
	
	@RequestMapping(value="/adminExpectDelete")
	public String qnaDelete(@ModelAttribute ExpectVO evo) throws Exception{
		log.info("admin expectDelete 호출 성공");
		log.info("삭제할 글 번호: "+evo.getEx_no());
		int s_num = evo.getS_num();
		log.info("s_num : " + s_num);
		
		int result = 0;
		String url = "";
		

		result = adminExpectService.adminExpectDelete(evo.getEx_no());
		
		if(result == 1) {
			url = "/admin/expect/adminExpectList?s_num=" + s_num;
		} 
		return "redirect:"+url;
	}
	

}
