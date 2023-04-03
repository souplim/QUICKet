package com.spring.client.mypage.vo;

import com.spring.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MypageVO extends CommonVO {
	private int ti_num = 0; // 예매번호
	private String ti_status = ""; // 예매상태
	private String u_id =""; // 회원 아이디
	private String ti_regdate; // 예매 데이터 등록일
	private String ti_update; // 예매 데이터 수정일
	
	private String s_name = ""; // 공연 이름
	private int seat_num = 0; // 예매 좌석 번호
	private String s_opendate; // 공연 시작일
	private String s_closedate; // 공연 종료일
	private String img_name = ""; // 이미지 파일
	private String img_dir = ""; // 이미지 파일
	private String img_type = ""; // 이미지 파일
	private String th_name = ""; // 공연장 이름
	private String hall_id = ""; // 공연홀 아이디
	private String hall_date = ""; // 공연 날짜
	private String hall_turn = ""; // 공연회차
	private String hall_time = ""; // 공연시간
	private int s_price = 0; // 공연 가격
	private String pay_name = ""; // 결제자 이름
	private int pay_amount = 0; // 총결제가격
	
	private int s_num=0; // 공연 번호
	private String b_regidate; // 관심공연 등록일
	private int is_likes = 0; // 찜 상태
	private int likesCount = 0; // 공연 찜 개수
	
	private int q_no=0; // qna 번호
	private String q_title=""; // qna 제목
	private String q_regdate; // qna 등록일
	
	private int r_no=0; // 관람후기 번호
	private String r_title=""; // 관람후기 제목
	private int r_point=0; // 관람후기 별점
	private String r_regdate; // 관람후기 등록일
	
	private String f_category =""; // faq 유형
	private String f_title=""; // faq 질문
	private String f_content=""; // faq 답변
	
	private String c_num=""; // 쿠폰 번호
	private String c_name=""; // 쿠폰 이름
	private int c_discount=0; // 쿠폰 할인율
	private int uc_state=0; // 쿠폰사용여부(0:미사용, 1:사용완료, -1:기간만료)
	private String uc_date; // 쿠폰 발급일
	private String c_regdate=""; // 쿠폰 시작일
	private String c_enddate=""; // 쿠폰 만료일
	private String c_remain=""; // 쿠폰 남은 기간
}
