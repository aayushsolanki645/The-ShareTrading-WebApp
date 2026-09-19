package com.univ.repo;

import org.springframework.data.repository.CrudRepository;

import com.univ.pojo.Account;

public interface AccRepo extends CrudRepository<Account, String> {
	Account findByUsername(String user);
}
