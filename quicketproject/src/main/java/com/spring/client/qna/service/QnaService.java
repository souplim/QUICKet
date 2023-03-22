package com.spring.client.qna.service;

import java.util.List;

import com.spring.client.qna.vo.QnaVO;

public interface QnaService {
	public List<QnaVO> qnaList(QnaVO qvo);
	public int qnaInsert(QnaVO qvo) throws Exception;
	//public int qnaUpdate(QnaVO qvo) throws Exception;
	//public QnaVO updateForm(QnaVO qvo);
}
