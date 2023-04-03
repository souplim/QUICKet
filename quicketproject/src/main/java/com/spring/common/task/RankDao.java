package com.spring.common.task;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.show.vo.RankVO;

@Mapper
public interface RankDao {
	public List<RankVO> getRankTicket(RankVO vo);
	public int rankInsert(RankVO vo);
}
