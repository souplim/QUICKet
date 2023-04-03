package com.spring.admin.login.dao;

import org.apache.ibatis.annotations.Mapper;

import com.spring.admin.login.vo.AdminLoginVO;

@Mapper
public interface AdminLoginDao {
	public AdminLoginVO loginProcess(AdminLoginVO login);
}
