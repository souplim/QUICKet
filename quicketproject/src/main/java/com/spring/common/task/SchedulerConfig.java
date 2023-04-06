package com.spring.common.task;

import java.util.concurrent.Executor;

import org.springframework.aop.interceptor.AsyncUncaughtExceptionHandler;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.AsyncConfigurer;
import org.springframework.scheduling.annotation.SchedulingConfigurer;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;

import com.spring.common.log.AsyncExceptionLogger;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
public class SchedulerConfig implements AsyncConfigurer, SchedulingConfigurer {
	
	public ThreadPoolTaskScheduler threadPoolTaskScheduler() {
		log.info("SchedulerConfig : threadpool 생성 개시...");
		ThreadPoolTaskScheduler taskScheduler = new ThreadPoolTaskScheduler();
		
		taskScheduler.setPoolSize(Runtime.getRuntime().availableProcessors()*2);
		taskScheduler.setThreadNamePrefix("rank-count-task-");
		taskScheduler.initialize();
		log.info("SchedulerConfig : threadpool 생성 성공...");
		return taskScheduler;
	}
	
	@Override
	public Executor getAsyncExecutor() {
		Executor executor = this.threadPoolTaskScheduler();
		log.info("SchedulerConfig : threadpool 비동기화 작업 성공...");
		return executor;
	}
	
	@Override
	public void configureTasks(ScheduledTaskRegistrar taskRegistrar) {
		log.info("SchedulerConfig : threadpool을 생성하고 스케줄러를 threadpool에 입력합니다...");
		taskRegistrar.setTaskScheduler(this.threadPoolTaskScheduler());
		log.info("SchedulerConfig : 스케줄러 세팅 완료...");
	}

	@Override
	public AsyncUncaughtExceptionHandler getAsyncUncaughtExceptionHandler() {
		return new AsyncExceptionLogger();
	}

}
