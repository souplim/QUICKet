package com.spring.client.show.controller;

import java.net.URLDecoder;
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

import com.spring.admin.ticket.vo.HallVO;
import com.spring.client.mypage.service.MypageService;
import com.spring.client.mypage.vo.MypageVO;
import com.spring.client.show.service.ClientShowService;
import com.spring.client.show.vo.RankVO;
import com.spring.client.show.vo.ShowVO;
import com.spring.client.ticket.service.ClientTicketService;
import com.spring.client.user.vo.UserVO;
import com.spring.common.vo.PageDTO;

import lombok.Setter;

@Controller
@RequestMapping("/*")
public class ClientShowController {
	@Setter(onMethod_=@Autowired)
	private ClientShowService clientShowService;
	
	@Setter(onMethod_ = @Autowired)
	private ClientTicketService clientTicketService;
	
	@Setter(onMethod_ = @Autowired)
	private MypageService mypageService;
	
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
		ShowVO vo = new ShowVO();
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
		ShowVO vo = new ShowVO();
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
	public String detailPage(@ModelAttribute ShowVO vo, @ModelAttribute("userLogin") UserVO userVO, MypageVO mypageVO, Model model) {
		ShowVO detailData = clientShowService.showDetail(vo);
		model.addAttribute("detailData", detailData);
		
		HallVO hvo = new HallVO();
		hvo.setTh_num(detailData.getTh_num());
		HallVO hall_list = clientTicketService.hall_th_num(hvo);
		model.addAttribute("hall_list",hall_list);
		
		
		// 관심 공연 버튼 제어하기 위한 세부정보 조회
//		mypageVO.setS_num(vo.getS_num());
		if(userVO.getU_id()!=null)
			mypageVO.setU_id(userVO.getU_id());

		MypageVO ticketDetail = mypageService.myTicketDetail(mypageVO);
		model.addAttribute("ticketDetail", ticketDetail);
		// 공연 상세 페이지에 들어갈 공연 관심 수 조회
		int likesCount = mypageService.likesCount(mypageVO.getS_num());
		mypageVO.setLikesCount(likesCount);

		return "client/show/detailPage";
	}
	
	//랭킹페이지 관련 컨트롤러
	@GetMapping("/ranking")
	public String rankingPage(@ModelAttribute ShowVO vo, Model model) {
		if(vo.getS_array().isEmpty()) {
			vo.setS_array("s_point");
		}
		List<RankVO> rankList = clientShowService.rankList(vo);
		model.addAttribute("rankList", rankList);
		return "client/show/rankingPage";
	}
	
}
