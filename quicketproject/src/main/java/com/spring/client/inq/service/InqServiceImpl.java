package com.spring.client.inq.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.client.inq.dao.InqDao;
import com.spring.client.inq.vo.InqVO;

import lombok.Setter;

@Service
public class InqServiceImpl implements InqService {

	@Setter(onMethod_=@Autowired)
	private InqDao inqDao;
	
	@Override
	public List<InqVO> inqList() {
		List<InqVO> list = null;
		list = inqDao.inqList();
		return list;
	}

}
