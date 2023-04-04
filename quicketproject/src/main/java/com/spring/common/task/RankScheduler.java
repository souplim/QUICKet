package com.spring.common.task;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.spring.client.show.vo.RankVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class RankScheduler {
	@Setter(onMethod_=@Autowired)
	private RankDao rankDao;
	
	public ArrayList<String> getDate() {
		//날짜 객체 생성
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar now = Calendar.getInstance();
		
		Calendar day = (Calendar)now.clone();
		day.add(Calendar.DAY_OF_MONTH, -1);
		String yesterday = dateFormat.format(day.getTime());
		
		//일~토 기준으로 월~일 기준으로 변환
		Calendar week = (Calendar)now.clone();
		int day_of_week = Calendar.DAY_OF_WEEK;
		if(day_of_week==1) {
			week.add(Calendar.DAY_OF_WEEK,-6);
		}else{
			week.set(Calendar.DAY_OF_WEEK,2);
		}
		//이번주 월요일
		String monday = dateFormat.format(week.getTime());
		week.add(Calendar.DAY_OF_MONTH, 6);
		//이번주 일요일
		String sunday = dateFormat.format(week.getTime());
		//저번주 일요일
		week.add(Calendar.DAY_OF_MONTH, -7);
		String prev_sunday = dateFormat.format(week.getTime());
		//저번주 월요일
		week.add(Calendar.DAY_OF_MONTH, -6);
		String prev_monday = dateFormat.format(week.getTime());
		
		//저번달 1일~말일
		Calendar month = (Calendar)now.clone();
		month.add(Calendar.MONTH,-1);
		month.set(Calendar.DAY_OF_MONTH, 1);
		String prev_month_start = dateFormat.format(month.getTime());
		month.set(Calendar.DAY_OF_MONTH, month.getActualMaximum(Calendar.DAY_OF_MONTH));
		String prev_month_end = dateFormat.format(month.getTime());
		
		//작년 1일~말일
		Calendar year = (Calendar)now.clone();
		year.add(Calendar.YEAR, -1);
		year.set(Calendar.DAY_OF_YEAR, 1);
		String prev_year_start = dateFormat.format(year.getTime());
		year.set(Calendar.DAY_OF_YEAR, year.getActualMaximum(Calendar.DAY_OF_YEAR));
		String prev_year_end = dateFormat.format(year.getTime());
		
		ArrayList<String> list = new ArrayList<String>();
		list.add(monday);			//[0]: 이번주 월요일
		list.add(sunday);			//[1]: 이번주 일요일
		list.add(yesterday);		//[2]: 어제
		list.add(prev_monday);		//[3]: 저번주 월요일
		list.add(prev_sunday);		//[4]: 저번주 일요일
		list.add(prev_month_start);	//[5]: 저번달 1일
		list.add(prev_month_end);	//[6]: 저번달 말일
		list.add(prev_year_start);	//[7]: 작년 1일
		list.add(prev_year_end);	//[8]: 작년 말일
		
		return list;
	}
	
	@Scheduled(cron = "0 0 0 * * *")
	public void countRateDay() {
		log.info("일간 랭킹 집계 스케줄러 로드됨");
		ArrayList<String> datelist = getDate();	//날짜를 받아와야 데이터를 받아올 수 있음
		
		RankVO vo = new RankVO();
		vo.setRank_start(datelist.get(2));	//어제 날짜 입력
		vo.setRank_end(datelist.get(2));
		
		List<RankVO> list = rankDao.getRankTicket(vo);
		
		int suc = 0;
		int fal = 0;
		if(list != null && !list.isEmpty()) {
			for(RankVO rank : list) {
				rank.setRank_start(datelist.get(2));
				rank.setRank_end(datelist.get(2));
				int result = rankDao.rankInsert(rank);
				if(result==1) {
					suc++;
				}else {
					fal++;
				}
			}
			log.info(datelist.get(2)+" : 일간 랭킹 입력 완료 (성공: "+suc+",실패: "+fal+")");
		}

	} 
	
	@Scheduled(cron = "0 0 0 ? * MON")
	public void countRateWeek() {
		log.info("주간 랭킹 집계 스케줄러 로드됨");
		ArrayList<String> datelist = getDate();	//날짜를 받아와야 데이터를 받아올 수 있음
		
		RankVO vo = new RankVO();
		vo.setRank_start(datelist.get(3));	//저번주 월요일 날짜 입력
		vo.setRank_end(datelist.get(4));	//저번주 일요일 날짜 입력
		
		List<RankVO> list = rankDao.getRankTicket(vo);
		int suc = 0;
		int fal = 0;
		if(list != null && !list.isEmpty()) {
			for(RankVO rank : list) {
				rank.setRank_start(datelist.get(3));
				rank.setRank_end(datelist.get(4));
				int result = rankDao.rankInsert(rank);
				if(result==1) {
					suc++;
				}else {
					fal++;
				}
			}
			log.info(datelist.get(3)+" ~ "+datelist.get(4)+" : 주간 랭킹 입력 완료(성공: "+suc+",실패: "+fal+")");
		}
	}
	
	@Scheduled(cron = "0 0 0 1 * ?")
	public void countRateMonth() {
		log.info("월간 랭킹 집계 스케줄러 로드됨");
		ArrayList<String> datelist = getDate();	//날짜를 받아와야 데이터를 받아올 수 있음
		
		RankVO vo = new RankVO();
		vo.setRank_start(datelist.get(5));	//저번달 1일 날짜 입력
		vo.setRank_end(datelist.get(6));	//저번달 말일 날짜 입력
		
		List<RankVO> list = rankDao.getRankTicket(vo);
		int suc = 0;
		int fal = 0;
		if(list != null && !list.isEmpty()) {		
			for(RankVO rank : list) {
				rank.setRank_start(datelist.get(5));
				rank.setRank_end(datelist.get(6));
				int result = rankDao.rankInsert(rank);
				if(result==1) {
					suc++;
				}else {
					fal++;
				}
			}
			log.info(datelist.get(5)+" ~ "+datelist.get(6)+" : 월간 랭킹 입력 완료(성공: "+suc+",실패: "+fal+")");
		}
	}
	
	@Scheduled(cron = "0 0 0 1 1 ?")
	public void countRateYear() {
		log.info("연간 랭킹 집계 스케줄러 로드됨");
		ArrayList<String> datelist = getDate();	//날짜를 받아와야 데이터를 받아올 수 있음
		
		RankVO vo = new RankVO();
		vo.setRank_start(datelist.get(7));	//작년 1일 날짜 입력
		vo.setRank_end(datelist.get(8));	//작년 말일 날짜 입력
		
		List<RankVO> list = rankDao.getRankTicket(vo);
		int suc = 0;
		int fal = 0;
		if(list != null && !list.isEmpty()) {
			for(RankVO rank : list) {
				rank.setRank_start(datelist.get(7));
				rank.setRank_end(datelist.get(8));
				int result = rankDao.rankInsert(rank);
				if(result==1) {
					suc++;
				}else {
					fal++;
				}
			}
			log.info(datelist.get(7)+" ~ "+datelist.get(8)+" : 연간 랭킹 입력 완료(성공: "+suc+",실패: "+fal+")");
		}
	}
	
	

}
