package com.spring.client.qna.reply.service;

import java.util.List;

import com.spring.client.qna.reply.vo.QnaReplyVO;

public interface QnaReplyService {
	public List<QnaReplyVO> qnaReplyList(Integer q_no);
	public int qnaReplyInsert(QnaReplyVO qrvo) throws Exception;
	public int qnaReplyUpdate(QnaReplyVO qrvo) throws Exception;
	public int qnaReplyDelete(Integer q_r_no) throws Exception;
}
