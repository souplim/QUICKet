package com.spring.client.show.service;

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
	public List<RankVO> rankList(RankVO vo) {
		List<RankVO> showRankList = clientShowDao.rankList(vo);
		if(showRankList!=null) {
			for(RankVO rank : showRankList) {
				ImgVO poster = clientShowDao.posterImg(rank);
				if(poster!=null) {
					rank.setS_posterimg(poster);
				}
			}
		}
		return showRankList;
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
}
