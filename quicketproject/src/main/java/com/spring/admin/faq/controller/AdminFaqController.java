package com.spring.admin.faq.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.admin.faq.service.AdminFaqService;
import com.spring.client.faq.vo.FaqVO;
import com.spring.common.vo.PageDTO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequestMapping("admin/faq/*") //매핑 바꾸면 jsp 다 바꿔야 함
@Slf4j
public class AdminFaqController {
	
	
	@Setter(onMethod_=@Autowired)
	private AdminFaqService adminfaqService;
	
	
	/**************************************************************
	* 글목록 구현하기(페이징 처리 목록 조회)
	**************************************************************/
	
	@RequestMapping(value="/adminfaqList", method = RequestMethod.GET)  //실제적인 주소값
	//@GetMapping("/adminfaqList")
	public String adminfaqList(@ModelAttribute("data") FaqVO fvo, Model model) throws Exception {
		log.info("adminfaqList 호출 성공");
	// 전체 레코드 조회
		List<FaqVO> adminfaqList = adminfaqService.adminfaqList(fvo);
		model.addAttribute("adminfaqList", adminfaqList);
		
		// 전체 레코드수 구현
	//	int total = boardService.boardListCnt(bvo);
		
		int total = 10;
		// 페이징 처리
		model.addAttribute("pageMaker", new PageDTO(fvo, total));
		return "admin/faq/adminfaqList";   //불러오는 jsp
	}


	/**************************************************************
	 * faq 상세보기 구현
	 **************************************************************/
	@RequestMapping(value="/adminfaqDetail", method=RequestMethod.GET)
	//@GetMapping("/adminfaqDetail")
	public String adminfaqDetail(@ModelAttribute FaqVO fvo, Model model) {
		log.info("adminfaqDetail 호출 성공");		
		log.info("fvo = " + fvo);
		
		FaqVO detail = adminfaqService.adminfaqDetail(fvo);
		model.addAttribute("detail", detail);
		
		return "admin/faq/adminfaqDetail";
	}   
		
		
	/**************************************************
	 * 글쓰기 호출하기 
	 ***************************************************/
	@RequestMapping(value="/adminfaqwriteForm", method = RequestMethod.GET)	
	public String adminfaqwriteForm() {		
		log.info("adminfaqwriteForm 호출 성공");
		return "admin/faq/adminfaqwriteForm";
	}
	
	
	/**************************************************
	 * 글쓰기 구현하기
	 ***************************************************/
	
	
	@RequestMapping(value="/adminfaqInsert", method=RequestMethod.POST)
	//@PostMapping("/bardInsert")
	
	public String adminfaqInsert(@ModelAttribute FaqVO fvo, Model model) throws Exception{	
		log.info("adminfaqInsert 호출 성공");
		
		int result = 0;
		String url ="";		
		
		result = adminfaqService.adminfaqInsert(fvo);
		if(result == 1) {
			url = "adminfaqList";  //매핑 주소 			
		}else {			
			url = "adminfaqwriteForm";
		}
		return "redirect:"+url;   //	"redirect:/faq/adminfaqList"; 메핑을 호출해서 다시 조회 
			
	}
	
	
	  /**************************************************************
		 * 글수정 폼 출력하기
		 * @param  : f_no
		 * @return : FaqVO
		 **************************************************************/
	
	
		@RequestMapping(value="/adminfaqupdateForm")
		public String adminfaqupdateForm(@ModelAttribute FaqVO fvo, Model model) {
			log.info("adminfaqupdateForm 호출 성공");
			log.info("f_no = " + fvo.getF_no());
			
			FaqVO updateData = adminfaqService.adminfaqupdateForm(fvo);

			model.addAttribute("updateData", updateData);
			return "admin/faq/adminfaqupdateForm"; // 
		}  
		
		/**************************************************************
		 * 글수정 구현하기
		 * @param  : BoardVO
		 * 참고 : RedirectAttributes 객체는 리다이렉트 시점(return "redirect:/경로")에 
		 * 한번만 사용되는 데이터를 전송할 수 있는 addFlashAttribute()라는 기능을 지원한다. 
		 * addFlashAttribute() 메서드는 브라우저까지 전송되기는 하지만, URI상에는 보이지 않는 숨겨진 데이터의 형태로 전달된다.
		 **************************************************************/
		@RequestMapping(value="/adminfaqUpdate", method=RequestMethod.POST)
		public String adminfaqUpdate(@ModelAttribute FaqVO fvo) throws Exception{
			log.info("adminfaqUpdate 호출 성공");
			log.info("FaqVO" + fvo);

			int result=0;
			String url="";

			result = adminfaqService.adminfaqUpdate(fvo);
			
			
			if(result == 1){
				//아래 url은 수정 후 상세 페이지로 이동 
				url="adminfaqDetail?f_no="+fvo.getF_no();
			//	url="client/faq/adminfaqDetail?f_no="+fvo.getF_no();
				
			}else{
				url="adminfaqupdateForm?f_no="+fvo.getF_no();
			}
			
			return "redirect:"+url;
			
		}
		
		/**************************************************************
		 * 글삭제 구현하기
		 **************************************************************/
		@RequestMapping(value="/adminfaqDelete")
		public String adminfaqDelete(@ModelAttribute FaqVO fvo) throws Exception{
			log.info("adminfaqDelete 호출 성공");
			log.info("삭제할 글번호: "+ fvo.getF_no());
			
			//아래 변수에는 입력 성공에 대한 상태값 담습니다.(1 or 0)
			int result = 0;
			String url = "";
			
			result = adminfaqService.adminfaqDelete(fvo);
			
			if(result == 1){
				url="adminfaqList";
			}else{
			//	url="/board/boardDetail?b_num="+bvo.getB_num();
				url="adminfaqDetail?f_no="+fvo.getF_no();
				
			}
			return "redirect:"+url;
		} 
		
	

}
