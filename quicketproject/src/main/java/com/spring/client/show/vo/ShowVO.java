<<<<<<< HEAD
package com.spring.client.show.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.common.vo.CommonVO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ShowVO extends CommonVO {
	private int s_num 			= 0; 	//공연번호
	private String s_name 		= "";	//공연명
	private String s_genre 		= ""; 	//공연장르
	private String s_opendate 	= ""; 	//공연시작일
	private String s_closedate 	= ""; 	//공연종료일
	private	int s_time 			= 0; 	//공연상영시간
	private int s_price 		= 0; 	//공연티켓가격
	private String s_director 	= ""; 	//공연기획제작정보
	private String s_sponsor 	= ""; 	//공연주최주관정보
	private String s_actor 		= ""; 	//공연캐스팅배우정보 
	private double s_point 		= 0.0; 	//공연별점평균
	private int s_ticketcnt 	= 0; 	//공연총 예매횟수
	private String s_guide 		= ""; 	//공연안내사항
	
	//공연장 정보 처리 변수
	private int th_num			= 0;	//공연장번호
	private String th_name		= "";	//공연장이름
	
	//데이터 등록일 변수
	private String s_regdate	= "";	//공연데이터등록일
	private String s_update		= "";	//공연데이터수정일
	
	//보유한 이미지파일의 정보 객체 및 리스트
	private ImgVO s_posterimg;			//포스터 이미지파일 데이터
	private List<ImgVO> s_detailimg;	//상세정보 이미지파일 데이터
	private String s_detail_str = "";	//상세정보 이미지파일 리스트를 가공하여 주고받는 필드
	
	//업로드로 받은 이미지파일 데이터
	private MultipartFile s_posterfile;			//업로드할 포스터 이미지파일
	private List<MultipartFile> s_detailfile;	//업로드할 상세정보 이미지파일 리스트
	
	//검색관련변수
	private String s_select_region	= ""; 	//지역선택에 쓸 키워드를 저장하는 변수
	private String s_array			= "";	//정렬이 필요할 경우 조건을 저장하는 변수
	private String s_sortorder		= "";	//정렬이 필요할 경우 순서를 저장하는 변수
	private String s_select_date	= "";	//날짜 검색 기준을 저장하는 변수
	
	//평점 랭킹 변수
	private int s_point_rank		= 0;	//평점 랭킹을 저장하기 위한 변수
	
	//랭킹 기간 검색용 변수
	private String rank_period		= "";	//랭킹 검색시 기간을 체크하기 위한 변수
}
=======
package com.spring.client.show.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.common.vo.CommonVO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper = false)
@AllArgsConstructor
@NoArgsConstructor
public class ShowVO extends CommonVO {
	private int s_num 			= 0; 	//공연번호
	private String s_name 		= "";	//공연명
	private String s_genre 		= ""; 	//공연장르
	private String s_opendate 	= ""; 	//공연시작일
	private String s_closedate 	= ""; 	//공연종료일
	private	int s_time 			= 0; 	//공연상영시간
	private int s_price 		= 0; 	//공연티켓가격
	private String s_director 	= ""; 	//공연기획제작정보
	private String s_sponsor 	= ""; 	//공연주최주관정보
	private String s_actor 		= ""; 	//공연캐스팅배우정보 
	private double s_point 		= 0.0; 	//공연별점평균
	private int s_ticketcnt 	= 0; 	//공연총 예매횟수
	private String s_guide 		= ""; 	//공연안내사항
	
	//공연장 정보 처리 변수
	private int th_num			= 0;	//공연장번호
	private String th_name		= "";	//공연장이름
	
	//데이터 등록일 변수
	private String s_regdate	= "";	//공연데이터등록일
	private String s_update		= "";	//공연데이터수정일
	
	//보유한 이미지파일의 정보 객체 및 리스트
	/*
	private ImgVO s_posterimg;			//포스터 이미지파일 데이터
	private List<ImgVO> s_detailimg;	//상세정보 이미지파일 데이터
	private String s_detail_str = "";	//상세정보 이미지파일 리스트를 가공하여 주고받는 필드
	*/
	//업로드로 받은 이미지파일 데이터
	/*
	private MultipartFile s_posterfile;			//업로드할 포스터 이미지파일
	private List<MultipartFile> s_detailfile;	//업로드할 상세정보 이미지파일 리스트
	*/
	//검색관련변수
	private String s_select_region	= ""; 	//지역선택에 쓸 키워드를 저장하는 변수
	private String s_array			= "";	//정렬이 필요할 경우 조건을 저장하는 변수
	private String s_sortorder		= "";	//정렬이 필요할 경우 순서를 저장하는 변수
	private String s_select_date	= "";	//날짜 검색 기준을 저장하는 변수
	
	//평점 랭킹 변수
	private int s_point_rank		= 0;	//평점 랭킹을 저장하기 위한 변수
	
	
	// 이유빈 추가 (커뮤니티 - 기대평, 관람후기 ,qna 개수)
	private int excount = 0;
	private int rcount = 0;
	private int qcount = 0;
	
}
>>>>>>> branch 'develop' of https://github.com/eunja2/QUICKet.git
