package com.spring.client.faq.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import com.spring.client.faq.service.FaqService;
import com.spring.client.faq.vo.FaqVO;
import com.spring.common.vo.PageDTO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequestMapping("/faq/*") //매핑 바꾸면 jsp 다 바꿔야 함
@Slf4j
public class FaqController {
	
	@Setter(onMethod_=@Autowired)
	private FaqService faqService;
	
	
	/**************************************************************
	* 글목록 구현하기(페이징 처리 목록 조회)
	**************************************************************/
	
	@RequestMapping(value="/faqList", method = RequestMethod.GET)
	//@GetMapping("/faqList")
	public String faqList(@ModelAttribute("data") FaqVO fvo, Model model) throws Exception {
		log.info("faqList 호출 성공");
	// 전체 레코드 조회
	List<FaqVO> faqList = faqService.faqList(fvo);
	model.addAttribute("faqList", faqList);
	
	// 전체 레코드수 구현
//	int total = boardService.boardListCnt(bvo);
	
	int total = 10;
	// 페이징 처리
	model.addAttribute("pageMaker", new PageDTO(fvo, total));
	return "client/faq/faqList";   //리턴해 주는게 뷰의 정보
	}



	/**************************************************************
	 * faq 상세보기 구현
	 **************************************************************/
	@RequestMapping(value="/faqDetail", method=RequestMethod.GET)
	//@GetMapping("/faqDetail")
	public String faqDetail(@ModelAttribute FaqVO fvo, Model model) {
		log.info("faqDetail 호출 성공");		
		log.info("fvo = " + fvo);
		
		FaqVO detail = faqService.faqDetail(fvo);
		model.addAttribute("detail", detail);
		
		return "client/faq/faqDetail";
	}
    
	
	
	
}	
	