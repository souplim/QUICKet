package com.spring.client.qna.reply.controller;

import org.springframework.http.MediaType;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.spring.client.qna.reply.service.QnaReplyService;
import com.spring.client.qna.reply.vo.QnaReplyVO;
import com.spring.client.user.vo.UserVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/qnaReply")
@SessionAttributes("userLogin")
@Slf4j
public class QnaReplyController {

	@Setter(onMethod_ = @Autowired)
	private QnaReplyService qnaReplyService;
	
	
	/************************************
	 * QNAReply 댓글 목록 구현
	 */
	@GetMapping(value="/all/{q_no}", produces = MediaType.APPLICATION_JSON_VALUE)
	public List<QnaReplyVO> qnaReplyList(@PathVariable("q_no") Integer q_no, @ModelAttribute("userLogin") UserVO userVO) {
		log.info("qnaReply List 호출 성공");
		
		// 전체 레코드 조회
		List<QnaReplyVO> entity = null;
		entity = qnaReplyService.qnaReplyList(q_no);
		
		return entity;
	}
	
	/**********************************
	 * 댓글 등록하기
	 */

	@PostMapping(value = "/qnaReplyInsert", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public String qnaReplyInsert(@RequestBody QnaReplyVO qrvo, @ModelAttribute("userLogin") UserVO userVO) throws Exception {	
		log.info("qnaReplyInsert 호출 성공");
		log.info("qnaReplyVO : "+qrvo);
		int result = 0;
		qrvo.setU_id(userVO.getU_id());
		
		result = qnaReplyService.qnaReplyInsert(qrvo);
		return (result==1) ? "SUCCESS": "FAILURE";
	}
	
	/*********************************
	 * 댓글 수정
	 *****************/	
	@PutMapping(value="/{q_r_no}", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE) 
	public String replyUpdate(@PathVariable("q_r_no") int q_r_no, @RequestBody QnaReplyVO qrvo, @ModelAttribute("userLogin") UserVO userVO) throws Exception{	// 댓글 번호 추출해 내야함 
		log.info("replyUpdate 호출 성공");
		
		qrvo.setQ_r_no(q_r_no); // rvo.setR_num : rvo에 답글번호 설정
		int result = qnaReplyService.qnaReplyUpdate(qrvo);
		
		return result==1 ? "SUCCESS": "FAILURE";
	} 
	
	/********************************************
	 * 댓글 삭제 구현하기
	 **********************************/
	@DeleteMapping(value = "/{q_r_no}", produces= MediaType.TEXT_PLAIN_VALUE)
	public String replyDelete(@PathVariable("q_r_no") int q_r_no, @ModelAttribute("userLogin") UserVO userVO) throws Exception{
		log.info("qnaReplyDelete 호출 성공");
		log.info("q_r_no = " + q_r_no);
		
		int result = qnaReplyService.qnaReplyDelete(q_r_no);
		return (result==1) ? "SUCCESS": "FAILURE";
	}
	
	@ModelAttribute("userLogin")
	public UserVO userLogin() {
		return new UserVO();
	}
	
}
