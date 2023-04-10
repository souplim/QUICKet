package com.spring.client.show.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.client.review.vo.ReviewVO;
import com.spring.client.show.dao.ClientShowDao;
import com.spring.client.show.vo.ImgVO;
import com.spring.client.show.vo.RankVO;
import com.spring.client.show.vo.ShowVO;

import lombok.Setter;

@Service
public class ClientShowServiceImpl implements ClientShowService {	
	@Setter(onMethod_=@Autowired)
	private ClientShowDao clientShowDao;
	
	public ArrayList<String> getDate() {
		//날짜 객체 생성
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar now = Calendar.getInstance();
		
		Calendar day = (Calendar)now.clone();
		day.add(Calendar.DAY_OF_MONTH, -1);
		String yesterday = dateFormat.format(day.getTime());
		
		//일~토 기준으로 월~일 기준으로 변환
		Calendar week = (Calendar)now.clone();
		int day_of_week = week.get(Calendar.DAY_OF_WEEK);
		if(day_of_week==1) {
			week.add(Calendar.DAY_OF_MONTH,-6);
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
	
	//위의 메서드를 통해서 날짜를 미리 받아둔다
	ArrayList<String> datelist = getDate();
	
	@Override
	public List<ShowVO> mainSlideList(ShowVO vo){
		List<ShowVO> mainSlideList = null;

		vo.setStart_date(datelist.get(0));
		vo.setEnd_date(datelist.get(1)); 
		
		int amount = vo.getAmount();
		int total = clientShowDao.showListCnt(vo);
		vo.setAmount(total);
		List<ShowVO> resultList = clientShowDao.showList(vo);
		
		if(resultList!=null) {
			Collections.shuffle(resultList);
			if(resultList.size()>=amount) { 
				mainSlideList = new ArrayList<ShowVO>();
				for(int i=0;i<amount;i++) {
					ShowVO newShow = resultList.get(i);
					mainSlideList.add(newShow);
				}
			}else{
				mainSlideList = resultList;
			}
		}
		
		if(mainSlideList!=null){
			for(ShowVO show : mainSlideList) {
				ImgVO poster = clientShowDao.posterImg(show);
				if(poster!=null) {
					show.setS_posterimg(poster);
				}
			}
		}
		
		return mainSlideList;
	}
	@Override
	public List<ShowVO> pointRankList(ShowVO vo) {
		vo.setS_array("s_point");
		vo.setS_sortorder("desc");
		
		List<ShowVO> pointRankList = clientShowDao.showList(vo);
		if(pointRankList!=null) {
			for(ShowVO show : pointRankList) {
				ImgVO poster = clientShowDao.posterImg(show);
				if(poster!=null) {
					show.setS_posterimg(poster);
				}
			}
		}
		return pointRankList;
	}
	@Override
	public List<RankVO> ticketRankList(ShowVO vo){
		List<RankVO> ticketRankList = null;
		
		vo.setS_array("rank_ticket");
		vo.setStart_date(datelist.get(3));
		vo.setEnd_date(datelist.get(4)); 
		
		int amount = vo.getAmount();
		List<RankVO> resultList = clientShowDao.rankList(vo);
		if(resultList!=null) {
			if(resultList.size()>=amount) { 
				ticketRankList = new ArrayList<RankVO>();
				for(int i=0;i<amount;i++) {
					RankVO rankShow = resultList.get(i);
					ticketRankList.add(rankShow);
				}
			}else{
				ticketRankList = resultList;
			}
		}
		
		if(ticketRankList!=null){
			for(RankVO rank : ticketRankList) {
				ImgVO poster = clientShowDao.posterImg(rank);
				if(poster!=null) {
					rank.setS_posterimg(poster);
				}
			}
		}
		
		return ticketRankList;
	}
	@Override
	public List<ShowVO> newList(ShowVO vo){
		List<ShowVO> newList = null;
		
		vo.setStart_date(datelist.get(0));
		vo.setEnd_date(datelist.get(1)); 
		vo.setS_select_date("open");
		
		
		int amount = vo.getAmount();
		int total = clientShowDao.showListCnt(vo);
		vo.setAmount(total);
		List<ShowVO> resultList = clientShowDao.showList(vo);
		
		if(resultList!=null) {
			Collections.shuffle(resultList);
			if(resultList.size()>=amount) { 
				newList = new ArrayList<ShowVO>();
				for(int i=0;i<amount;i++) {
					ShowVO newShow = resultList.get(i);
					newList.add(newShow);
				}
			}else{
				newList = resultList;
			}
		}
		
		if(newList!=null){
			for(ShowVO show : newList) {
				ImgVO poster = clientShowDao.posterImg(show);
				if(poster!=null) {
					show.setS_posterimg(poster);
				}
			}
		}
		
		return newList;
	}
	@Override
	public List<ShowVO> hotShowList(ShowVO vo) {
		List<ShowVO> hotShowList = clientShowDao.hotShowList(vo);
		if(hotShowList!=null) {
			for(ShowVO show : hotShowList) {
				ImgVO poster = clientShowDao.posterImg(show);
				if(poster!=null) {
					show.setS_posterimg(poster);
				}
			}
		}
		return hotShowList;
	}
	
	@Override
	public List<ShowVO> showList(ShowVO vo) {
		List<ShowVO> showList = clientShowDao.showList(vo);
		if(showList!=null) {
			for(ShowVO show : showList) {
				ImgVO poster = clientShowDao.posterImg(show);
				if(poster!=null) {
					show.setS_posterimg(poster);
				}
			}
		}
		return showList;
	}
	@Override
	public int showListCnt(ShowVO vo) {
		int result = clientShowDao.showListCnt(vo);
		return result;
	}
	
	@Override
	public ShowVO showDetail(ShowVO vo) {
		ShowVO result = clientShowDao.showDetail(vo);
		ImgVO poster = clientShowDao.posterImg(vo);
		if(poster!=null) {
			result.setS_posterimg(poster);
		}
		List<ImgVO> detailImg = clientShowDao.detailImg(vo);
		if(detailImg!=null) {
			result.setS_detailimg(detailImg);
		}
		return result;
	}

	@Override
	public List<RankVO> rankList(ShowVO vo) {
		if(vo.getS_array().equals("s_point") || vo.getRank_period().isEmpty()) {
			vo.setRank_period("week");
		}
		if(vo.getRank_period().equals("day")) {
			if(vo.getStart_date()=="" && vo.getEnd_date()=="") {
				vo.setStart_date(datelist.get(2));
				vo.setEnd_date(datelist.get(2)); 
			}
		}
		if(vo.getRank_period().equals("week")) {
			if(vo.getStart_date()=="" && vo.getEnd_date()=="") {
				vo.setStart_date(datelist.get(3));
				vo.setEnd_date(datelist.get(4)); 
			}
		}else if(vo.getRank_period().equals("month")) {
			if(vo.getStart_date()=="" && vo.getEnd_date()=="") {
				vo.setStart_date(datelist.get(5));
				vo.setEnd_date(datelist.get(6)); 
			}
		}else if(vo.getRank_period().equals("year")) {
			if(vo.getStart_date()=="" && vo.getEnd_date()=="") {
				vo.setStart_date(datelist.get(7));
				vo.setEnd_date(datelist.get(8)); 
			}
		}
		List<RankVO> rankList = clientShowDao.rankList(vo);
		if(rankList!=null) {
			for(RankVO rank : rankList) {
				ImgVO poster = clientShowDao.posterImg(rank);
				if(poster!=null) {
					rank.setS_posterimg(poster);
				}
			}
		} 
		return rankList;
	}
	
	public int showPointUpdate(ReviewVO vo) {
		int result = 0;
		result = clientShowDao.showPointUpdate(vo);
		return result;
	}
	
	@Override
	public int ticketCntUpdate(ShowVO vo) {
		return clientShowDao.ticketCntUpdate(vo);
	};
	
}
