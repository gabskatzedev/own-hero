package com.revature.grocery.list.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.revature.grocery.list.model.GroceryItem;
import com.revature.grocery.list.model.GroceryList;
import com.revature.grocery.list.repo.GroceryItemDao;
import com.revature.grocery.list.repo.GroceryListDao;
import com.revature.grocery.list.viewModel.GroceryItemViewModel;
import com.revature.grocery.list.viewModel.GroceryListViewModel;

@RestController
@RequestMapping("/grocery")
@CrossOrigin
public class GroceryListController {

	@Autowired
	private GroceryItemDao groceryItemDao;
	
	@Autowired
	private GroceryListDao groceryListDao;
		
	//GET ALL GROCERY ITEMS
	@RequestMapping("getAllItems")
	public List<GroceryItemViewModel> getAllItems(){
		List<GroceryItem> groceryItems =groceryItemDao.findAll();
		List<GroceryItemViewModel> result = new ArrayList<GroceryItemViewModel>();
		
		for(GroceryItem item : groceryItems) {
			GroceryItemViewModel newItem = new GroceryItemViewModel(item.getId(), item.getName(), item.getDescription(), item.getImage(), item.getCategory(),item.getPrice(), item.getQuantity());
			result.add(newItem);
		}
		return result;
	}
	
	//GET GROCERY ITEM BY ID
	@RequestMapping("getGroceryById/{id}")
	public GroceryItemViewModel getById(@PathVariable("id") int id) {
		GroceryItem groceryItem = groceryItemDao.findById(id);
		GroceryItemViewModel newItem = new GroceryItemViewModel(groceryItem.getId(), groceryItem.getName(), groceryItem.getDescription(), groceryItem.getImage(), groceryItem.getCategory(), groceryItem.getPrice(), groceryItem.getQuantity());
		return newItem;
	}
	
	//GET GROCERY ITEM BY TYPE
	@RequestMapping("getGroceriesByCategory/{category}")
	public List<GroceryItemViewModel> getByCategory(@PathVariable("category") String category){
		List<GroceryItem> groceryItems = groceryItemDao.findByCategory(category);
		List<GroceryItemViewModel> result = new ArrayList<GroceryItemViewModel>();
		
		for(GroceryItem item : groceryItems) {
			GroceryItemViewModel newItem = new GroceryItemViewModel(item.getId(), item.getName(), item.getDescription(), item.getImage(), item.getCategory(),item.getPrice(), item.getQuantity());
			result.add(newItem);
		}
		return result;
	}
	
	//CREATE A NEW GROCERY ITEM
	@PostMapping("/createGroceryItem")
	public void createGroceryItem(@RequestBody GroceryItem groceryItem) {
		groceryItemDao.save(groceryItem);
	}
	
	//ADD A NEW GROCERY ITEM TO GROCERY LIST
	@PostMapping("/addGroceryItemToList/{listId}/{itemId}")
	public void addGroceryItemToList(@PathVariable("listId") int listId, @PathVariable("itemId") int id) {
		GroceryList groceryList = groceryListDao.findById(listId);
		GroceryItem groceryItem = groceryItemDao.findById(id);
		
		//groceryList.getGroceryItems().add(groceryItem);
		groceryItem.setGroceryList(groceryList);
		groceryItemDao.save(groceryItem);
		
	}
	
	//GET GROCERY LIST BY ID
	@RequestMapping("getGroceryListById/{listId}")
	public List<GroceryItemViewModel> getGroceryListById(@PathVariable("listId") int id) {
//		GroceryList groceryList = groceryListDao.findById(id);
//		Set<GroceryItemViewModel> groceryItems = new HashSet<GroceryItemViewModel>();
//		
//		for(GroceryItem item : groceryList.getGroceryItems()) {
//			GroceryItemViewModel newItem = new GroceryItemViewModel(item.getId(), item.getName(), item.getDescription(), item.getImage(), item.getCategory(),item.getPrice(), item.getQuantity());
//			groceryItems.add(newItem);
//		}
//
//		GroceryListViewModel groceryVM = new GroceryListViewModel(groceryList.getId(), groceryList.getName(), groceryItems);
//		
//		return groceryVM;
		
		
		List<GroceryItem> groceryItems = groceryItemDao.findByGroceryListId(id);
		List<GroceryItemViewModel> result = new ArrayList<GroceryItemViewModel>();
		
		for(GroceryItem item : groceryItems) {
			GroceryItemViewModel newItem = new GroceryItemViewModel(item.getId(), item.getName(), item.getDescription(), item.getImage(), item.getCategory(),item.getPrice(), item.getQuantity());
			result.add(newItem);
		}
		return result;
		

	}
}
