package com.spring.common.task;

import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.SchedulingConfigurer;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
public class SchedulerConfig implements SchedulingConfigurer {


	private static final int POOL_SIZE = 5;
	
	@Override
	public void configureTasks(ScheduledTaskRegistrar taskRegistrar) {
		log.info("스케줄러 쓰레드 설정 로딩됨...");
		
		
		ThreadPoolTaskScheduler taskSchduler = new ThreadPoolTaskScheduler();
		
		taskSchduler.setPoolSize(POOL_SIZE);
		taskSchduler.setThreadNamePrefix("rank-count-task-");
		taskSchduler.initialize();
		
		taskRegistrar.setTaskScheduler(taskSchduler);
	}
}
