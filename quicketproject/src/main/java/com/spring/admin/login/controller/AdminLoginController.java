package com.spring.admin.login.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.admin.login.service.AdminLoginService;
import com.spring.admin.login.vo.AdminLoginVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

/* @SessionAttributes : 모델(Model) 정보를 HTTP 세션에 저장해주는 어노테이션.
 * HttpSession을 직접 사용할 수도 있지만 이 어노테이션에 설정한 이름에 해당하는 모델 정보를 자동으로 세션에 넣어준다. */

@Controller
@SessionAttributes("adminLogin")
@RequestMapping("/admin/*")
@Slf4j
class AdminLoginController {
	
	@Setter(onMethod_ = @Autowired)
	private AdminLoginService adminLoginService;
	
	/* @SessionAttributes의 파라미터와 같은 이
	 * 세션에 있는 객체를 가져온 후, 클라이언트로 전 
	 */
	@ModelAttribute
	public AdminLoginVO adminLogin() {
		return new AdminLoginVO();
	}
	
	/*************************************************************
	 * 로그인 화면 구현 메서드
	 * 요청 URL : http://localhost:8080/admin/login 으로 요청
	 *************************************************************/
	@GetMapping("/login")
	public String loginForm() {
		log.info("admin 로그인 화면 호출");
		return "admin/login";
	}
	
	/*************************************************************
	 * 로그인 처리 메서드
	 * 참고 : 자바단에서 세션의 값을 사용할 경우 다시 말해 Controller 내 메서드에서 세션의 값이 필요할 경우
	 * @SessionAttributes("adminLogin") 명시해 준 이름을
	 * public 반환형 메서드명(@SessionAttribute("adminLogin") VO클래스명 참조변수)
	 * 정의하고 사용하면 된다.
	 * RedirectAttributes 객체는 리다이렉트 시점(return "redirect:/경로")에
	 * 한 번만 사용되는 데이터를 전송할 수 있는 addFlashAttribute()라는 기능을 지원한다.
	 * addFlashAttribute() 메서드는 브라우저까지 전송되기는 하지만, URI 상에는 보이지 않는 숨겨진 데이터의 형태로 전달된다.
	 * redirect:/admin/login?errorMsg=error라고 전송을 해야하는데
	 * 이때 ras.addFlashAttribute("errorMsg", "error"); redirect:/admin/login으로 이동
	 * 
	 * 매개변수 안에 HttpSession session 선언하면 인스턴스 생성까지 해결됨. (request.getSession() 불필요)
	 *************************************************************/
	@PostMapping("/login")
	public String loginProcess(AdminLoginVO login, Model model, RedirectAttributes ras/*, HttpSession session*/) {
		String url = "";
		log.info("admin 로그인 처리 호출");
		
		AdminLoginVO adminLogin = adminLoginService.loginProcess(login);
		
		
		if(adminLogin != null) {
			model.addAttribute("adminLogin", adminLogin);
			url = "/admin/quicket/main";
		} else {
			ras.addFlashAttribute("errorMsg", "로그인 실패");
			url = "/admin/login";
		}
		return "redirect:"+url;
	}
	
	@GetMapping("/quicket/main")
	public String result() {
		return "admin/quicket/main";
	}
	
	 /*************************************************************
	  * 로그아웃 처리 메서드
	  * setComplete() 메서드 활용하여 세션을 할당 해지
	 *************************************************************/
	@RequestMapping("/logout")
	public String logout(SessionStatus sessionStatus) {
		log.info("admin 로그인 아웃 처리");
		sessionStatus.setComplete();
		return "redirect:/admin/login";
	}
	
	

}
