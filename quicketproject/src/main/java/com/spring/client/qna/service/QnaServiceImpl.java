package com.spring.client.qna.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.spring.client.qna.dao.QnaDao;
import com.spring.client.qna.vo.QnaVO;

import lombok.Setter;

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
	

}
