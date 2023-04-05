package com.spring.admin.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.mypage.vo.MypageVO;
import com.spring.client.user.vo.UserVO;

@Mapper
public interface AdminUserDao {
	public List<UserVO> userList(UserVO vo);
	public int userListCnt(UserVO vo);
	public int userDelete(int u_num);
	public List<MypageVO> userCouponList(String u_id);
}
