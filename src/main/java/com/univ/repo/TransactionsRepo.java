package com.univ.repo;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;

import com.univ.pojo.Transactions;

public interface TransactionsRepo extends CrudRepository<Transactions, Integer> {
	Transactions findByTid(int tid);
	List<Transactions> findAll();
	List<Transactions> findByUsername(String username);
	List<Transactions> findBySnameAndWd(String sname,String wd);
	Transactions findTopByUsernameOrderByTidDesc(String username);
}
