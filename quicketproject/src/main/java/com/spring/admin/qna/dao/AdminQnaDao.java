package com.spring.admin.qna.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.qna.vo.QnaVO;

@Mapper
public interface AdminQnaDao {
	public List<QnaVO> adminQnaList(Integer s_num);
	public QnaVO adminQnaDetail(QnaVO qvo);
	public int adminQnaListCnt(QnaVO qvo);
	public int adminQnaDelete(int q_no);
	
	//public int qnaAdminDelete(int q_no);
}