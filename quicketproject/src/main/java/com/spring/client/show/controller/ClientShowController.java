package com.spring.client.show.controller;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.client.show.service.ClientShowService;
import com.spring.client.show.vo.ImgVO;
import com.spring.client.show.vo.RankVO;
import com.spring.client.show.vo.ShowVO;
import com.spring.common.vo.PageDTO;

import lombok.Setter;

@Controller
@RequestMapping("/*")
public class ClientShowController {
	@Setter(onMethod_=@Autowired)
	private ClientShowService clientShowService;
	
	//메인페이지 관련 컨트롤러
	@GetMapping("/")
	public String mainPage() {
		return "client/show/mainPage";
	}
	@ResponseBody
	@GetMapping(value="/mainSlideList", produces=MediaType.APPLICATION_JSON_VALUE)
	public 	List<ShowVO> mainSlideList(){
		ShowVO vo = new ShowVO();
		vo.setAmount(5);
		List<ShowVO> entity = clientShowService.mainSlideList(vo);
		return entity;
	}
	@ResponseBody
	@GetMapping(value="/mainPointRankList", produces=MediaType.APPLICATION_JSON_VALUE)
	public 	List<ShowVO> mainPointRankList(){
		ShowVO vo = new ShowVO();
		vo.setAmount(5);
		List<ShowVO> entity = clientShowService.pointRankList(vo);
		return entity;
	}
	@ResponseBody
	@GetMapping(value="/mainTicketRankList", produces=MediaType.APPLICATION_JSON_VALUE)
	public 	List<RankVO> mainTicketRankList(){
		RankVO vo = new RankVO();
		vo.setAmount(5);
		List<RankVO> entity = clientShowService.ticketRankList(vo);
		return entity;
	}
	@ResponseBody
	@GetMapping(value="/mainNewList", produces=MediaType.APPLICATION_JSON_VALUE)
	public 	List<ShowVO> mainNewList(){
		ShowVO vo = new ShowVO();
		vo.setAmount(5);
		List<ShowVO> entity = clientShowService.newList(vo);
		return entity;
	}
	
	//장르페이지 관련 컨트롤러
	@GetMapping("/genre")
	public String genrePage(@ModelAttribute ShowVO vo, Model model) {
		vo.setAmount(20);
		List<ShowVO> showList = clientShowService.showList(vo);
		model.addAttribute("showList", showList);

		int total = clientShowService.showListCnt(vo);
		model.addAttribute("pageMaker", new PageDTO(vo,total));
		
		return "client/show/genrePage";
	}
	@ResponseBody
	@GetMapping(value="/genrePointRankList", produces=MediaType.APPLICATION_JSON_VALUE)
	public 	List<ShowVO> genrePointRankList(@RequestParam("s_genre") String s_genre) throws Exception{
		ShowVO vo = new ShowVO();
		String d_s_genre = URLDecoder.decode(s_genre,"UTF-8");		
		vo.setS_genre(d_s_genre);
		vo.setAmount(3);
		List<ShowVO> entity = clientShowService.pointRankList(vo);
		return entity;
	}
	@ResponseBody
	@GetMapping(value="/genreTicketRankList", produces=MediaType.APPLICATION_JSON_VALUE)
	public 	List<RankVO> genreTicketRankList(@RequestParam("s_genre") String s_genre) throws Exception{
		RankVO vo = new RankVO();
		String d_s_genre = URLDecoder.decode(s_genre,"UTF-8");		
		vo.setS_genre(d_s_genre);
		vo.setS_genre(s_genre);
		vo.setAmount(3);
		List<RankVO> entity = clientShowService.ticketRankList(vo);
		return entity;
	}
	
	//검색페이지 관련 컨트롤러
	@GetMapping("/search")
	public String searchPage(@ModelAttribute ShowVO vo, Model model) {
		List<ShowVO> showList = clientShowService.showList(vo);
		model.addAttribute("showList", showList);

		int total = clientShowService.showListCnt(vo);
		model.addAttribute("pageMaker", new PageDTO(vo,total));
		
		return "client/show/searchPage";
	}
	
	//상세페이지 관련 컨트롤러
	@GetMapping("/showDetail")
	public String detailPage(@ModelAttribute ShowVO vo, Model model) {
		ShowVO detailData = clientShowService.showDetail(vo);
		model.addAttribute("detailData", detailData);
		
		return "client/show/detailPage";
	}
	
	//랭킹페이지 관련 컨트롤러
	@GetMapping("/ranking")
	public String rankPage(@ModelAttribute RankVO vo, Model model) {
		String s_array = vo.getS_array();
		if(s_array==""){ s_array = "s_point"; vo.setS_array(s_array);}
		if(s_array=="s_point") {
			List<ShowVO> rankList = clientShowService.showList(vo);
			model.addAttribute("rankList", rankList);
		}else if(s_array=="rank_rank") {
			List<RankVO> rankList = clientShowService.rankList(vo);
			model.addAttribute("rankList", rankList);
		}
		return "client/show/rankingPage";
	}

}
