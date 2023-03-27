package com.spring.common.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class CommonVO {

	private int pageNum = 0; // 페이지 번호
	private int amount = 0; // 페이지에 보여줄 데이터 수
	
	// 조건 검색 시 사용할 필드(검색대상, 검색단어)
	private String search = "";
	private String keyword = "";
	
	private String search_detail ="";
	
	// 관리자 페이지 - 날짜 검색 시 사용할 필드(시작일, 종료일)
	private String start_date = "";
	private String end_date = "";
	
	public CommonVO() {
		this(1, 10); // 기본 - 1 페이지에 10개 보여줌
	}
	public CommonVO(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
}
