package com.spring.admin.ticket.controller;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.client.pay.service.PaymentService;
import com.spring.client.pay.vo.PayVO;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/payment")
public class PaymentApiController {

    private final PaymentService paymentService;

	/*
	 * @PostMapping("/record") public ResponseEntity<?>
	 * paymentRecordGenerateBeforePg(@Valid @RequestBody PaymentRequest
	 * paymentRequest, @CurrentUser User user) { PaymentResponse paymentResponse =
	 * paymentService.paymentRecordGenerateBeforePg(paymentRequest, user);
	 * 
	 * return ResponseEntity.ok(paymentResponse); }
	 */

    @PostMapping("/complete")
    public String paymentResult(@RequestBody String imp_uid) throws IOException {
        System.out.println("imp_uid : " + imp_uid);

        String token = paymentService.getToken();
        System.out.println("token : " + token);
        
        Pattern pattern = Pattern.compile("(imp_\\d)\\d*");
        String reg = imp_uid;
        String matcherVal = "";
        Matcher matcher = pattern.matcher(reg);
        while (matcher.find()) {
           matcherVal = matcher.group();
        }
        return matcherVal+","+token;
    }
    
    @PostMapping("/cancel")
    public String cancelResult(@RequestBody PayVO vo) throws IOException {

        String access_token = vo.getToken();
		String imp_uid = vo.getImp_uid();
		int amount	= Integer.parseInt(vo.getAmount());
		String reason = vo.getReason();
		paymentService.payMentCancle(access_token, imp_uid, amount,reason);
		
		
        return "hello";
    }
}