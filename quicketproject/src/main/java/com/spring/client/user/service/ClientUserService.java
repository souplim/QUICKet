package com.spring.client.user.service;


import java.util.List;


import com.spring.client.user.vo.UserVO;

public interface ClientUserService {
	public UserVO userLoginProcess(UserVO login);
	public UserVO userInfo(UserVO uvo);
	public int userJoin(UserVO user) throws Exception;
	public int setNewPwd(UserVO user) throws Exception;
	public int userUpdate(UserVO user) throws Exception;
	public int userDelete(UserVO user) throws Exception;
	public List<UserVO> searchIdPhone(String u_name, String u_phone);
	public List<UserVO> searchIdEmail(String u_name, String u_email);
	public int userConfirm(String u_name, String u_id, String u_email);
	public int newPwd(UserVO user) throws Exception;
	public int idCheck(String u_id);
}
