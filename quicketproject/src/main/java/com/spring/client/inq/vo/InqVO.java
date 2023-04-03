package com.spring.client.inq.vo;

import com.spring.common.vo.CommonVO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(callSuper=false)
public class InqVO extends CommonVO {
	
	private int i_num = 0; // 문의글 번호
	private String u_id = ""; // 회원 아이디
	private String i_category = ""; // 유형
	private String i_cate_detail = ""; // 세부유형
	private int i_reply = 0; // 답변여부
	private String i_title = ""; // 문의글 제목
	private String i_content = ""; // 문의글 내용
	private String i_regidate; // 등록일
	private String i_update; // 수정일
	private int ti_num; // 예매번호
	
	private String u_name = ""; // 회원 이름
}
