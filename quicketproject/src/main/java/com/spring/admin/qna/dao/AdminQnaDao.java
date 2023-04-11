package com.spring.admin.qna.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.qna.vo.QnaVO;

@Mapper
public interface AdminQnaDao {
	public List<QnaVO> adminQnaList(QnaVO qvo);
	public QnaVO adminQnaDetail(QnaVO qvo) throws Exception;
	public int adminQnaListCnt(QnaVO qvo) throws Exception;
	public int adminQnaDelete(QnaVO qvo) throws Exception;
	
	//public int qnaAdminDelete(int q_no);
}