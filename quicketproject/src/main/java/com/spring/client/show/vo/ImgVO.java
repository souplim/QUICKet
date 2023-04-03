package com.spring.client.show.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ImgVO {
	private int img_id 			= 0;	//파일id
	private String img_name 	= "";	//파일명
	private String img_dir		= "";	//파일경로
	private String img_type 	= "";	//확장자
	private int img_size 		= 0;	//파일크기
	private String img_regdate 	= "";	//등록일
	private String img_update 	= "";	//수정일
	
	//외래키
	private int s_num = 0;
	
}
