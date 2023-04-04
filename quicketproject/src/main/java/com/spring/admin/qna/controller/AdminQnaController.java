package com.spring.admin.qna.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.admin.qna.service.AdminQnaService;
import com.spring.client.qna.vo.QnaVO;
import com.spring.common.vo.PageDTO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/qna/*")
@Slf4j
public class AdminQnaController {
	
	@Setter(onMethod_ = @Autowired)
	private AdminQnaService adminQnaService;
	
	/***********************************
	 * 글 목록 구현
	 ******************************************/
	@GetMapping("/qnaAdminList")
	public String qnaList(@ModelAttribute QnaVO qvo, Model model) {
		log.info("admin qnaList 호출 성공");
		int s_num = qvo.getS_num();
		log.info("s_num : " + s_num);
		
		
		// 리스트 조회
		List<QnaVO> qnaList = adminQnaService.qnaList(qvo);
		model.addAttribute("qnaList", qnaList);
		model.addAttribute("s_num", s_num);
		// 전체 레코드수 구현
		int total = adminQnaService.qnaListCnt(qvo);
		model.addAttribute("pageMaker", new PageDTO(qvo, total));
		
		// 리스트 번호 부여를 위한 속성
		int count = total - (qvo.getPageNum()-1) * qvo.getAmount();
		model.addAttribute("count", count);
				
		return "admin/qna/qnaAdminList";
	}
	
	@GetMapping("/qnaAdminDetail")
	public String qnaDetail(@ModelAttribute QnaVO qvo, Model model) {
		log.info("admin qnaDetail 호출 성공");
		int s_num = qvo.getS_num();
		log.info("s_num : " + s_num);
		model.addAttribute("s_num", s_num);
		
		QnaVO detail = adminQnaService.qnaDetail(qvo);
		model.addAttribute("detail",detail);
		
		return "admin/qna/qnaAdminDetail";
	}
	
	@RequestMapping(value="/qnaDelete")
	public String qnaDelete(@ModelAttribute QnaVO qvo) throws Exception{
		log.info("admin qnaDelete 호출 성공");
		log.info("삭제할 글 번호: "+qvo.getQ_no());
		int s_num = qvo.getS_num();
		log.info("s_num : " + s_num);
		
		int result = 0;
		String url = "";
		
		result = adminQnaService.qnaAdminDelete(qvo.getQ_no());
		
		if(result == 1) {
			url = "/admin/qna/qnaAdminList?s_num=" + s_num;
		} 
		return "redirect:"+url;
	}
			
}
