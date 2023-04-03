package com.spring.client.expect.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.client.expect.service.ExpectService;
import com.spring.client.expect.vo.ExpectVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/expect/*")
@Slf4j
public class ExpectController {

	@Setter(onMethod_ = @Autowired)
	private ExpectService expectService;
	
	/********************************************
	 * 기대평 글 목록 구현하기
	 ***********************************/
	@RequestMapping("/expectList")
	public String expectList(@ModelAttribute ExpectVO evo, Model model) {
		log.info("expectList 호출 성공");
		
		// 전체 레코드 조회
		List<ExpectVO> expectList = expectService.expectList(evo);
		model.addAttribute("expectList", expectList);
		
		return "client/expect/expectList"; 
	}
	
	/********************************
	 *  글 등록하기
	 ***************************/
	
	
	
	@RequestMapping(value = "/expectInsert", method=RequestMethod.POST)
	public String expectInsert(@ModelAttribute ExpectVO evo, Model model) throws Exception{
		log.info("expectInsert 호출 성공");
		evo.setU_id("user02");
		evo.setS_num("1");
		
		String url = "";
		
		expectService.expectInsert(evo);
		url = "/expect/expectList";
		
	
		return "redirect:" + url;
	}
	
	
	
	/*********************************
	 * 글 수정
	 *****************/
	@RequestMapping(value="/expectUpdate", method=RequestMethod.POST)
	public String expectUpdate(@ModelAttribute ExpectVO evo) throws Exception{
		log.info("expectUpdate 호출 성공");
		
		String url = "";
		
		expectService.expectUpdate(evo);
		
		url = "/expect/expectList";
		
		return "redirect:"+url;
	}
	
	/********************************************
	 * 글 삭제 구현하기
	 **********************************/
	@RequestMapping(value="/expectDelete")
	public String expectDelete(@ModelAttribute ExpectVO evo) throws Exception{
		log.info("expectDelete 호출 성공");
		log.info("삭제할 글번호: "+evo.getEx_no());
		
		String url = "";
		
		expectService.expectDelete(evo); // 이식 기준 위가 준비단계, 아래가 삭제 후 처리 관련
		
		url = "/expect/expectList"; 	// 상세페이지가 없으므로 expectList로 간다 if문 필요X 
		
		return "redirect:"+url;		// redirect: 이동하라는 명령. " "으로 감싼다 String
	}
	
}
