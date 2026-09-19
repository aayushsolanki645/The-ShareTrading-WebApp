package com.univ.dao;


import com.univ.pojo.UserInfo;

public interface UserDao {
	UserInfo checkUser(UserInfo u);
	boolean addUser(UserInfo u);
}
