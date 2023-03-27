package com.spring.client.mypage.vo;

import com.spring.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MypageVO extends CommonVO {
	private int ti_num = 0; // 예매번호
	private String seat_date; // 예매한 시간/날짜
	private String ti_status = ""; // 예매상태
	private String u_id =""; // 회원 아이디
	private String ti_regdate; // 예매 데이터 등록일
	private String ti_update; // 예매 데이터 수정일
	
	private String s_name = ""; // 공연 이름
	private int seat_num = 0; // 예매 좌석 번호
	private String s_opendate; // 공연 시작일
	private String s_closedate; // 공연 종료일
	private String img_dir = ""; // 이미지 파일
	private String th_name = ""; // 공연장 이름
	private String hall_id = ""; // 공연홀 아이디
	private String hall_turn = ""; // 공연회차
	private int s_price = 0; // 공연 가격
	private String pay_name = ""; // 결제자 이름
	private int pay_amount = 0; // 총결제가격
	
	private int s_num=0; // 공연 번호
	private String b_regidate; // 관심공연 등록일
	private int is_likes = 0; // 찜 상태
	private int likesCount = 0; // 공연 찜 개수
}
