package com.revature.grocery.list.viewModel;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GroceryItemViewModel {

	private int id;

	private String name;	

	private String description;
	
	private String image;
	
	private String category;
	
	private double price;
	
	private int quantity;
}
