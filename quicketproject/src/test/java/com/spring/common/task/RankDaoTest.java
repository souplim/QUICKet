package com.spring.common.task;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.spring.client.show.vo.RankVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@SpringBootTest
@Slf4j
public class RankDaoTest {
	
	@Setter(onMethod_=@Autowired)
	private RankDao rankDao;
	
	@Test
	public void inputRankTest() {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date();
		String today = dateFormat.format(now);
		log.info(today);
		
		RankVO vo = new RankVO();
		vo.setRank_start(today);
		vo.setRank_end(today);
		
		List<RankVO> list = rankDao.getRankTicket(vo);
		
		log.info(list.toString());
		
		for(RankVO rank : list) {
			rank.setRank_start(today);
			rank.setRank_end(today);
			int result = rankDao.rankInsert(rank);
			if(result==1) {
				log.info("입력 성공 : "+ rank.toString());
			}else {
				log.info("입력 실패 : "+ rank.toString());
			}
		}
	}

}
