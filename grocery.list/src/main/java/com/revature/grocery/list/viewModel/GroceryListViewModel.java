package com.revature.grocery.list.viewModel;

import java.util.Set;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class GroceryListViewModel {
	
	private int id;
	
	private String name;
	
	private Set<GroceryItemViewModel> groceryItems;
}
