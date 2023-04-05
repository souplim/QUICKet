package com.spring.common.log;

import java.lang.reflect.Method;

import org.springframework.aop.interceptor.AsyncUncaughtExceptionHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AsyncExceptionLogger implements AsyncUncaughtExceptionHandler{

	@Override
	public void handleUncaughtException(Throwable ex, Method method, Object... params) {
		log.info("--------------------------------------");
		log.info("[에러 내용] "+ex.getMessage());
		log.info("[에러 발생 대상] "+method.getName());
		log.info("[파라미터 값] "+params.toString());
		log.info("--------------------------------------");
	}

}
