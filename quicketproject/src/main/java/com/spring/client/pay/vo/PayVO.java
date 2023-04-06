package com.spring.client.pay.vo;




import lombok.Data;

@Data
public class PayVO {
	private int pay_num=0;		//결제번호
	private String pay_name="";	//이름
	private String pay_phone="";	//전화번호
	private String pay_email="";	//이메일
	private int pay_amount=0;		//결제금액
	private	int pay_status=0;		//결제상태
	private String u_id="";		//회원아이디
	
	private String ti_date = ""; //날짜
	private String s_name = "";	//공연명
	
	private String imp_uid = "";
	private String merchant_id = "";
	private String token = "";
	private String amount = "";
	private String reason = "";
	
	
	
}

