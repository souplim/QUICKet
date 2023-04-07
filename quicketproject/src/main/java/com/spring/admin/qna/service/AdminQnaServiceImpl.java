package com.spring.admin.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.client.qna.dao.QnaDao;
import com.spring.client.qna.reply.dao.QnaReplyDao;
import com.spring.client.qna.vo.QnaVO;

import lombok.Setter;

@Service
public class AdminQnaServiceImpl implements AdminQnaService {
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
	
	// 전체 레코드수 
	@Override
	public int qnaListCnt(QnaVO qvo) {
		return qnaDao.qnaListCnt(qvo);
	}
	
	@Override
	public int qnaAdminDelete(int q_no) {
		int result = 0;
		
		qnaReplyDao.qnaReplyAdminDelete(q_no);
		result = qnaDao.qnaDelete(q_no);
		return result;
	}
	
	
}
