package com.spring.client.inq.reply.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.inq.reply.vo.InqReplyVO;

@Mapper
public interface InqReplyDao {

	public List<InqReplyVO> inqReplyList(Integer i_num); /* 문의 답변 조회 */
}
