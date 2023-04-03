package com.spring.admin.coupon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.admin.coupon.dao.AdminCouponDao;
import com.spring.admin.coupon.vo.AdminCouponVO;
import com.spring.common.file.FileUploadUtil;

import lombok.Setter;

@Service
public class AdminCouponServiceImpl implements AdminCouponService {

	@Setter(onMethod_ = @Autowired)
	private AdminCouponDao adminCouponDao;
	
	@Override
	public List<AdminCouponVO> couponList(AdminCouponVO vo) {
		List<AdminCouponVO> list = null;
		list = adminCouponDao.couponList(vo);
		return list;
	}

	@Override
	public int couponListCnt(AdminCouponVO vo) {
		int count = 0;
		count = adminCouponDao.couponListCnt(vo);
		return count;
	}

	@Override
	public int insertCoupon(AdminCouponVO vo) throws Exception {
		int result = 0;

		
		if(vo.getFile().getSize() > 0) { 	// 업로드할 파일이 존재하면 (파일의 크기를 기준으로 존재 여부 판단)
			String fileName = FileUploadUtil.fileUpload(vo.getFile(), "coupon"); 	// board_1658205347977_cat.jpg
			vo.setC_img(fileName);
			
	
		} 	// 파일이 존재하지 않으면 파일 없는 채로 insert
		
		result = adminCouponDao.insertCoupon(vo);
		return result;
	}
	
	

}
