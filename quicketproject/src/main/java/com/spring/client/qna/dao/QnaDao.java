package com.spring.client.qna.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.qna.vo.QnaVO;

@Mapper
public interface QnaDao {
	public List<QnaVO> qnaList(Integer s_num);
	public QnaVO qnaDetail(QnaVO qvo);
	public int qnaListCnt(QnaVO qvo);
	public QnaVO qnaUpdateForm(QnaVO qvo);
	public int qnaInsert(QnaVO qvo);
	public int qnaUpdate(QnaVO qvo);
	public int qnaDelete(QnaVO qvo);
	
	
}
