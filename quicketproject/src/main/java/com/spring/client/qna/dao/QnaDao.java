package com.spring.client.qna.dao;

import java.util.List;

import com.spring.client.qna.vo.QnaVO;

public interface QnaDao {
	public List<QnaVO> qnaList(QnaVO qvo);

}
