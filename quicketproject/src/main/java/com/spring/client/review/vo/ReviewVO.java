<<<<<<< HEAD
package com.spring.client.review.vo;

import com.spring.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode
public class ReviewVO extends CommonVO {
   
   private int    r_no     =0;  //관람후기 글번호   
   private String u_id    =""; //회원 아이디
   private String r_title   =""; //관람후기 제목
   private String r_content =""; //관람후기 내용
   private int r_point = 0;        //관람후기 별점
   private int r_hit  = 0;        //관람후기 조회수
   private String r_regdate  ="";        //관람후기 등록일
   private String r_update  ="";        //관람후기 수정일
   private int s_num = 0 ;        //공연 번호   
   private String s_name =""; //공연명
   private String u_name =""; //고객명


} ;
=======
package com.spring.client.review.vo;

import com.spring.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode
public class ReviewVO extends CommonVO {
	
	private int    r_no     =0;  //관람후기 글번호	
	private String u_id    =""; //회원 아이디
	private String r_title   =""; //관람후기 제목
	private String r_content =""; //관람후기 내용
	private int r_point = 0;        //관람후기 별점
	private int r_hit  = 0;        //관람후기 조회수
	private String r_regdate  ="";        //관람후기 등록일
	private String r_update  ="";        //관람후기 수정일
	private int s_num = 0 ;        //공연 번호	
	private String s_name =""; //공연명
	private String u_name =""; //고객명


} ;


>>>>>>> branch 'develop' of https://github.com/eunja2/QUICKet.git
