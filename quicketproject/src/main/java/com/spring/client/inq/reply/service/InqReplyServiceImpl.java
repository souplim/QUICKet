package com.spring.client.inq.reply.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.client.inq.reply.dao.InqReplyDao;
import com.spring.client.inq.reply.vo.InqReplyVO;

import lombok.Setter;

@Service
public class InqReplyServiceImpl implements InqReplyService {

	@Setter(onMethod_=@Autowired)
	private InqReplyDao inqReplyDao;
	
	/* 답변 조회 */
	@Override
	public List<InqReplyVO> inqReplyList(Integer i_num) {
		List<InqReplyVO> list = inqReplyDao.inqReplyList(i_num);
		return list;
	}

}
