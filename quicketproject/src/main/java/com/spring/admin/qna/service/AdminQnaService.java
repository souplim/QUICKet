package com.spring.admin.qna.service;

import java.util.List;

import com.spring.client.qna.vo.QnaVO;

public interface AdminQnaService {
	public List<QnaVO> adminQnaList(QnaVO qvo);
	public QnaVO adminQnaDetail(QnaVO qvo) throws Exception;
	public int adminQnaListCnt(QnaVO qvo) throws Exception;
	public int adminQnaDelete(QnaVO qvo) throws Exception;
	
}
