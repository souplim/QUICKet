package com.spring.client.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.client.qna.dao.QnaDao;
import com.spring.client.qna.reply.dao.QnaReplyDao;
import com.spring.client.qna.vo.QnaVO;

import lombok.Setter;

@Service
public class QnaServiceImpl implements QnaService{
	
	@Setter(onMethod_ = @Autowired)
	private QnaDao qnaDao;
	
	@Setter(onMethod_ = @Autowired)
	private QnaReplyDao qnaReplyDao;

	// 글 목록 구현
	@Override
	public List<QnaVO> qnaList(Integer s_num) {
		List<QnaVO> list = null;
		list = qnaDao.qnaList(s_num);
		return list;
	}

	// 글 등록 
	@Override
	public int qnaInsert(QnaVO qvo) throws Exception{
		int result = 0;
		
		result = qnaDao.qnaInsert(qvo);
		return result;
	}
	
	// 글 상세페이지
	@Override
	public QnaVO qnaDetail(QnaVO qvo) {
		QnaVO detail = null;
			
		detail = qnaDao.qnaDetail(qvo);
		if(detail != null) {
			detail.setQ_content(detail.getQ_content().replaceAll("\n", "<br />")); 
			}
		return detail;
	}

			
	
	// 글 수정
	@Override
	public int qnaUpdate(QnaVO qvo) throws Exception {
		int result = 0;

		result = qnaDao.qnaUpdate(qvo);
		return result;
	}
	
	// 글 수정 폼
		@Override
		public QnaVO qnaUpdateForm(QnaVO qvo) {
			QnaVO updateData = null;
			updateData = qnaDao.qnaDetail(qvo);
			return updateData;
		} 


	/* 글 삭제 구현 */
	@Override
	public int qnaDelete(QnaVO qvo) throws Exception {
		int result = 0;
		
		result = qnaDao.qnaDelete(qvo.getQ_no());
		return result;
	}

	// 전체 레코드수 
	@Override
	public int qnaListCnt(QnaVO qvo) {
		return qnaDao.qnaListCnt(qvo);
	}

	
	// 해당 게시글의 댓글 존재 여부 확인
	@Override
	public int qnaReplyCnt(int q_no) {
		int result = 0;
		result = qnaReplyDao.qnaReplyCnt(q_no);
		return result;
	}

}
