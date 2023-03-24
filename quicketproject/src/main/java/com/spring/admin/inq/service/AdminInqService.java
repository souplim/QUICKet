package com.spring.admin.inq.service;

import java.util.List;

import com.spring.client.inq.reply.vo.InqReplyVO;
import com.spring.client.inq.vo.InqVO;

public interface AdminInqService {

	public List<InqVO> inqList(InqVO inqVO); /* 리스트 조회 */

	public List<InqVO> inqCateList(InqVO inqVO); /* 세부 유형으로 조회 */

	public List<InqVO> inqReplyList(InqVO inqVO); /* 답변여부로 조회 */

	public int inqDelete(Integer i_num); /* 회원 문의글 삭제 */

	public int inqReplyInsert(InqReplyVO inqReplyVO); /* 회원 문의글 답변 등록 */

	public int inqReplyUpdate(InqReplyVO inqReplyVO); /* 회원 문의글 답변 수정 */

	public int inqReplyDelete(Integer i_r_num); /* 회원 문의글 답변 삭제 */
}
