package com.spring.admin.coupon.vo;

import org.springframework.web.multipart.MultipartFile;

import com.spring.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class AdminCouponVO extends CommonVO{
	
	private String c_num;
	private String c_name;
	private int c_discount;
	private String c_startdate;
	private String c_enddate;
	private String c_regdate;
	private String c_update;
	private String c_startissue;
	private String c_endissue;
	
	private MultipartFile file;		// 파일 업로드를 위한 필드 (사용자가 업로드 하는)
	private String c_img = "";		// 실제 서버에 저장할 파일명
	

}
