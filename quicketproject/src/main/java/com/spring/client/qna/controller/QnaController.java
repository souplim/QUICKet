package com.spring.client.qna.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.client.expect.vo.ExpectVO;
import com.spring.client.qna.service.QnaService;
import com.spring.client.qna.vo.QnaVO;
import com.spring.client.user.vo.UserVO;
// import com.spring.common.vo.CommonVO;
import com.spring.common.vo.PageDTO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/qna/*")
@SessionAttributes("userLogin")
@Slf4j
public class QnaController {
	
	@Setter(onMethod_ = @Autowired)
	private QnaService qnaService;
	
	//private UserVO userVO;
	
	@RequestMapping(value = "/qnaList")
	public String qnaView() {
		log.info("qna 리스트 화면");
		return "client/qna/qnaList";
	} 
	
	/********************************************
	 * QNA 글 목록 구현하기
	 ***********************************/
	@ResponseBody
	@GetMapping(value="/all/{s_num}", produces=MediaType.APPLICATION_JSON_VALUE)
	public List<QnaVO> qnaList(@PathVariable("s_num") Integer s_num, @ModelAttribute("userLogin") UserVO userVO, @ModelAttribute QnaVO qvo, Model model) {
		log.info("qnaList 호출 성공");
		
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
		
		List<QnaVO> entity = null;
		entity = qnaService.qnaList(s_num);
		
		return entity; 
	}
	
	/*
	@GetMapping("/qnaList")
	public String qnaList(@ModelAttribute("userLogin") UserVO userVO, @ModelAttribute QnaVO qvo, Model model) {
		log.info("qnaList 호출 성공");
		qvo.setS_num(1);
		// 전체 레코드 조회
		List<QnaVO> qnaList = qnaService.qnaList(qvo);
		model.addAttribute("qnaList", qnaList);
		System.out.println(qnaList);
		// 전체 레코드 수
		int total = qnaService.qnaListCnt(qvo);
		model.addAttribute("pageMaker", new PageDTO(qvo, total));
		
		// 리스트 번호 부여를 위한 속성
		int count = total - (qvo.getPageNum()-1) * qvo.getAmount();
		model.addAttribute("count", count);
		
		return "client/qna/qnaList"; 
	} */
	
	/********************************
	 *  글 등록하기
	 ***************************/
	@RequestMapping(value = "/qnaWriteForm")
	public String writeForm(@ModelAttribute("userLogin") UserVO userVO, Model model, RedirectAttributes ras) {
		log.info("qna writeForm 호출 성공");
			return "client/qna/qnaWriteForm";
	}
	
	/*
	@RequestMapping(value = "/qnaInsert", method=RequestMethod.POST)
	public String boardInsert(@ModelAttribute("userLogin") UserVO userVO, @ModelAttribute QnaVO qvo, Model model) throws Exception{
		log.info("qnaInsert 호출 성공");
		
		int result = 0;
		qvo.setU_id(userVO.getU_id());
		qvo.setS_num(1);
		
		String url = "";
	
	
		result = qnaService.qnaInsert(qvo);
		if(result == 1) {
			url = "/qna/qnaList";
		} else {
			url = "/qna/qnaWriteForm";
		}
	
		return "redirect:" + url;
	} */
	
	@ResponseBody
	@PostMapping(value = "/qnaInsert", consumes = "application/json", produces= MediaType.TEXT_PLAIN_VALUE)
	public String qnaInsert(@RequestBody QnaVO qvo, @ModelAttribute("userLogin") UserVO userVO) throws Exception{
		log.info("qnaInsert 호출 성공");
		log.info("QnaVO: " + qvo);
		
		int result = 0;
		qvo.setU_id(userVO.getU_id());
		result = qnaService.qnaInsert(qvo);
		
		//evo.setS_num(1);
		

		return (result==1) ? "SUCCESS" : "FAILURE";
	}
	
	
	/*****************************
	 * 글 상세보기
	 * ****************/
	@RequestMapping(value="/qnaDetail", method=RequestMethod.GET) 
	public String qnaDetail(@ModelAttribute QnaVO qvo, Model model) { 
		log.info("qnaDetail 호출 성공");
		log.info("qvo = "+qvo); 
		
		QnaVO detail = qnaService.qnaDetail(qvo); 
		model.addAttribute("detail", detail);
		
		return "client/qna/qnaDetail";
	}
	
	
	
	/*********************************
	 * 글 수정
	 *****************/
	@RequestMapping(value = "/qnaUpdateForm")
	 public String qnaUpdateForm(@ModelAttribute QnaVO qvo, Model model, @ModelAttribute("userLogin") UserVO userVO) {
		 log.info("qnaUpdateForm 호출 성공");
		 log.info("q_no = " + qvo.getQ_no());
		 
		 QnaVO updateData = qnaService.qnaUpdateForm(qvo);
		 
		 model.addAttribute("updateData", updateData);
		 
		 if(userVO.getU_id() == null) {
			
				return "redirect:/user/login";
			} else {

				 return "client/qna/qnaUpdateForm"; 
			}
	 }
	
	@RequestMapping(value="/qnaUpdate", method=RequestMethod.POST)
	public String qnaUpdate(@ModelAttribute QnaVO qvo) throws Exception{
		log.info("qnaUpdate 호출 성공");
		
		int result = 0;
		String url = "";
		
		result = qnaService.qnaUpdate(qvo);
		
		if(result == 1) {
			url = "/qna/qnaDetail?q_no="+qvo.getQ_no();
		} else {
			url = "/qna/qnaUpdateForm?q_no="+qvo.getQ_no();
		}
		
		return "redirect:"+url;
	}
	
	/********************************************
	 * 글 삭제 구현하기
	 **********************************/
	@RequestMapping(value="/qnaDelete")
	public String qnaDelete(@ModelAttribute QnaVO qvo) throws Exception{
		log.info("qnaDelete 호출 성공");
		log.info("삭제할 글번호: "+qvo.getQ_no());
		
		int result = 0;
		String url = "";
		
		result = qnaService.qnaDelete(qvo); // 이식 기준 위가 준비단계, 아래가 삭제 후 처리 관련
		
		if(result == 1) {
			url = "/qna/qnaList";
		} else {
		url = "/qna/qnaDetail?q_no="+qvo.getQ_no(); 	// 상세페이지가 없으므로 qnaList로 간다 if문 필요X 
		}
		return "redirect:"+url;		
	}
	
	/*************************************************
	 * 글 삭제 전 댓글 개수 
	 ************/
	@ResponseBody
	@RequestMapping(value="/qnaReplyCnt")
	public String qnaReplyCnt(@RequestParam("q_no") int q_no) {
		log.info(("qnaReplyCnt 호출 성공"));
		
		int result = 0;
		result = qnaService.qnaReplyCnt(q_no);
		
		return String.valueOf(result);
	}
	
	@ModelAttribute("userLogin")
	public UserVO userLogin() {
		
		return new UserVO();
	}
}
