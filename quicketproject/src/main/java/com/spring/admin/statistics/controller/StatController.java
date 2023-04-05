package com.spring.admin.statistics.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.admin.statistics.service.StatService;
import com.spring.admin.statistics.vo.GoogleChartDTO;
import com.spring.admin.statistics.vo.StatVO;
import com.google.gson.*;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping(value="/admin/stat/*")
@Slf4j
public class StatController {
	
	@Setter(onMethod_=@Autowired)
	private StatService statService;
	
	/***********************************************************
	 * 통계 페이지
	 * 현재 요청 URL : http://localhoast:8080/admin/stat/statList
	 ***********************************************************/
	@GetMapping(value="/statList")
	public String statList(){
		log.info("statList 조회");
		
		return "admin/stat/statList"; // /WEB-INF/views/admin/stat/statList.jsp 
	}
	
	/***********************************************************
	 * 공연별 예매비율 조회하기
	 * 현재 요청 URL : http://localhoast:8080/admin/stat/showTicketCnt
	 ***********************************************************/
	@ResponseBody
	@PostMapping(value="/showTicketCnt", produces=MediaType.APPLICATION_JSON_VALUE)
	public String showTicketCnt(){
		log.info("showTicketCnt 조회");
		
		List<StatVO> list = statService.showTicketCnt();
		System.out.println(list);
		
		GoogleChartDTO gChart = new GoogleChartDTO();
		gChart.addColumn("공연", "string");
//		gChart.addColumn("예매횟수", "number");
		gChart.addColumn("예매비율", "number");
		
		gChart.createRows(list.size());
		
		int count = 0;
		for(StatVO vo : list) { 
			gChart.addCell(count, vo.getS_name());
//			gChart.addCell(count, vo.getS_ticketcnt());
			gChart.addCell(count, vo.getS_ticketcntRatio(), String.valueOf(vo.getS_ticketcnt())+"회 ("+vo.getS_ticketcntRatio()+"%)");
			count++;
		} 
		
		Gson gson = new Gson();
		String json = gson.toJson(gChart.getResult());
		
		return json;
	}
	
	/***********************************************************
	 * 공연별 매출비율 조회하기
	 * 현재 요청 URL : http://localhoast:8080/admin/stat/showSales
	 ***********************************************************/
	@ResponseBody
	@PostMapping(value="/showSales", produces=MediaType.APPLICATION_JSON_VALUE)
	public String showSales(){
		log.info("showSales 조회");
		
		List<StatVO> list = statService.showSales();
		System.out.println(list);
		
		GoogleChartDTO gChart = new GoogleChartDTO();
		gChart.addColumn("공연", "string");
//		gChart.addColumn("매출", "number");
		gChart.addColumn("매출비율", "number");
		
		gChart.createRows(list.size());
		
		int count = 0;
		for(StatVO vo : list) { 
			gChart.addCell(count, vo.getS_name());
			gChart.addCell(count, vo.getS_salesRatio(), vo.getS_sales()+"원 ("+vo.getS_salesRatio()+"%)");
			count++;
		} 
		
		Gson gson = new Gson();
		String json = gson.toJson(gChart.getResult());
		
		return json;
	}
	
	/***********************************************************
	 * 월별 매출액 조회하기
	 * 현재 요청 URL : http://localhoast:8080/admin/stat/weeklySales
	 ***********************************************************/
	@ResponseBody
	@PostMapping(value="/weeklySales", produces=MediaType.APPLICATION_JSON_VALUE)
	public String weeklySales(){
		log.info("weeklySales 조회");
		
		List<StatVO> list = statService.weeklySales();
		System.out.println(list);
		
		GoogleChartDTO gChart = new GoogleChartDTO();
		gChart.addColumn("월별", "string");
		gChart.addColumn("베토벤", "number");
		gChart.addColumn("인터뷰", "number");
		
		gChart.createRows(list.size());
		
		int count = 0;
		for(StatVO vo : list) { 
			gChart.addCell(count, "2023/"+vo.getStat_date(), vo.getStat_date()+"월");
			gChart.addCell(count, vo.get베토벤());
			gChart.addCell(count, vo.get인터뷰());
			count++;
		} 
		
		Gson gson = new Gson();
		String json = gson.toJson(gChart.getResult());
		
		return json;
	}
}
