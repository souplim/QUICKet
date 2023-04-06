package com.spring.client.expect.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.spring.client.expect.service.ExpectService;
import com.spring.client.expect.vo.ExpectVO;
import com.spring.client.user.vo.UserVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/expect")
@SessionAttributes("userLogin")
@Slf4j
public class ExpectController {

	@Setter(onMethod_ = @Autowired)
	private ExpectService expectService;
	
	@RequestMapping(value="/expectList")
	public String expectView() {
		log.info("기대평 리스트 화면");
		
		return "client/expect/expectList";
	}
	
	/***********************************
	 * 기대평 댓글목록 구현하기
	 ***********************************/
	@ResponseBody
	@GetMapping(value="/all/{s_num}", produces=MediaType.APPLICATION_JSON_VALUE)
	public List<ExpectVO> expectList(@PathVariable("s_num") Integer s_num, @ModelAttribute("userLogin") UserVO userVO, @ModelAttribute ExpectVO evo, Model model) {
		log.info("expectList 호출 성공");
		
		/* 전체 레코드 조회
		List<ExpectVO> expectList = null;
		expectList = expectService.expectList(s_num);
		model.addAttribute("expectList", expectList);
		
		// 전체 레코드 수
		int total = expectService.expectListCnt(evo);
		model.addAttribute("pageMaker", new PageDTO(evo, total));
				
		// 리스트 번호 부여를 위한 속성
		int count = total - (evo.getPageNum()-1) * evo.getAmount();
		model.addAttribute("count", count); */
		
		List<ExpectVO> entity = null;
		entity = expectService.expectList(s_num);
		
		return entity; 
	}
	
	
	/********************************
	 *  댓글 등록하기
	 ***************************/
	@ResponseBody
	@PostMapping(value = "/expectInsert", consumes = "application/json", produces= MediaType.TEXT_PLAIN_VALUE)
	public String expectInsert(@RequestBody ExpectVO evo, @ModelAttribute("userLogin") UserVO userVO) throws Exception{
		log.info("expectInsert 호출 성공");
		log.info("ExpectVO: " + evo);
		
		int result = 0;
		evo.setU_id(userVO.getU_id());
		result = expectService.expectInsert(evo);
		
		//evo.setS_num(1);
		

		return (result==1) ? "SUCCESS" : "FAILURE";
	}
	
	/*****************************
	 * 글 상세보기
	@RequestMapping(value="/expectDetail", method=RequestMethod.GET) 
	public String expectDetail(@ModelAttribute ExpectVO evo, Model model) { 
		log.info("expectDetail 호출 성공");
		log.info("evo = "+evo); 
		
		ExpectVO detail = expectService.expectDetail(evo); 
		model.addAttribute("detail", detail);
		
		return "client/expect/expectDetail";
	}  */
	
	
	/*********************************
	 * 댓글 수정
	 *****************/
	@ResponseBody
	@PutMapping(value = "/{ex_no}", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public String expectUpdate(@PathVariable("ex_no") int ex_no, @RequestBody ExpectVO evo, @ModelAttribute("userLogin") UserVO userVO) throws Exception {
		log.info("expectUpdateForm 호출 성공");
		log.info("ex_no = "+evo.getEx_no());
		
		evo.setEx_no(ex_no);
		int result = expectService.expectUpdate(evo);
		
		return result == 1 ? "SUCCESS" : "FAILURE";
	}
	
	/***************************
	 * 댓글 삭제
	 *************************/
	@ResponseBody
	@DeleteMapping(value="/{ex_no}", produces= MediaType.TEXT_PLAIN_VALUE)
	public String expectDelete(@PathVariable("ex_no") int ex_no, @ModelAttribute("userLogin") UserVO userVO) throws Exception{
		log.info("expectUpdate 호출 성공");
		log.info("ex_no : " + ex_no);
		
		int result = expectService.expectDelete(ex_no);
		
		
		return (result == 1) ? "SUCCESS" : "FAILURE";
	 }
	
}
