package com.spring.admin.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.admin.qna.dao.AdminQnaDao;
import com.spring.client.qna.reply.dao.QnaReplyDao;
import com.spring.client.qna.vo.QnaVO;

import lombok.Setter;

@Service
public class AdminQnaServiceImpl implements AdminQnaService {
	@Setter(onMethod_ = @Autowired)
	private AdminQnaDao adminQnaDao;
	
	@Setter(onMethod_ = @Autowired)
	private QnaReplyDao qnaReplyDao;

	// 글 목록 구현
	@Override
	public List<QnaVO> adminQnaList(Integer s_num) {
			List<QnaVO> list = null;
			list = adminQnaDao.adminQnaList(s_num);
			return list;
	}
	
	// 글 상세페이지
	@Override
	public QnaVO adminQnaDetail(QnaVO qvo) {
			QnaVO detail = null;
				
			detail = adminQnaDao.adminQnaDetail(qvo);
			if(detail != null) {
				detail.setQ_content(detail.getQ_content().replaceAll("\n", "<br />")); 
				}
			return detail;
	}
	
	// 전체 레코드수 
	@Override
	public int adminQnaListCnt(QnaVO qvo) {
		return adminQnaDao.adminQnaListCnt(qvo);
	}
	
	@Override
	public int adminQnaDelete(int q_no) {
		int result = 0;
		
		// 댓글 삭제 후 글번호에 해당하는 게시글 삭제
		qnaReplyDao.qnaReplyAdminDelete(q_no);
		result = adminQnaDao.adminQnaDelete(q_no);
		return result;
	}
}
