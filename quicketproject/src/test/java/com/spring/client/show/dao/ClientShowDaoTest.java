package com.spring.client.show.dao;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.spring.client.show.vo.ImgVO;
import com.spring.client.show.vo.RankVO;
import com.spring.client.show.vo.ShowVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@SpringBootTest
@Slf4j
public class ClientShowDaoTest {
	@Setter(onMethod_=@Autowired)
	private ClientShowDao showDao;

	/*
	@Test
	public void showListTest() {
		log.info("showList 메서드 실행");
		
		ShowVO vo = new ShowVO();
		vo.setS_array("s_name");
		vo.setS_sortorder("asc");
//		vo.setSearch("th_name");
//		vo.setKeyword("예스");
//		vo.setS_region("종로구");
		
		List<ShowVO> result = showDao.showList(vo);
		
		if(result!=null) {
			for(ShowVO show : result) {
				show.setS_posterimg(showDao.posterImg(show));
				log.info(show.getS_name()+" : " +show.getS_point());
				log.info(show.getTh_name());
				if(show.getS_posterimg()!=null) {
					log.info(show.getS_posterimg().toString());
				}
			}
		}else {
			log.info("데이터 출력 실패");
		}
	}
	 */
	
	@Test
	public void rankListTest() {
		log.info("rankList 메서드 실행");
		
		RankVO vo = new RankVO();
		vo.setRank_start("2023-03-13");
		vo.setRank_end("2023-03-19");
		vo.setS_select_genre("뮤지컬");
		List<RankVO> result = showDao.rankList(vo);
		
		if(result!=null) {
			if(!result.isEmpty()) {
				for(RankVO rank : result) {
					log.info(rank.getRank_rank()+"등의 이름은 "+rank.getS_name());
					rank.setS_posterimg(showDao.posterImg(rank));
					if(rank.getS_posterimg()!=null) {
						log.info("포스터 경로 :"+ rank.getS_posterimg().toString());
					}
				}
			}else {
				log.info("데이터가 없습니다.");
			}
		}else {
			log.info("데이터 출력 실패");
		}
	}
	
	/*
	@Test
	public void showDetailTest() {
		log.info("showDetail 메서드 실행");
		
		ShowVO vo = new ShowVO();
		vo.setS_num(1);
		
		ShowVO result = showDao.showDetail(vo);

		if(result!=null) {
			result.setS_posterimg(showDao.posterImg(result));
			result.setS_detailimg(showDao.detailImg(result));
			log.info(result.toString());
		}else {
			log.info("데이터 출력 실패");
		}
	}
	*/
}
