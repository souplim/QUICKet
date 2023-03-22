package com.spring.client.qna.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.qna.vo.QnaVO;

@Mapper
public interface QnaDao {
	public List<QnaVO> qnaList(QnaVO qvo);
	public int qnaInsert(QnaVO qvo);
	public int qnaUpdate(QnaVO qvo);
	public int qnaDelete(int q_no);

}
