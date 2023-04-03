package com.spring.client.inq.reply.vo;

import com.spring.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class InqReplyVO extends CommonVO {
	
	private int i_r_num = 0; // 문의글 답변 번호
	private int i_num = 0; // 문의글 번호
	private String i_r_content = ""; // 문의글 답변 내용
	private String i_r_regidate = ""; // 답변 등록일
	private String i_r_update = ""; // 답변 수정일
}
