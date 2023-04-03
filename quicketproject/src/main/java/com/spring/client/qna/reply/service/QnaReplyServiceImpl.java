package com.spring.client.qna.reply.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.client.qna.reply.dao.QnaReplyDao;
import com.spring.client.qna.reply.vo.QnaReplyVO;

import lombok.Setter;

@Service
public class QnaReplyServiceImpl implements QnaReplyService{
	
	@Setter(onMethod_ = @Autowired)
	private QnaReplyDao qnaReplyDao;

	// 댓글 목록 구현
	@Override
	public List<QnaReplyVO> qnaReplyList(Integer q_no) {
		List<QnaReplyVO> list = null;
		list = qnaReplyDao.qnaReplyList(q_no);
		return list;
	}

	// 댓글 입력
	@Override
	public int qnaReplyInsert(QnaReplyVO qrvo) throws Exception {
		int result = 0;
		result = qnaReplyDao.qnaReplyInsert(qrvo);
		return result;
	}

	/* 댓글 수정 구현 */
	@Override
	public int qnaReplyUpdate(QnaReplyVO qrvo) throws Exception {
		int result = 0;
		result = qnaReplyDao.qnaReplyUpdate(qrvo);
		return result;
	}

	/* 댓글 삭제 구현 */
	@Override
	public int qnaReplyDelete(Integer q_r_no) throws Exception {
		int result = 0;
		result = qnaReplyDao.qnaReplyDelete(q_r_no);
		return result;
	}
	
	
	
	
	
}
