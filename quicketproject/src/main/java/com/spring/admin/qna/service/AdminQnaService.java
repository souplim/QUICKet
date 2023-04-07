package com.spring.admin.qna.service;

import java.util.List;

import com.spring.client.qna.vo.QnaVO;

public interface AdminQnaService {
	public List<QnaVO> qnaList(Integer s_num);
	public QnaVO qnaDetail(QnaVO qvo);
	public int qnaListCnt(QnaVO qvo);
	public int qnaAdminDelete(int q_no);
}
