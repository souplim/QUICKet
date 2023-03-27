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
	private int rank_rank 		= 0;
	private String rank_regdate = "";
	private String rank_update 	= "";
}
