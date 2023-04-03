package com.spring.client.user.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.client.user.dao.ClientUserDao;
import com.spring.client.user.vo.UserVO;

import lombok.Setter;

@Service
public class ClientUserServiceImpl implements ClientUserService {

	@Setter(onMethod_ = @Autowired)
	private ClientUserDao clientUserDao;
	
	@Override
	public UserVO userLoginProcess(UserVO login) {
		UserVO userLogin = null;
		userLogin = clientUserDao.userLoginProcess(login);
		return userLogin;
	}

	@Override
	public UserVO userInfo(UserVO uvo) {
		UserVO vo = null;
		vo = clientUserDao.userInfo(uvo);
		
		return vo;
	}

	@Override
	public int userJoin(UserVO user) throws Exception {
		int result = 0; 
		
		result = clientUserDao.userJoin(user);
		return result;
	}

	@Override
	public int setNewPwd(UserVO user) throws Exception {
		int result = 0;
		
		result = clientUserDao.setNewPwd(user);
		return result;
	}
	

	@Override
	public int userUpdate(UserVO user) throws Exception {
		int result = 0;
		
		result = clientUserDao.userUpdate(user);
		
		return result;
	}

	@Override
	public int userDelete(UserVO user) throws Exception {
		int result = 0;
		result = clientUserDao.userDelete(user);
		return result;
	}

	@Override
	public List<UserVO> searchIdPhone(String u_name, String u_phone) {
		List<UserVO> list = null;
		list = clientUserDao.searchIdPhone(u_name, u_phone);
		return list;
	}

	@Override
	public List<UserVO> searchIdEmail(String u_name, String u_email) {
		List<UserVO> list = null;
		list = clientUserDao.searchIdEmail(u_name, u_email);
		return list;
	}

	@Override
	public int userConfirm(String u_name, String u_id, String u_email) {
		int result = 0;
		result = clientUserDao.userConfirm(u_name, u_id, u_email);
		return result;
	}

	@Override
	public int newPwd(UserVO user) throws Exception {
		int result = 0;
		result = clientUserDao.newPwd(user);
		return result;
	}

	@Override
	public int idCheck(String u_id) {
		int result = 0;
		result = clientUserDao.idCheck(u_id);
		
		return result;
	}

	
	

}
