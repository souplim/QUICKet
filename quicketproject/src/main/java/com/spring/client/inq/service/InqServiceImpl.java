package com.spring.client.inq.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.client.inq.dao.InqDao;
import com.spring.client.inq.vo.InqVO;

import lombok.Setter;

@Service
public class InqServiceImpl implements InqService {

	@Setter(onMethod_=@Autowired)
	private InqDao inqDao;
	
	// 문의글 목록
	@Override
	public List<InqVO> inqList(InqVO inqVO) {
		List<InqVO> list = null;
		list = inqDao.inqList(inqVO);
		return list;
	}
	
	// 회원 문의글 수 구현
		@Override
		public int inqListCnt(InqVO inqVO) {
			return inqDao.inqListCnt(inqVO);
		}

	// 문의글 등록
	@Override
	public int inqInsert(InqVO inqVO) {
		int result = 0;
		result = inqDao.inqInsert(inqVO);
		return result;
	}
	
	// 문의글 상세정보
	@Override
	public InqVO inqDetail(int i_num) {
		InqVO inqVO = null;
		inqVO = inqDao.inqDetail(i_num);
		return inqVO;
	}

	// 문의글 수정
	@Override
	public int inqUpdate(InqVO inqVO) {
		int result = 0;
		result = inqDao.inqUpdate(inqVO);
		return result;
	}

	// 문의글 상세 (관리자)
	@Override
	public InqVO adminInqDetail(int i_num) {
		InqVO inqVO = null;
		inqVO = inqDao.adminInqDetail(i_num);
		return inqVO;
	}

	
	

}
