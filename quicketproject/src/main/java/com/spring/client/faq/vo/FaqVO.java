package com.spring.client.faq.vo;

import com.spring.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode
public class FaqVO extends CommonVO {

	private int    f_no     =0;  //FAQ 글번호
	private String f_category    =""; //FAQ 카테고리 
	private String f_title   =""; //FAQ 제목 
	private String f_content =""; //FAQ 글내용 
	private String f_regdate;        //FAQ 등록일 
	private String f_update;        //FAQ 수정일 	
}





/*



CREATE TABLE REVIEWBOARD (
	r_no	NUMBER(20)		NOT NULL,
	u_id	VARCHAR2(15)		NOT NULL,
	r_title	VARCHAR2(100)		NOT NULL,
	r_content	VARCHAR2(2000)		NOT NULL,
	r_point	NUMBER(20)		NOT NULL,
	r_hit	NUMBER(20)	DEFAULT 0	NOT NULL,
	r_regdate	DATE	DEFAULT SYSDATE	NOT NULL,
	r_update	DATE	DEFAULT SYSDATE	NOT NULL,
	s_num	NUMBER(20)		NOT NULL
);



COMMENT ON COLUMN REVIEWBOARD.r_no IS '관람후기 글번호';
COMMENT ON COLUMN REVIEWBOARD.u_id IS '회원 아이디';
COMMENT ON COLUMN REVIEWBOARD.r_title IS '관람후기 제목';
COMMENT ON COLUMN REVIEWBOARD.r_content IS '관람후기 내용';
COMMENT ON COLUMN REVIEWBOARD.r_point IS '관람후기 별점';
COMMENT ON COLUMN REVIEWBOARD.r_hit IS '관람후기 조회수';
COMMENT ON COLUMN REVIEWBOARD.r_regdate IS '관람후기 등록일';
COMMENT ON COLUMN REVIEWBOARD.r_update IS '관람후기 수정일';
COMMENT ON COLUMN REVIEWBOARD.s_num IS '공연 번호';

*/
