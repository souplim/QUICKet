package com.spring;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication
public class QuicketprojectApplication {

	public static void main(String[] args) {
		SpringApplication.run(QuicketprojectApplication.class, args);
	}

}
