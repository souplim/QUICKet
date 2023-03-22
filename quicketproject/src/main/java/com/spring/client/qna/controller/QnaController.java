package com.spring.client.qna.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.client.qna.service.QnaService;
import com.spring.client.qna.vo.QnaVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/qna/*")
@Slf4j
public class QnaController {
	
	@Setter(onMethod_ = @Autowired)
	private QnaService qnaService;
	
	/********************************************
	 * QNA 글 목록 구현하기
	 ***********************************/
	@GetMapping("/qnaList")
	public String qnaList(@ModelAttribute QnaVO qvo, Model model) {
		log.info("qnaList 호출 성공");
		
		// 전체 레코드 조회
		List<QnaVO> qnaList = qnaService.qnaList(qvo);
		model.addAttribute("qnaList", qnaList);
		
		return "client/qna/qnaList"; 
	}
	
	/********************************
	 *  글쓰기 폼 출력하기
	 ***************************/
	@RequestMapping(value = "/writeForm")
	public String writeForm() {
		log.info("qna writeForm 호출 성공");
		return "client/qna/writeForm";
	}
	
	@RequestMapping(value = "/qnaInsert", method=RequestMethod.POST)
	public String boardInsert(@ModelAttribute QnaVO qvo, Model model) throws Exception{
		log.info("qnaInsert 호출 성공");
		
		int result = 0;
		String url = "";
		
		result = qnaService.qnaInsert(qvo);
		if(result == 1) {
			url = "/qna/qnaList";
		} else {
			
			url = "/qna/writeForm";
		}
		
		return "redirect:" + url;
	}
	
	/*****************************************
	 * 글 수정 폼 출력하기
	 ******************************
	@RequestMapping(value = "/updateForm")
	public String updateForm(@ModelAttribute QnaVO qvo, Model model) {
		
		log.info("updateForm 호출 성공");
		log.info("q_no = " + qvo.getQ_no());
		
		QnaVO updateData = qnaService.updateForm(qvo);
		
		model.addAttribute("updateData", updateData);
		return "client/qna/updateForm";
	} /
	
	/*********************************
	 * 글 수정
	 ****************
	
	public String qnaUpdate(@ModelAttribute QnaVO qvo) throws Exception{
		log.info("qnaUpdate 호출 성공");
		
		int result = 0;
		String url = "";
		
		result = qnaService.qnaUpdate(qvo);
		
		if(result == 1) {
			url = "/qna/qnaDetail?q_no="+qvo.getQ_no();
		} else {
			url = "/qna/updateForm?q_no="+qvo.getQ_no();
		}
		return "redirect:"+url;
	}
 */
}
