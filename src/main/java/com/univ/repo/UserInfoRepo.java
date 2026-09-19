package com.univ.repo;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;

import com.univ.pojo.UserInfo;

public interface UserInfoRepo extends CrudRepository<UserInfo, Integer> {
		
	Optional<UserInfo> findUserInfoByEmailAndPassword(String email, String password);
	long count();
	List<UserInfo> findByStatus(String status);
	UserInfo findByUid(int id);
	List<UserInfo> findAll();
	List<UserInfo> findByFname(String fname);
	UserInfo findByEmail(String otp);
	
	
}
