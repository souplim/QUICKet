package com.spring.client.inq.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.inq.vo.InqVO;

@Mapper
public interface InqDao {

	public List<InqVO> inqList(InqVO inqVO); /* 문의 리스트 */
	public int inqListCnt(InqVO inqVO); /* 회원 문의글 수 구현*/
	public int inqInsert(InqVO inqVO); /* 등록 */
	public InqVO inqDetail(int i_num); /* 문의 상세 페이지 */
	public int inqUpdate(InqVO inqVO); /* 문의글 수정 */
	
}
