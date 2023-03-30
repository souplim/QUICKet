package com.spring.client.show.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
		Calendar mon = (Calendar)now.clone();
		Calendar sun = (Calendar)now.clone();
		
		//일~토 기준으로 월~일 기준으로 변환
		int day_of_week = Calendar.DAY_OF_WEEK;
		if(day_of_week==1) {
			mon.add(Calendar.DAY_OF_WEEK,-6);
		}else{
			mon.set(Calendar.DAY_OF_WEEK,2);
			sun.set(Calendar.DAY_OF_WEEK,1);
			sun.add(Calendar.DAY_OF_MONTH,7);
		}
		
		String monday = dateFormat.format(mon.getTime());
		String sunday = dateFormat.format(sun.getTime());
		
		ArrayList<String> list = new ArrayList<String>();
		list.add(monday);
		list.add(sunday);
		
		return list;
	}
	
	@Override
	public List<ShowVO> mainSlideList(ShowVO vo){
		List<ShowVO> mainSlideList = null;

		vo.setStart_date(getDate().get(0));
		vo.setEnd_date(getDate().get(1)); 
		
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
	public List<RankVO> ticketRankList(RankVO vo){
		List<RankVO> ticketRankList = null;
		
		vo.setStart_date(getDate().get(0));
		vo.setEnd_date(getDate().get(1)); 
		
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
		
		vo.setStart_date(getDate().get(0));
		vo.setEnd_date(getDate().get(1)); 
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
	public List<RankVO> rankList(RankVO vo) {
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
	
}
