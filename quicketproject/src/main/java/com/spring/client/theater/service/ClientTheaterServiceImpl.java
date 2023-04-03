package com.spring.client.theater.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.client.show.vo.ShowVO;
import com.spring.client.theater.dao.ClientTheaterDao;
import com.spring.client.theater.vo.TheaterVO;

import lombok.Setter;

@Service
public class ClientTheaterServiceImpl implements ClientTheaterService{

	@Setter(onMethod_=@Autowired)
	private ClientTheaterDao clientTheaterDao;
	
	@Override
	public TheaterVO theaterOne(ShowVO vo) {
		TheaterVO result = clientTheaterDao.theaterOne(vo);
		return result;
	}
}
