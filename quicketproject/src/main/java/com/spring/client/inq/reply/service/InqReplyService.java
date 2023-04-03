package com.spring.client.inq.reply.service;

import java.util.List;

import com.spring.client.inq.reply.vo.InqReplyVO;

public interface InqReplyService {

	public List<InqReplyVO> inqReplyList(Integer i_num); /* 문의 답변 조회 */

}
