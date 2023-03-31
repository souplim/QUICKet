package com.spring.client.user.vo;

import com.spring.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class UserVO extends CommonVO{
	private String u_id;
	private int u_num;
	private String u_pwd;
	private String u_name;
	private String u_gender;
	private String u_birth;
	private String u_email;
	private String u_phone;
	private String u_regdate;
	private String u_moddate;
	private String u_pwddate;
	private int u_state;
}