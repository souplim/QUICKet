package com.spring.client.qna.reply.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.qna.reply.vo.QnaReplyVO;

@Mapper
public interface QnaReplyDao {
	public List<QnaReplyVO> qnaReplyList(Integer q_no);
	public int qnaReplyInsert(QnaReplyVO qrvo);
	public int qnaReplyUpdate(QnaReplyVO qrvo);
	public int qnaReplyDelete(Integer q_r_no);
	public int qnaReplyAdminDelete(Integer q_no);
	public int qnaReplyCnt(int q_no);
}
