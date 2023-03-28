package com.spring.admin.user.service;

import java.util.List;

import com.spring.client.user.vo.UserVO;

public interface AdminUserService {
	public List<UserVO> userList(UserVO vo);
	public int userListCnt(UserVO vo);
	public int userDelete(UserVO vo) throws Exception;
}
