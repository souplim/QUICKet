package com.spring.client.expect.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class ExpectVO {
	private int ex_no;
	private String ex_content;

	private Date ex_regdate;
	private Date ex_update;
	private String u_id;
	private String s_num;
}
