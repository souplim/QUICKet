package com.spring.common.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class CertificationInterceptor implements HandlerInterceptor {
	
	private void saveDest(HttpServletRequest request) {
		String uri = request.getRequestURI();
		String query = request.getQueryString();
		
		if(query == null || query.equals("null"))
			query = "";
		else
			query = "?"+query;
		
		String dest = uri+query;
		System.out.println("dest : "+dest);
//		if(request.getMethod().equals("GET"))
			request.getSession().setAttribute("dest", dest);
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		// 컨트롤러 실행 직전에 동작
		// 반환 값이 true일 경우(세션에 로그인 정보값이 존재) 정상적으로 컨트롤러 코드 진행
		// false일 경우 saveDest 호출하여 세션에 기존요청정보 저장후 /user/login으로 redirect (원래 요청의 컨트롤러 진입 x)
		HttpSession session = request.getSession();
		if(session.getAttribute("userLogin") != null) {
			return true;
		} else {
			saveDest(request);
			response.sendRedirect("/user/login");
			return false;
		}
	}
	
	// 컨트롤러 실행 후, 뷰 실행 전
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// 컨트롤러 진입 후 view가 랜더링 되기 전 수행
		HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
	}
	
	// 뷰 response 끝난 후 실행
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
	}

}
