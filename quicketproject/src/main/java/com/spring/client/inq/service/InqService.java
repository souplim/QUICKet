package com.spring.client.inq.service;

import java.util.List;

import com.spring.client.inq.vo.InqVO;

public interface InqService {
	
	public List<InqVO> inqList(InqVO inqVO); /* 리스트 조회 */
	public int inqListCnt(InqVO inqVO); /* 회원 문의글 수 구현 */
	public int inqInsert(InqVO inqVO); /* 등록 */
	public InqVO inqDetail(int i_num); /* 상세 페이지 */
	public int inqUpdate(InqVO inqVO); /* 수정 */
	
}
