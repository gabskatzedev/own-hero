package com.revature.grocery.list.repo;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.revature.grocery.list.model.GroceryItem;

public interface GroceryItemDao extends CrudRepository<GroceryItem, Integer>{

	//GET METHODS
	public List<GroceryItem> findAll();
	
	public GroceryItem findById(int id);
	
	public List<GroceryItem> findByCategory(String category);
	
	public GroceryItem save(GroceryItem groceryItem);
	
	public List<GroceryItem> findByGroceryListId(int groceryListId);
}
