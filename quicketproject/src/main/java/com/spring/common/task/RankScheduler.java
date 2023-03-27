package com.spring.common.task;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class RankScheduler {
	@Setter(onMethod_=@Autowired)
	private RankDao rankDao;
	
	@Scheduled(cron = "0 0 0 * * *")
	public void countRateDay() {
		log.info("일간 랭킹 집계 스케줄러 로드됨");
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar day = Calendar.getInstance();
		day.add(Calendar.DATE, -1);
		String rank_date = dateformat.format(day.getTime());
		
	}
	
	@Scheduled(cron = "0 0 0 ? * MON")
	public void countRateWeek() {
		log.info("주간 랭킹 집계 스케줄러 로드됨");
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar startday = Calendar.getInstance();
		Calendar endday = Calendar.getInstance();
		startday.add(Calendar.DATE, -7);
		endday.add(Calendar.DATE, -1);
		String rank_start = dateformat.format(startday.getTime());
		String rank_end = dateformat.format(endday.getTime());
		
	}
	
	@Scheduled(cron = "0 0 0 1 * ?")
	public void countRateMonth() {
		log.info("월간 랭킹 집계 스케줄러 로드됨");
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar startday = Calendar.getInstance();
		Calendar endday = Calendar.getInstance();
		startday.add(Calendar.MONTH, -1);
		endday.add(Calendar.DATE, -1);
		String rank_start = dateformat.format(startday.getTime());
		String rank_end = dateformat.format(endday.getTime());
	}
	
	@Scheduled(cron = "0 0 0 1 1 ?")
	public void countRateYear() {
		log.info("연간 랭킹 집계 스케줄러 로드됨");
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar startday = Calendar.getInstance();
		Calendar endday = Calendar.getInstance();
		startday.add(Calendar.YEAR, -1);
		endday.add(Calendar.DATE, -1);
		String rank_start = dateformat.format(startday.getTime());
		String rank_end = dateformat.format(endday.getTime());		
	}
	
	

}
