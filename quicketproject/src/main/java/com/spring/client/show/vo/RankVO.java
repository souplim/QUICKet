package com.spring.client.show.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RankVO extends ShowVO{
	private int rank_id 		= 0;
	private String rank_start 	= "";
	private String rank_end 	= "";
	private double rank_ticket 	= 0.0;
	
	//랭킹 받는 변수
	private int rank_rank 		= 0;	//총합 랭킹
	private int rank_genre_rank = 0;	//장르 랭킹
	
	private String rank_regdate = "";
	private String rank_update 	= "";
	
	//랭킹 검색 결과를 반영하기 위한 변수 2개 추가
	private String rank_change	= "";
	
}
