package com.spring.client.mypage.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.client.mypage.service.MypageService;
import com.spring.client.mypage.vo.MypageVO;
import com.spring.common.vo.PageDTO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping(value="/mypage/*")
@Slf4j
public class MypageController {
	
	private final MypageService mypageService;
	
	@Autowired
	public MypageController(MypageService mypageService) {
		this.mypageService = mypageService;
	} 
	
	/***********************************************************
	 * 예매내역 리스트 조회하기
	 * 요청 주소 : http://localhost:8080/mypage/myTicketList
	 ***********************************************************/
	@GetMapping(value="/myTicketList")
	public String myTicketList(@ModelAttribute MypageVO mypageVO, Model model ) {
		log.info("예매내역 화면");
		
		// 회원 아이디 임의로 지정
		mypageVO.setU_id("user02");
//		mypageVO.setU_id("yubin");
		
		// 회원 문의글 리스트 조회
		List<MypageVO> ticketList = null;
		ticketList = mypageService.myTicketList(mypageVO);
		model.addAttribute("ticketList", ticketList);
		
		// 페이징 처리
		int total = mypageService.ticketListCnt(mypageVO);
		model.addAttribute("pageMaker", new PageDTO(mypageVO, total));
				
		return "client/mypage/myTicketList"; // /WEB-INF/views/client/mypage/myTicketList.jsp
	}
	
	/***********************************************************
	 * 예매내역 세부정보 조회하기
	 * 현재 요청 URL : localhost:8080/mypage/myTicketDetail
	 ***********************************************************/
	@PostMapping(value="/myTicketDetail")
	public String myTicketDetail(@ModelAttribute MypageVO mypageVO, Model model) { 
		log.info("예매내역 상세화면");
		
		// 공연 상세 페이지에 들어갈 공연 관심 수 조회
		System.out.println(mypageVO.getS_num());
		int likesCount = mypageService.likesCount(mypageVO.getS_num());
		mypageVO.setLikesCount(likesCount);
		
		// 세부정보 조회
		mypageVO.setU_id("user02");
		MypageVO ticketDetail = mypageService.myTicketDetail(mypageVO);
		model.addAttribute("ticketDetail", ticketDetail);
		
		// 좌석번호 리스트 조회
		List<Integer> seatList = mypageService.mySeatList(mypageVO.getTi_num());
		model.addAttribute("seatList", seatList);
				
		return "client/mypage/myTicketDetail"; // /WEB-INF/views/client/mypage/myTicketDetail.jsp 
	}
	
	/***********************************************************
	 * 예매 취소하기
	 * 현재 요청 URL : http://localhost:8080/mypage/myTicketDelete
	 ***********************************************************/
	@GetMapping(value="/myTicketDelete")
	public String myTicketDelete(@RequestParam("ti_num") int ti_num, MypageVO mypageVO, Model model) {
		log.info("예매내역 취소화면");
		
		String url = "";
		
		int result = mypageService.myTicketDelete(ti_num);

		MypageVO ticketDetail = mypageService.myTicketDetail(mypageVO);
		
		if(result == 1) {
			model.addAttribute("ticketDelete", ticketDetail);
			url = "client/mypage/myTicketDelete";
		} else {
			model.addAttribute("ticketDetail", ticketDetail);
			url = "redirect:/client/mypage/myTicketDetail"; // jsp 페이지로 포워드 하지 않고 매핑 찾기
		}
		
		return url;
	}
	
	
	/***********************************************************
	 * 관심공연 리스트 조회하기
	 * 요청 주소 : http://localhost:8080/mypage/myBookmarkList
	 ***********************************************************/
	@GetMapping(value="/myBookmarkList")
	public String myBookmarkList(@ModelAttribute MypageVO mypageVO, Model model) {
		log.info("예매내역 화면");
		
		// 회원 아이디 임의로 지정
		mypageVO.setU_id("userid");
		
		// 회원 문의글 리스트 조회
		List<MypageVO> ticketList = null;
		ticketList = mypageService.myTicketList(mypageVO);
		model.addAttribute("ticketList", ticketList);
		
		// 페이징 처리
		int total = mypageService.ticketListCnt(mypageVO);
		model.addAttribute("pageMaker", new PageDTO(mypageVO, total));
				
		return "client/mypage/myTicketList"; // /WEB-INF/views/client/mypage/myTicketList.jsp
	}
	
	
	/***********************************************************
	 * 관심공연 등록하기
	 * 현재 요청 URL : http://localhost:8080/mypage/likes
	 ***********************************************************/
	@ResponseBody
	@PostMapping(value="/likes", produces="text/plain; charset=UTF-8")
	public String likes(@ModelAttribute MypageVO mypageVO, String likes){
		log.info("likes() 호출 성공");
		
		mypageVO.setU_id("user02");
		int result = 0;
		result = mypageService.likes(mypageVO, likes);
		return (result==1) ? "SUCCESS" : "FAILURE";
	}
	
	
	/***********************************************************
	 * 관심공연 리스트 조회하기
	 * 요청 주소 : http://localhost:8080/mypage/myLikeList
	 ***********************************************************/
	@GetMapping(value="/myLikeList")
	public String myLikeList(@ModelAttribute MypageVO mypageVO, Model model) {
		log.info("예매내역 화면");
		
		// 회원 아이디 임의로 지정
		mypageVO.setU_id("user02");
//		mypageVO.setU_id("yubin");
		
		// 회원 문의글 리스트 조회
		List<MypageVO> likeList = null;
		likeList = mypageService.myLikeList(mypageVO);
		model.addAttribute("likeList", likeList);
		
		// 페이징 처리
		//int total = mypageService.ticketListCnt(mypageVO);
		//model.addAttribute("pageMaker", new PageDTO(mypageVO, total));
				
		return "client/mypage/myLikeList"; // /WEB-INF/views/client/mypage/myLikeList.jsp
	}
	
}
