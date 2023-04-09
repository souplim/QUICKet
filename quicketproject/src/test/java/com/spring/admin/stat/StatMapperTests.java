package com.spring.admin.stat;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.spring.admin.statistics.dao.StatDao;
import com.spring.admin.statistics.vo.StatVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@SpringBootTest
@Slf4j
public class StatMapperTests {

	@Setter(onMethod_=@Autowired)
	private StatDao statDao;
	
	/* @Test
	public void testShowTicketCnt() {
		List<StatVO> list = statDao.showTicketCnt();
		for(StatVO vo : list)
			log.info(vo.toString());
	} */
	
	/* @Test
	public void testShowSales() {
		List<StatVO> list = statDao.showSales();
		for(StatVO vo : list)
			log.info(vo.toString());
	} */
	
	/*@Test
	public void testNameList() {
		List<StatVO> nameList = statDao.showList();
		
		for(StatVO vo : nameList)
			log.info(vo.toString());
	} */
	
	@Test
	public void testMonthlySales() {
		List<StatVO> nameList = statDao.showList();
		for(StatVO vo : nameList)
			log.info(vo.toString());
		
		List<StatVO> list = statDao.monthlySales(nameList);
		for(StatVO vo : list)
			log.info(vo.toString());
	}
}
