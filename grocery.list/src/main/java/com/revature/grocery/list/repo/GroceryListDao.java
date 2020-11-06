package com.revature.grocery.list.repo;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.revature.grocery.list.model.GroceryList;

public interface GroceryListDao extends CrudRepository<GroceryList, Integer>{

	public List<GroceryList> findAll();
	
	public GroceryList findById(int id);
	
}
