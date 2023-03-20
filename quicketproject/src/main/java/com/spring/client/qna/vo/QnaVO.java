package com.spring.client.qna.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class QnaVO {
	private String q_no;
	private String q_title;
	private String q_content;
	private Date q_regdate;
	private Date q_update;
	
	private String u_id;
	private String s_num;

}
