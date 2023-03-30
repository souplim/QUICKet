package com.spring.client.theater.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.client.show.vo.ShowVO;
import com.spring.client.theater.service.ClientTheaterService;
import com.spring.client.theater.vo.TheaterVO;

import lombok.Setter;

@RestController
@RequestMapping("/theater/*")
public class ClientTheaterController {
	
	@Setter(onMethod_=@Autowired)
	private ClientTheaterService clientTheaterService;
	
	
	@PostMapping(value="/theaterOne", produces=MediaType.APPLICATION_JSON_VALUE)
	public TheaterVO theaterOne(@RequestBody ShowVO vo) {
		TheaterVO entity = null;
		entity = clientTheaterService.theaterOne(vo);
		
		return entity;
	} 
}
