package com.spring.admin.ticket.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonObject;
import com.spring.admin.ticket.service.AdminTicketService;
import com.spring.admin.ticket.vo.HallVO;
import com.spring.common.vo.PageDTO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/ticket/*")
//@Log4j
@Slf4j
public class AdminTicketController {
	
	@Setter(onMethod_ = @Autowired)
	private AdminTicketService adminTicketService;
	
	/*
	 * @Setter(onMethod_ = @Autowired) private PaymentService paymentService;
	 */
	
	@RequestMapping("/hall_writeForm")
	public String ticketWrite(Model model) {
		log.info("ticketWrite 호출 성공");
		return "admin/ticket/hall_writeForm"; // /WEB-INF/views/admin/ticket/ticket_writeForm.jsp
		
	}
	
	@GetMapping("/cash")
	public String cash(Model model) {
		log.info("cash 호출 성공");
		
		
		return "admin/ticket/testCash"; // /WEB-INF/views/admin/ticket/ticket_writeForm.jsp
		
	}
	
	// 카드 결제 성공 후
	/*
	 * @PostMapping("/api/order/payment/complete") public ResponseEntity<String>
	 * paymentComplete(HttpSession session ) throws IOException {
	 * 
	 * String token = paymentService.getToken();
	 * 
	 * System.out.println("토큰 : " + token); return new
	 * ResponseEntity<>("주문이 완료되었습니다.",HttpStatus.OK); }
	 */
	
	@RequestMapping("/home")
	public String home(Model model) {
		log.info("home 호출 성공");
		return "admin/ticket/home"; 
		
	}
	
//	글목록 구현하기(페이징 처리부분 제외 목록 조회)
//	요청 URL : http://localhost:8080/board/boardList
	
	@RequestMapping(value="/hall_list", method = RequestMethod.GET)
	public String hall_list(@ModelAttribute("data") HallVO hvo, Model model) {
		log.info("hall_list 호출 성공");
		// 전체 레코드 조회
		List<HallVO> hall_list = adminTicketService.hall_list(hvo);
//		log.info(boardList);
		model.addAttribute("hall_list",hall_list);
		
		// 전체 레코드수 구현
//		int total = adminTicketService.hall_listCnt(hvo);
//		log.info(total);
		// 페이징 처리
//		model.addAttribute("pageMaker", new PageDTO(hvo, total));
		return "admin/ticket/hall_list"; // 
	}
	
	@RequestMapping(value="/hall_updateForm")
	public String updateForm(@ModelAttribute HallVO hvo, Model model) {
		log.info("hall_updateForm 호출 성공");
		log.info("th_num = " + hvo.getTh_num());
		
		List<HallVO> updateData = adminTicketService.updateForm(hvo);
		
		model.addAttribute("updateData", updateData);
		
		return "admin/ticket/hall_updateForm";
	}
	
	@RequestMapping(value="/hall_updateForm2")
	public String updateForm2(@ModelAttribute HallVO hvo, Model model) {
		log.info("hall_updateForm2 호출 성공");
		
		HallVO hall_updateForm2 = adminTicketService.updateForm2(hvo);
		
		model.addAttribute("hall_updateForm2", hall_updateForm2);
		
		return "admin/ticket/hall_updateForm2";
	}
	
	@RequestMapping(value="/hallUpdate", method=RequestMethod.POST)
	public String hallUpdate(@ModelAttribute HallVO hvo, RedirectAttributes ras) throws Exception {
		log.info("hallUpdate 호출 성공");
		
		int result = 0;
		String url="";
		
		result = adminTicketService.hallUpdate(hvo);  
		ras.addFlashAttribute("HallVO",hvo); // 글번호인 b_num의 값을 유지하기위해서
//		만약 위의 문구를 사용한다면
//		url="/board/boardDetail?b_num=" + bvo.getB_num(); 얘를 사용해서 getB_num을 유지할 필요없이
//		url="/board/boardDetail"; 을 사용해서 유지할 수 있다. 근데 이러면 get방식?
		
		if(result == 1) {
			//아래 url은 수정 후 상세 페이지로 이동
//			url="/board/boardDetail?b_num=" + bvo.getB_num();
			url="/admin/ticket/hall_updateForm?th_num=" + hvo.getTh_num();
		}else {
//			url="/board/updateForm?b_num=" + bvo.getB_num();
			url="/admin/ticket/hall_updateForm2";
		}
		
		return "redirect:" + url;		
	}
}
