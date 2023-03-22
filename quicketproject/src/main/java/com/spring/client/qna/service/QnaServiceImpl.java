package com.spring.client.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.client.qna.dao.QnaDao;
import com.spring.client.qna.vo.QnaVO;

import lombok.Setter;

@Service
public class QnaServiceImpl implements QnaService{
	
	@Setter(onMethod_ = @Autowired)
	private QnaDao qnaDao;

	// 글 목록 구현
	@Override
	public List<QnaVO> qnaList(QnaVO qvo) {
		List<QnaVO> list = null;
		list = qnaDao.qnaList(qvo);
		return list;
	}

	@Override
	public int qnaInsert(QnaVO qvo) throws Exception{
		int result = 0;
		
		result = qnaDao.qnaInsert(qvo);
		return result;
	}

	/*
	@Override
	public int qnaUpdate(QnaVO qvo) throws Exception {
		QnaVO updateData = null;
		updateData = qnaDao.qnaDetail(qvo);
		return 0;
	} 

	@Override
	public QnaVO updateForm(QnaVO qvo) {
		// TODO Auto-generated method stub
		return null;
	}
	*/

	

}
