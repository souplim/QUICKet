package com.spring.client.qna.reply.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class QnaReplyVO {
	private int q_no = 0;
	private int q_r_no = 0;
	private String q_r_content = "";
	private Date q_r_regdate;
	private Date q_r_update;
	private String u_id = "";
}
