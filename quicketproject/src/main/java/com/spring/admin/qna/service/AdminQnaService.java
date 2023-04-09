package com.spring.admin.qna.service;

import java.util.List;

import com.spring.client.qna.vo.QnaVO;

public interface AdminQnaService {
	public List<QnaVO> adminQnaList(Integer s_num);
	public QnaVO adminQnaDetail(QnaVO qvo);
	public int adminQnaListCnt(QnaVO qvo);
	public int adminQnaDelete(int q_no);
	
}
