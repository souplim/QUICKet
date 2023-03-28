package com.spring.admin.inq.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.admin.inq.dao.AdminInqDao;
import com.spring.client.inq.reply.vo.InqReplyVO;
import com.spring.client.inq.vo.InqVO;

import lombok.Setter;

@Service
public class AdminInqServiceImpl implements AdminInqService {

	@Setter(onMethod_=@Autowired)
	private AdminInqDao adminInqDao;
	
	// 문의글 목록(검색 기능 추가)
	@Override
	public List<InqVO> inqList(InqVO inqVO) {
		List<InqVO> list = null;
		list = adminInqDao.inqList(inqVO);
		return list;
	}

	// 회원 문의글 삭제
	@Override
	public int inqDelete(Integer i_num) {
		int result = adminInqDao.inqDelete(i_num);
		return result;
	}

	/* 회원 문의글에 답변 등록 */
	@Override
	public int inqReplyInsert(InqReplyVO inqReplyVO) {
		int result = adminInqDao.inqReplyInsert(inqReplyVO);
		return result;
	}

	/* 회원 문의글에 답변 수정 */
	@Override
	public int inqReplyUpdate(InqReplyVO inqReplyVO) {
		int result = adminInqDao.inqReplyUpdate(inqReplyVO);
		return result;
	}

	/* 회원 문의글에 답변 삭제 */
	@Override
	public int inqReplyDelete(Integer i_r_num) {
		int result = adminInqDao.inqReplyDelete(i_r_num);
		return result;
	}

	/* 검색 반영한 회원 문의글 수 구현 */
	@Override
	public int inqListCnt(InqVO inqVO) {
		int count = adminInqDao.inqListCnt(inqVO);
		return count;
	}

}
