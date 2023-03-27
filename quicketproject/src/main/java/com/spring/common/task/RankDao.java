package com.spring.common.task;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.show.vo.RankVO;

@Mapper
public interface RankDao {
	public RankVO countTicketRate(RankVO vo);
}
