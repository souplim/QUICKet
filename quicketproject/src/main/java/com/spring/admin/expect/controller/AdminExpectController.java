package com.spring.admin.expect.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.admin.expect.service.AdminExpectService;
import com.spring.client.expect.vo.ExpectVO;

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
	 */
	@GetMapping(value="/all/{s_num}", produces=MediaType.APPLICATION_JSON_VALUE)
	public List<ExpectVO> adminExpectList(@RequestParam("s_num") Integer s_num, @ModelAttribute ExpectVO evo, Model model) {
		log.info("admin expectList 호출 성공");
		List<ExpectVO> entity = null;
		entity = adminExpectService.adminExpectList(s_num);
		
		return entity; 
	}
	
	
	/***************************
	 * 댓글 삭제
	 *************************/
	@DeleteMapping(value="/{ex_no}", produces= MediaType.TEXT_PLAIN_VALUE)
	public String adminExpectDelete(@PathVariable("ex_no") int ex_no) throws Exception{
		log.info("expectUpdate 호출 성공");
		log.info("ex_no : " + ex_no);
		
		int result = adminExpectService.adminExpectDelete(ex_no);
		
		
		return (result == 1) ? "SUCCESS" : "FAILURE";
	 }

}
