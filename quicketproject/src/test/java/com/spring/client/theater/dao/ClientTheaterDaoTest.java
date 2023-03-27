package com.spring.client.theater.dao;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.spring.client.show.vo.ShowVO;
import com.spring.client.theater.dao.ClientTheaterDao;
import com.spring.client.theater.vo.TheaterVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@SpringBootTest
@Slf4j
public class ClientTheaterDaoTest {
	@Setter(onMethod_=@Autowired)
	private ClientTheaterDao theaterDao;
	
	@Test
	public void theaterListTest() {
		log.info("theaterList 메서드 실행");
		
		ShowVO vo = new ShowVO();
		
		TheaterVO result = theaterDao.theaterOne(vo);
		if(result!=null) {
			log.info(result.toString());
		}else {
			log.info("데이터 출력 실패");
		}
		
	}
}
