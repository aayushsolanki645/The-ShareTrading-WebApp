package com.univ.repo;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.univ.pojo.StockInfo;
import com.univ.pojo.UserInfo;

public interface StockInfoRepo extends CrudRepository<StockInfo, Integer> {
	
	long count();
	List<StockInfo> findAll();
	StockInfo findBySid(int id);
	List<StockInfo> findBySname(String sname);
	
}
