package com.spring.client.inq.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.client.inq.service.InqService;
import com.spring.client.inq.vo.InqVO;
import com.spring.common.vo.PageDTO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping(value="/inq/*")
@Slf4j
public class InqController {
	
	@Setter(onMethod_=@Autowired)
	private InqService inqService;
	
	/***********************************************************
	 * 문의사항 리스트 조회하기(검색포함)
	 * 요청 주소 : http://localhost:8080/inq/inqList
	 ***********************************************************/
	@GetMapping(value="/inqList")
	public String inqList(@ModelAttribute InqVO inqVO, Model model) {
		log.info("1대1문의 리스트 화면");
		
		// 회원 아이디 임의로 지정
		inqVO.setU_id("yubin");
		
		// 회원 문의글 리스트 조회
		List<InqVO> inqList = inqService.inqList(inqVO);
		model.addAttribute("inqList", inqList);
		
		// 페이징 처리
		int total = inqService.inqListCnt(inqVO);
		model.addAttribute("pageMaker", new PageDTO(inqVO, total));
		
		// 리스트 번호 새로 부여
		int count = total - (inqVO.getPageNum()-1) * inqVO.getAmount();
		model.addAttribute("count", count);
		
		return "client/inq/inqList"; // /WEB-INF/views/client/inq/inqList.jsp 
	}
	
	/***********************************************************
	 * 문의 등록 폼 출력하기
	 * 요청 주소 : http://localhost:8080/inq/inqWriteForm
	 ***********************************************************/
	@GetMapping(value="/inqWriteForm")
	public String inqWriteForm() {
		log.info("1대1문의 등록 폼");
		
		return "client/inq/inqWriteForm"; // /WEB-INF/views/client/inq/inqWriteForm.jsp 
	}
	
	/***********************************************************
	 * 문의글 등록 구현하기
	 ***********************************************************/
	@PostMapping(value="/inqInsert")
	public String inqInsert(InqVO inqVO, Model model) {
		log.info("1대1문의 등록");
		
		int result = 0;
		String url = "";
		
		// session id로 바꾸기
		String u_id = "yubin";
		inqVO.setU_id(u_id);
		
		result = inqService.inqInsert(inqVO);
		if(result == 1) 
			url ="/inq/inqList";
		else
			url="/inq/writeForm";
		
		return "redirect:"+url; // jsp 페이지로 포워드 하지 않고 매핑 찾음!
	}
	
	/***********************************************************
	 * 문의 상세 페이지 구현하기
	 * 요청 주소 : http://localhost:8080/inq/inqDetail
	 **********************************************************/
	@GetMapping(value="/inqDetail")
	public String inqDetail(@RequestParam("i_num") int i_num, Model model) {
		log.info("1대1문의 상세화면");
		
		InqVO inqDetail = inqService.inqDetail(i_num);
		model.addAttribute("inqDetail", inqDetail);
		return "client/inq/inqDetail"; // /WEB-INF/views/client/inq/inqDetail.jsp 
	}
	
	/***********************************************************
	 * 문의글 수정 구현하기
	 * 요청 주소 : http://localhost:8080/inq/inqUpdate
	 **********************************************************/
	@ResponseBody
	@PostMapping(value="/inqUpdate", consumes="application/json", produces= "text/plain; charset=UTF-8")
	public String inqUpdate(@RequestBody InqVO inqVO) {
		log.info("1대1문의 수정");
		log.info("ReplyVO");
		
		int result = inqService.inqUpdate(inqVO);
		return (result==1) ? "SUCCESS" : "FAILURE";
	}
	
}
