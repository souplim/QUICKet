package com.spring.client.qna.service;

import java.util.List;

import com.spring.client.qna.vo.QnaVO;

public interface QnaService {
	public List<QnaVO> qnaList(QnaVO qvo);
	public QnaVO qnaDetail(QnaVO qvo);
	public int qnaListCnt(QnaVO qvo);
	public QnaVO qnaUpdateForm(QnaVO qvo);
	public int qnaInsert(QnaVO qvo) throws Exception;
	public int qnaUpdate(QnaVO qvo) throws Exception;
	public int qnaDelete(QnaVO qvo) throws Exception;
	public int qnaReplyCnt(int q_no);

}
