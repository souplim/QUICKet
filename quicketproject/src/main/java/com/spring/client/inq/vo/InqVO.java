package com.spring.client.inq.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class InqVO {
	private int i_num; // 문의글 번호
	private String u_id; // 회원 아이디
	private String i_category; // 유형
	private String i_cate_detail; // 세부유형
	private String i_title; // 답변 제목
	private String i_content; // 답변 내용
	private String i_regidate; // 등록일
	private String i_update; // 수정일
	private String ti_num; // 예매번호
}
