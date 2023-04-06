package com.spring.admin.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.admin.user.dao.AdminUserDao;
import com.spring.client.mypage.vo.MypageVO;
import com.spring.client.user.vo.UserVO;

import lombok.Setter;

@Service
public class AdminUserServiceImpl implements AdminUserService {

	@Setter(onMethod_ = @Autowired)
	private AdminUserDao adminUserDao;
	
	@Override
	public List<UserVO> userList(UserVO vo) {
		List<UserVO> uList = null;
		uList = adminUserDao.userList(vo);
		
		return uList;
	}

	@Override
	public int userListCnt(UserVO vo) {
		int count = 0;
		count = adminUserDao.userListCnt(vo);
		
		return count;
	}

	@Override
	public int userDelete(UserVO vo) throws Exception {
		int result = 0;
		
		result = adminUserDao.userDelete(vo.getU_num());
		
		return result;
	}

	@Override
	public List<MypageVO> userCouponList(String u_id) {
		List<MypageVO> userCouponList = null;
		userCouponList = adminUserDao.userCouponList(u_id);
		return userCouponList;
	}

	@Override
	public List<MypageVO> userTicketList(String u_id) {
		List<MypageVO> userTicketList = null;
		userTicketList = adminUserDao.userTicketList(u_id);
		return userTicketList;
	}

	
	

}
