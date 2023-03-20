package com.spring.client.qna.service;

import java.util.List;

import com.spring.client.qna.vo.QnaVO;

public interface QnaService {
	public List<QnaVO> qnaList(QnaVO qvo);
}
