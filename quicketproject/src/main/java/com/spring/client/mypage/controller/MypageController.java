package com.spring.client.mypage.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.client.mypage.service.MypageService;
import com.spring.client.mypage.vo.MypageVO;
import com.spring.client.user.service.ClientUserService;
import com.spring.client.user.vo.UserVO;
import com.spring.common.vo.PageDTO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@SessionAttributes("userLogin")
@RequestMapping(value="/mypage/*")
@Slf4j
public class MypageController {
	
	private final MypageService mypageService;
	
	@Autowired
	public MypageController(MypageService mypageService) {
		this.mypageService = mypageService;
	} 
	
	@Setter(onMethod_ = @Autowired)
	private ClientUserService clientUserService;
	
	@ModelAttribute("userLogin")
	public UserVO userLogin() {
		return new UserVO();
	}
	
	/***********************************************************
	 * 마이페이지 메인화면 호출
	 * 요청 주소 : http://localhost:8080/mypage/
	 ***********************************************************/
	@GetMapping("/")
	public String main(@ModelAttribute("userLogin") UserVO uvo, RedirectAttributes ras, HttpServletRequest request) {
		String url = "";
		if(uvo.getU_id() == null) {
			ras.addFlashAttribute("errorMsg", "로그인이 필요합니다.");
	        url = "redirect:" + request.getHeader("Referer");
		} else {		
			log.info(uvo.getU_pwddate());
			log.info("마이페이지 메인 화면 호출");
			url = "client/mypage/main";
		}
		log.info("마이페이지 메인 화면 호출");
		return url;
	}
	
	/***********************************************************
	 * 예매내역 리스트 조회하기
	 * 요청 주소 : http://localhost:8080/mypage/myTicketList
	 ***********************************************************/
	@GetMapping(value="/myTicketList")
	public String myTicketList(@ModelAttribute("userLogin") UserVO userVO, @ModelAttribute MypageVO mypageVO, Model model ) {
		log.info("예매내역 화면");
		
		// 회원 아이디 임의로 지정
		// mypageVO.setU_id("user02");
		
		// 로그인한 회원 아이디 세션에서 얻어오기
		if(userVO.getU_id()==null)
			return "redirect:/user/login";
		else
			mypageVO.setU_id(userVO.getU_id());
		
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
	public String myTicketDetail(@ModelAttribute("userLogin") UserVO userVO, @ModelAttribute MypageVO mypageVO, Model model) { 
		log.info("예매내역 상세화면");
		
		// 로그인한 회원 아이디 세션에서 얻어오기
		if(userVO.getU_id()==null)
			return "redirect:/user/login";
		else
			mypageVO.setU_id(userVO.getU_id());
				
		// 공연 상세 페이지에 들어갈 공연 관심 수 조회
		System.out.println(mypageVO.getS_num());
		int likesCount = mypageService.likesCount(mypageVO.getS_num());
		mypageVO.setLikesCount(likesCount);
		
		// 세부정보 조회
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
	public String myTicketDelete(@ModelAttribute("userLogin") UserVO userVO, @RequestParam("ti_num") int ti_num, MypageVO mypageVO, Model model) {
		log.info("예매내역 취소화면");
		
		// 로그인한 회원 아이디 세션에서 얻어오기
		if(userVO.getU_id()==null)
			return "redirect:/user/login";
		else
			mypageVO.setU_id(userVO.getU_id());
		
		String url = "";
		
		int result = mypageService.myTicketDelete(ti_num);

		mypageVO.setTi_num(ti_num);
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
	public String myBookmarkList(@ModelAttribute("userLogin") UserVO userVO, @ModelAttribute MypageVO mypageVO, Model model) {
		log.info("예매내역 화면");
		
		// 회원 아이디 임의로 지정
		// mypageVO.setU_id("userid");
		
		// 로그인한 회원 아이디 세션에서 얻어오기
		if(userVO.getU_id()==null)
			return "redirect:/user/login";
		else
			mypageVO.setU_id(userVO.getU_id());
		
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
	public String likes(@ModelAttribute("userLogin") UserVO userVO, @ModelAttribute MypageVO mypageVO, String likes){
		log.info("likes() 호출 성공");
		
		// 로그인한 회원 아이디 세션에서 얻어오기
		if(userVO.getU_id()==null)
			return "redirect:/user/login";
		else
			mypageVO.setU_id(userVO.getU_id());
				
		int result = 0;
		result = mypageService.likes(mypageVO, likes);
		return (result==1) ? "SUCCESS" : "FAILURE";
	}
	
	
	/***********************************************************
	 * 관심공연 리스트 조회하기
	 * 요청 주소 : http://localhost:8080/mypage/myLikeList
	 ***********************************************************/
	@GetMapping(value="/myLikeList")
	public String myLikeList(@ModelAttribute("userLogin") UserVO userVO, @ModelAttribute MypageVO mypageVO, Model model) {
		log.info("예매내역 화면");
		
		// 회원 아이디 임의로 지정
		//mypageVO.setU_id("user02");
		
		// 로그인한 회원 아이디 세션에서 얻어오기
		if(userVO.getU_id()==null)
			return "redirect:/user/login";
		else
			mypageVO.setU_id(userVO.getU_id());
		
		// 회원 문의글 리스트 조회
		List<MypageVO> likeList = null;
		likeList = mypageService.myLikeList(mypageVO);
		model.addAttribute("likeList", likeList);
		
		// 페이징 처리
		int total = mypageService.myLikesListCnt(mypageVO);
		model.addAttribute("pageMaker", new PageDTO(mypageVO, total));
				
		return "client/mypage/myLikeList"; // /WEB-INF/views/client/mypage/myLikeList.jsp
	}
	
	/***********************************************************
	 * 나의 qna 리스트 조회하기
	 * 요청 주소 : http://localhost:8080/mypage/myQnaList
	 ***********************************************************/
	@GetMapping(value="/myQnaList")
	public String myQnaList(@ModelAttribute("userLogin") UserVO userVO, @ModelAttribute MypageVO mypageVO, Model model ) {
		log.info("Q&A 화면");
		
		// 회원 아이디 임의로 지정
		// mypageVO.setU_id("user02");
		
		// 로그인한 회원 아이디 세션에서 얻어오기
		if(userVO.getU_id()==null)
			return "redirect:/user/login";
		else
			mypageVO.setU_id(userVO.getU_id());
		
		// 회원 qna글 리스트 조회
		List<MypageVO> qnaList = null;
		qnaList = mypageService.qnaList(mypageVO);
		model.addAttribute("qnaList", qnaList);
		
		// qna 페이징 처리
		int total = mypageService.qnaListCnt(mypageVO);
		model.addAttribute("pageMaker", new PageDTO(mypageVO, total));
		
		return "client/mypage/myQnaList"; // /WEB-INF/views/client/mypage/myQnaList.jsp
	}
	
	/***********************************************************
	 * 나의 관람후기 리스트 조회하기
	 * 요청 주소 : http://localhost:8080/mypage/myReviewList
	 ***********************************************************/
	@GetMapping(value="/myReviewList")
	public String myReviewList(@ModelAttribute("userLogin") UserVO userVO, @ModelAttribute MypageVO mypageVO, Model model ) {
		log.info("공연후기 화면");
		
		// 회원 아이디 임의로 지정
		//mypageVO.setU_id("user02");
		
		// 로그인한 회원 아이디 세션에서 얻어오기
		if(userVO.getU_id()==null)
			return "redirect:/user/login";
		else
			mypageVO.setU_id(userVO.getU_id());
		
		// 회원 관람후기 글 리스트 조회
		List<MypageVO> reviewList = null;
		reviewList = mypageService.reviewList(mypageVO);
		model.addAttribute("reviewList", reviewList);
		
		// 관람후기 페이징 처리
		int total = mypageService.reviewListCnt(mypageVO);
		model.addAttribute("pageMaker", new PageDTO(mypageVO, total));
		
		return "client/mypage/myReviewList"; // /WEB-INF/views/client/mypage/myReviewList.jsp
	}
	
	/***********************************************************
	 * 나의 발급쿠폰 리스트 조회하기(사용가능)
	 * 요청 주소 : http://localhost:8080/mypage/myCouponList
	 ***********************************************************/
	@GetMapping(value="/myCouponList")
	public String myCouponList(@ModelAttribute("userLogin") UserVO userVO, @ModelAttribute MypageVO mypageVO, Model model ) {
		log.info("사용가능 발급쿠폰 화면");
		
		// 회원 아이디 임의로 지정
		//mypageVO.setU_id("user02");
		
		// 로그인한 회원 아이디 세션에서 얻어오기
		if(userVO.getU_id()==null)
			return "redirect:/user/login";
		else
			mypageVO.setU_id(userVO.getU_id());
		
		// 발급쿠폰 리스트 조회
		List<MypageVO> couponList = null;
		couponList = mypageService.couponList(mypageVO);
		model.addAttribute("couponList", couponList);
		
		// 발급쿠폰 페이징 처리
		int total = mypageService.couponListCnt(mypageVO);
		model.addAttribute("pageMaker", new PageDTO(mypageVO, total));
		
		return "client/mypage/myCouponList"; // /WEB-INF/views/client/mypage/myCouponList.jsp
	}
	
	/***********************************************************
	 * 나의 발급쿠폰 리스트 조회하기(사용완료)
	 * 요청 주소 : http://localhost:8080/mypage/myCouponListN
	 ***********************************************************/
	@GetMapping(value="/myCouponListN")
	public String myCouponListN(@ModelAttribute("userLogin") UserVO userVO, @ModelAttribute MypageVO mypageVO, Model model ) {
		log.info("사용가능 발급쿠폰 화면");
		
		// 회원 아이디 임의로 지정
		//mypageVO.setU_id("user02");
		
		// 로그인한 회원 아이디 세션에서 얻어오기
		if(userVO.getU_id()==null)
			return "redirect:/user/login";
		else
			mypageVO.setU_id(userVO.getU_id());
		
		// 사용완료 쿠폰 리스트 조회
		List<MypageVO> couponListN = null;
		couponListN = mypageService.couponListN(mypageVO);
		model.addAttribute("couponListN", couponListN);
		
		// 사용완료 쿠폰 페이징 처리
		int total = mypageService.couponListCntN(mypageVO);
		model.addAttribute("pageMaker", new PageDTO(mypageVO, total));
		
		return "client/mypage/myCouponListN"; // /WEB-INF/views/client/mypage/myCouponListN.jsp
	}
	
}
