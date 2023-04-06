package com.spring.client.theater.vo;

import com.spring.common.vo.CommonVO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TheaterVO extends CommonVO {
	private int th_num 			= 0; 	//공연장번호
	private String th_name 		= "";	//공연장명
	private String th_addr 		= ""; 	//공연장 주소
	private double th_map_lat 	= 0; 	//공연장 지도상 위도
	private double th_map_lng 	= 0;  	//공연장 지도상 경도
	private String th_web 		= ""; 	//공연장 홈페이지 주소

	
	private String th_regdate	= "";	//공연데이터등록일
	private String th_update		= "";	//공연데이터수정일
	
	//검색관련변수
	private String th_array		= "";	//정렬이 필요할 경우 조건을 저장하는 변수
	private String th_sortorder	= "";	//정렬이 필요할 경우 순서를 저장하는 변수
}
