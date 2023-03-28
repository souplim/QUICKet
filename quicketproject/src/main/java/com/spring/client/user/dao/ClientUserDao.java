package com.spring.client.user.dao;

<<<<<<< HEAD
import java.util.List;
=======
//import java.util.List;
>>>>>>> 3426caeb608bf1188635703f62a14c7ccddc2022

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.user.vo.UserVO;

@Mapper
public interface ClientUserDao {
	public UserVO userLoginProcess(UserVO login);
	public UserVO userInfo(UserVO uvo);
<<<<<<< HEAD
	public int userJoin(UserVO user) throws Exception;
=======
	/*public int userJoin(UserVO user) throws Exception;
>>>>>>> 3426caeb608bf1188635703f62a14c7ccddc2022
	public int setNewPwd(UserVO user) throws Exception;
	public int userUpdate(UserVO user) throws Exception;
	public int userDelete(UserVO user) throws Exception;
	public List<UserVO> searchIdPhone(String u_name, String u_phone);
	public List<UserVO> searchIdEmail(String u_name, String u_email);
	public int userConfirm(String u_name, String u_id, String u_email);

<<<<<<< HEAD
}
=======
*/}
>>>>>>> 3426caeb608bf1188635703f62a14c7ccddc2022
