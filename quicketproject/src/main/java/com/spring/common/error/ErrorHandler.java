/* package com.spring.common.error;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ErrorHandler implements ErrorController {
	
	@GetMapping("/error")
	public String handlerError(HttpServletRequest request) {
		
		// 에러 코드를 획득한다.
		Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
		
        if(status != null){
        	// HttpStatus와 비교해 페이지 분기를 나누기 위한 변수
            int statusCode = Integer.valueOf(status.toString());
            System.out.println(statusCode);
            
            // 404에러
            if(statusCode == HttpStatus.NOT_FOUND.value()){
                return "/error/404";
            } else { // 그 외 모든 에러
                return "/error/errorPage";
            } 
        }
      
        return "/error/errorPage";
    } 
    
}
*/