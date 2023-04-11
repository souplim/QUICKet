package com.spring.admin.ticket.dao;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.spring.admin.ticket.vo.HallVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@SpringBootTest
@Slf4j
public class AdminTicketHallMapperTests {

		@Setter(onMethod_=@Autowired)
		private HallDao hallDao;
		
		@Test
		public void testTicketHallList() {
			HallVO hallVO = new HallVO();
			List<HallVO> list = hallDao.hall_list(hallVO);
			for(HallVO vo : list)
				log.info(list.toString());
		
		};
		}

