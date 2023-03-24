package com.spring.client.inq.reply.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.client.inq.reply.service.InqReplyService;
import com.spring.client.inq.reply.vo.InqReplyVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping(value="/inqReply")
@Slf4j
public class InqReplyController {
	
	/* private final InqReplyService inqReplyService;
	
	@Autowired
	public InqReplyController(InqReplyService inqReplyService) {
		this.inqReplyService = inqReplyService;
	} */
	
	@Setter(onMethod_=@Autowired)
	private InqReplyService inqReplyService;
	
	/***********************************************************
	 * 문의사항 답변 리스트 조회하기
	 * 현재 요청 URL : http://localhoast:8080/inqReply/all/게시판글번호
	 ***********************************************************/
	@GetMapping(value="/all/{i_num}", produces=MediaType.APPLICATION_JSON_VALUE)
	public List<InqReplyVO> inqReplyList(@PathVariable("i_num") Integer i_num){
		log.info("list 호출 성공");
		
		List<InqReplyVO> inqReplylist = null;
		inqReplylist = inqReplyService.inqReplyList(i_num);
		
		return inqReplylist;
	}
	
}
