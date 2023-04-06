package com.spring.admin.review.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.admin.review.service.AdminReviewService;
import com.spring.client.review.vo.ReviewVO;
import com.spring.common.vo.PageDTO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequestMapping("admin/review/*") //매핑 바꾸면 jsp 다 바꿔야 함
@Slf4j
public class AdminReviewController {
	
	
	@Setter(onMethod_=@Autowired)
	private AdminReviewService adminreviewService;
	
	
	/**************************************************************
	* 글목록 구현하기(페이징 처리 목록 조회)
	**************************************************************/
	
	@RequestMapping(value="/adminreviewList", method = RequestMethod.GET)
	//@GetMapping("/adminreviewList")
	public String adminreviewList(@ModelAttribute("data") ReviewVO rvo, Model model) throws Exception {
		log.info("adminreviewList 호출 성공");
		int s_num = rvo.getS_num();
		log.info("s_num : " + s_num);
	// 전체 레코드 조회
		List<ReviewVO> adminreviewList = adminreviewService.adminreviewList(rvo);
		model.addAttribute("adminreviewList", adminreviewList);
		model.addAttribute("s_num", s_num);
		
		// 전체 레코드수 구현
		int total = adminreviewService.reviewCnt(rvo);
		
		// 페이징 처리
		model.addAttribute("pageMaker", new PageDTO(rvo, total));
		
		int count = total - (rvo.getPageNum()-1) * rvo.getAmount();
		model.addAttribute("count", count);
		
		return "admin/review/adminreviewList";   //리턴해 주는게 뷰의 정보
	}

	
	
		/**************************************************************
		 *  상세보기 구현
		 **************************************************************/
		
		@RequestMapping(value="/adminreviewDetail", method=RequestMethod.GET)
		//@GetMapping("/adminreviewDetail")
		public String adminreviewDetail(@ModelAttribute ReviewVO rvo, Model model) {
			log.info("adminreviewDetail 호출 성공");		
			log.info("rvo = " + rvo);
			
			ReviewVO detail = adminreviewService.adminreviewDetail(rvo);
			model.addAttribute("detail", detail);
			
			return "admin/review/adminreviewDetail";
		}   
		

	
	
		/**************************************************************
		 * 글삭제 구현하기
		 **************************************************************/
		@RequestMapping(value="/adminreviewDelete")
		public String adminreviewDelete(@ModelAttribute ReviewVO rvo) throws Exception{
			log.info("adminreviewDelete 호출 성공");
			log.info("삭제할 글번호: "+ rvo.getR_no());
			
			//아래 변수에는 입력 성공에 대한 상태값 담습니다.(1 or 0)
			int result = 0;
			String url = "";
			
			result = adminreviewService.adminrevewDelete(rvo);
			
			if(result == 1){
				url="/admin/review/adminreviewList?s_num=" + rvo.getS_num();
			}else{
				url="/adminreviewDetail?r_no="+rvo.getR_no();
				
			}
			return "redirect:"+url;
		} 


}

