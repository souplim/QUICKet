package com.spring.admin.inq.controller;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.admin.inq.service.AdminInqService;
import com.spring.client.inq.reply.service.InqReplyService;
import com.spring.client.inq.reply.vo.InqReplyVO;
import com.spring.client.inq.service.InqService;
import com.spring.client.inq.vo.InqVO;
import com.spring.common.vo.PageDTO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping(value="/admin/inq/*")
@Slf4j
public class AdminInqController {
	
	@Setter(onMethod_=@Autowired)
	private AdminInqService adminInqService;
	
	@Setter(onMethod_=@Autowired)
	private InqService inqService;
	
	@Setter(onMethod_=@Autowired)
	private InqReplyService inqReplyService;
	
	/***********************************************************
	 * 문의사항 리스트 조회하기
	 * 요청 주소 : http://localhost:8080/admin/inq/inqList
	 ***********************************************************/
	@GetMapping(value="/inqList")
	public String inqList(@ModelAttribute("data") InqVO inqVO, Model model) {
		log.info("1대1문의 리스트 화면");
		
		// 회원 아이디 임의로 지정 -> 없애면 페이징 처리시 들어가는 pageNum 전달이 안 돼서 페이지네이션 사라짐...
		//inqVO.setU_id("yubin");
		inqVO.setU_id("user02");
		
		// 회원 문의글 리스트 조회
		List<InqVO> inqList = null;
		
		// 조회(검색 추가)
		if(inqVO.getSearch().equals("i_category")) {
			inqVO.setI_category(inqVO.getSearch_detail());
			
			inqList = adminInqService.inqCateList(inqVO);
		} else if(inqVO.getSearch().equals("i_reply")) {
			// 답변여부 변수 변환
			if(inqVO.getSearch_detail().equals("답변대기중")) inqVO.setI_reply(0);
			else if(inqVO.getSearch_detail().equals("답변완료")) inqVO.setI_reply(1);;
			
			inqList = adminInqService.inqReplyList(inqVO);
		} else
			inqList = adminInqService.inqList(inqVO);
		model.addAttribute("inqList", inqList);
		
		// 페이징 처리
		int total = inqService.inqListCnt(inqVO);
		model.addAttribute("pageMaker", new PageDTO(inqVO, total));
		
		// 리스트 번호 새로 부여
		int count = total - (inqVO.getPageNum()-1) * inqVO.getAmount();
		model.addAttribute("count", count);
		
		return "admin/inq/inqList"; // /WEB-INF/views/admin/inq/inqList.jsp 
	}
	
	/***************************************************************************************
	 * 사용자 문의글 삭제 구현하기
	 * 현재 요청 URL : http://localhost:8080/admin/inq/inqDelete
	 ***************************************************************************************/
	@GetMapping("/inqDelete")
	public String inqDelete(@RequestParam("i_num") int i_num, RedirectAttributes ras) {
		log.info("inqlist 삭제 성공");
		int result = adminInqService.inqDelete(i_num);
		
		if(result!=1) {
			ras.addFlashAttribute("errorMsg","로그인 실패");
		}
		return "redirect:/admin/inq/inqList";
	}
	
	/***********************************************************
	 * 문의사항 세부정보 조회하기
	 * 현재 요청 URL : http://localhost:8080/admin/inq/adminInqDetail/게시판글번호
	 ***********************************************************/
	@ResponseBody
	@PostMapping(value="/adminInqDetail/{i_num}", produces=MediaType.APPLICATION_JSON_VALUE)
	public InqVO adminInqDetail(@PathVariable("i_num") Integer i_num){
		log.info("adminInqDetail 호출 성공");
		
		InqVO inqDetail = null;
		inqDetail = inqService.adminInqDetail(i_num);
		
		return inqDetail;
	}
	
	/***********************************************************
	 * 문의사항 답변 리스트 조회하기
	 * 현재 요청 URL : http://localhoast:8080/admin/inq/inqReply/게시판글번호
	 ***********************************************************/
	@ResponseBody
	@PostMapping(value="/inqReply/{i_num}", produces=MediaType.APPLICATION_JSON_VALUE)
	public List<InqReplyVO> inqReply(@PathVariable("i_num") Integer i_num){
		log.info("inqReply 호출 성공");
		
		List<InqReplyVO> inqReplylist = null;
		inqReplylist = inqReplyService.inqReplyList(i_num);
		
		return inqReplylist;
	} 
	
	/***********************************************************
	 * 문의사항 답변 등록하기
	 * 현재 요청 URL : http://localhost:8080/admin/inq/inqReplyInsert
	 ***********************************************************/
	@ResponseBody
	@PostMapping(value="/inqReplyInsert", consumes="application/json", produces=MediaType.TEXT_PLAIN_VALUE)
	public String inqReplyInsert(@RequestBody InqReplyVO inqReplyVO) {
		log.info("inqReplyInsert()호출");
		log.info("InqRelyVO : "+ inqReplyVO);
		int result = 0;
		
		result = adminInqService.inqReplyInsert(inqReplyVO);
		
		return (result == 1) ? "SUCCESS" : "FAILURE";
	}
	
	/***********************************************************
	 * 문의사항 답변 수정하기
	 * 현재 요청 URL : http://localhost:8080/admin/inq/inqReplyUpdate
	 ***********************************************************/
	@ResponseBody
	@PostMapping(value="/inqReplyUpdate", consumes="application/json", produces=MediaType.TEXT_PLAIN_VALUE)
	public String inqReplyUpdate(@RequestBody InqReplyVO inqReplyVO) {
		log.info("inqReplyUpdate()호출");
		log.info("InqRelyVO : "+ inqReplyVO);
		int result = 0;
		
		result = adminInqService.inqReplyUpdate(inqReplyVO);
		
		return (result == 1) ? "SUCCESS" : "FAILURE";
	}
	
	/***********************************************************
	 * 문의사항 답변 삭제하기
	 * 현재 요청 URL : http://localhost:8080/admin/inq/{게시판댓글번호}
	 ***********************************************************/
	@ResponseBody
	@DeleteMapping(value="/{i_r_num}", produces=MediaType.TEXT_PLAIN_VALUE)
	public String inqReplyDelete(@PathVariable("i_r_num") int i_r_num){
		log.info("inqReplyDelete 호출 성공");
		log.info("i_r_num = "+i_r_num);
		int result = adminInqService.inqReplyDelete(i_r_num);
		return (result==1) ? "SUCCESS" : "FAILURE";
	}
}
