package com.spring.client.qna.vo;

//import java.sql.Date;

import com.spring.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class QnaVO extends CommonVO {
	private int q_no = 0;
	private String q_title = "";
	private String q_content = "";
	private String q_regdate;
	private String q_update;
	private int q_cnt 	= 0;
	
	private String u_id = "";
	private int s_num;

}
