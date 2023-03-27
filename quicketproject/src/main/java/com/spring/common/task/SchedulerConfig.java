package com.spring.common.task;

import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.SchedulingConfigurer;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;

@Configuration
public class SchedulerConfig implements SchedulingConfigurer {

	@Override
	public void configureTasks(ScheduledTaskRegistrar taskRegistrar) {
		ThreadPoolTaskScheduler taskSchduler = new ThreadPoolTaskScheduler();
		
		taskSchduler.setPoolSize(10);
		taskSchduler.setThreadNamePrefix("rank-count-task-");
		taskSchduler.initialize();
		
		taskRegistrar.setTaskScheduler(taskSchduler);
	}

}
