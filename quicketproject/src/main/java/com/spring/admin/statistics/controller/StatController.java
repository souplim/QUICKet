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
		gChart.addColumn("예매비율", "number");
		
		gChart.createRows(list.size());
		
		int count = 0;
		for(StatVO vo : list) { 
			gChart.addCell(count, vo.getS_name());
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
	 * 공연별 예매비율, 매출비율 조회하기
	 * 현재 요청 URL : http://localhoast:8080/admin/stat/showTicketSales
	 ***********************************************************/
	@ResponseBody
	@PostMapping(value="/showTicketSales", produces=MediaType.APPLICATION_JSON_VALUE)
	public String showTicketSales(){
		log.info("showTicketSales 조회");
		
		List<StatVO> list = statService.showTicketSales();
		System.out.println(list);
		
		GoogleChartDTO gChart = new GoogleChartDTO();
		gChart.addColumn("공연", "string");
		gChart.addColumn("예매비율", "number");
		gChart.addColumn("매출비율", "number");
		
		gChart.createRows(list.size());
		
		int count = 0;
		for(StatVO vo : list) { 
			gChart.addCell(count, vo.getS_name());
			gChart.addCell(count, vo.getS_ticketcntRatio(), String.valueOf(vo.getS_ticketcnt())+"회 ("+vo.getS_ticketcntRatio()+"%)");
			gChart.addCell(count, vo.getS_salesRatio(), vo.getS_sales()+"원 ("+vo.getS_salesRatio()+"%)");
			count++;
		} 
		
		Gson gson = new Gson();
		String json = gson.toJson(gChart.getResult());
		
		return json;
	}
	
	
	/***********************************************************
	 * 월별 매출액 조회하기
	 * 현재 요청 URL : http://localhoast:8080/admin/stat/monthlySales
	 ***********************************************************/
	@ResponseBody
	@PostMapping(value="/monthlySales", produces=MediaType.APPLICATION_JSON_VALUE)
	public String monthlySales(){
		log.info("monthlySales 조회");
		
		List<StatVO> nameList = statService.showList();
		
		GoogleChartDTO gChart = new GoogleChartDTO();
		
		gChart.addColumn("월별", "string");
		
		for(StatVO vo : nameList) { 
			gChart.addColumn(vo.getS_name(), "number");
		} 
		
		gChart.createRows(nameList.size());
		
		List<StatVO> list = statService.monthlySales(nameList);
		System.out.println(list);
		
		int count = 0;
		for(StatVO vo : list) { 
			gChart.addCell(count, "2023/"+vo.getStat_date(), vo.getStat_date()+"월");
//			gChart.addCell(count, vo.getS_name());
			gChart.addCell(count, vo.getS1());
			gChart.addCell(count, vo.getS2());
			gChart.addCell(count, vo.getS3());
			gChart.addCell(count, vo.getS4());
			gChart.addCell(count, vo.getS5());
			gChart.addCell(count, vo.getS6());
			gChart.addCell(count, vo.getS7());
			gChart.addCell(count, vo.getS8());
			gChart.addCell(count, vo.getS9());
			gChart.addCell(count, vo.getS10());
			gChart.addCell(count, vo.getS11());
			gChart.addCell(count, vo.getS12());
			gChart.addCell(count, vo.getS13());
			gChart.addCell(count, vo.getS14());
			gChart.addCell(count, vo.getS15());
			gChart.addCell(count, vo.getS16());
			gChart.addCell(count, vo.getS17());
			gChart.addCell(count, vo.getS18());
			gChart.addCell(count, vo.getS19());
			gChart.addCell(count, vo.getS20());
			gChart.addCell(count, vo.getS21());
			gChart.addCell(count, vo.getS22());
			gChart.addCell(count, vo.getS23());
			gChart.addCell(count, vo.getS24());
			gChart.addCell(count, vo.getS25());
			gChart.addCell(count, vo.getS26());
			gChart.addCell(count, vo.getS27());
			gChart.addCell(count, vo.getS28());
			gChart.addCell(count, vo.getS29());
			gChart.addCell(count, vo.getS30());
			gChart.addCell(count, vo.getS31());
			gChart.addCell(count, vo.getS32());
			gChart.addCell(count, vo.getS33());
			gChart.addCell(count, vo.getS34());
			gChart.addCell(count, vo.getS35());
			gChart.addCell(count, vo.getS36());
			gChart.addCell(count, vo.getS37());
			gChart.addCell(count, vo.getS38());
			gChart.addCell(count, vo.getS39());
			gChart.addCell(count, vo.getS40());
			count++;
		} 
		
		Gson gson = new Gson();
		String json = gson.toJson(gChart.getResult());
		
		return json;
	}
	
	/***********************************************************
	 * 예매자 성비 조회하기
	 * 현재 요청 URL : http://localhoast:8080/admin/stat/genderCnt
	 ***********************************************************/
	@ResponseBody
	@PostMapping(value="/genderCnt", produces=MediaType.APPLICATION_JSON_VALUE)
	public String genderCnt(){
		log.info("genderCnt 조회");
		
		List<StatVO> list = statService.genderCnt();
		System.out.println(list);
		
		GoogleChartDTO gChart = new GoogleChartDTO();
		gChart.addColumn("성별", "string");
		gChart.addColumn("성비", "number");
		
		gChart.createRows(list.size());
		
		int count = 0;
		for(StatVO vo : list) { 
			gChart.addCell(count, vo.getU_gender());
			gChart.addCell(count, vo.getU_gendercnt());
			count++;
		} 
		
		Gson gson = new Gson();
		String json = gson.toJson(gChart.getResult());
		
		return json;
	}
}
