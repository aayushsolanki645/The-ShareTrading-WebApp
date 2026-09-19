package com.univ.repo;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.univ.pojo.Cart;

public interface CartRepo extends CrudRepository<Cart, Integer> {
	List<Cart> findByUsernameAndStatus(String email,String status);
	Cart findByCid(int id); 
}
