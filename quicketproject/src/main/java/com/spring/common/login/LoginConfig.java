package com.spring.common.login;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class LoginConfig implements WebMvcConfigurer {
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		registry.addInterceptor(new CertificationInterceptor())
		.addPathPatterns(/* "/mypage/",*/ "/mypage/**", "/inq/**"/*, "/reviewList/reviewInsert", "/client/payPage/**"*/)
		.excludePathPatterns("/", "/user/login", "/user/join", "/user/logout", "/user/mailConfirm","/user/searchIdForm",
				"/user/searchIdForm", "/user/sendTempPwd", "/user/sendTempPwd", "/user/pwdConfirm", "/resources/**"
				);
		
	}
}
