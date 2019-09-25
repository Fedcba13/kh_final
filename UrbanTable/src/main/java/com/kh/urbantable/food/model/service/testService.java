package com.kh.urbantable.food.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.food.model.dao.testDAO;
import com.kh.urbantable.food.model.vo.Food;
import com.kh.urbantable.food.model.vo.FoodSection;

@Service
public class testService {

	@Autowired
	testDAO td = new testDAO();

	public void insertTest(String string) {
		td.insertTest(string);
	}

	public List<FoodSection> getfoodSectionList() {
		return td.getfoodSectionList();
	}

	public int insertFoodToDB(Food insertFood) {
		return td.insertFoodToDB(insertFood);
	}
}
