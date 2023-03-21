package com.spring.client.show.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/*")
public class ClientShowController {
	
	@GetMapping("/")
	public String mainPage() {
		return "client/show/mainPage";
	}
	
	@GetMapping("/genre")
	public String genrePage() {
		return "client/show/genrePage";
	}

}
