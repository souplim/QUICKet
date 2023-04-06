package com.spring.client.expect.vo;

import com.spring.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ExpectVO extends CommonVO{
	private int ex_no = 0;
	private String ex_title = "";
	private String ex_content = "";
	private String ex_regdate;
	private String ex_update;
	//private int ex_hit 	= 0;

	private String u_id = "";
	private int s_num = 0;
}
