package com.kh.urbantable.food.model.service;

import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.food.model.dao.FoodDAO;
import com.kh.urbantable.food.model.vo.Food;
import com.kh.urbantable.food.model.vo.FoodDivision;
import com.kh.urbantable.food.model.vo.FoodSection;

@Service
public class FoodServiceImpl implements FoodService {
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	public static List<FoodSection> foodSectionList = null;
	public static List<FoodDivision> foodDivisionList = null;
		
	
	@Autowired
	private FoodDAO foodDAO;

	@PostConstruct
	public void init() {
		foodSectionList = foodDAO.selectFoodSectionList();
		foodDivisionList = foodDAO.selectFoodDivisionList();
		
	}
	@Override
	public List<FoodSection> selectFoodSectionList() {
		return foodDAO.selectFoodSectionList();
	}


	@Override
	public List<Food> selectFoodByDiv(String foodDivisionNo) {
		return foodDAO.selectFoodByDiv(foodDivisionNo);
	}
	@Override
	public List<Food> selectFoodByUpper(Map<String, String> param) {
		return foodDAO.selectFoodByUpper(param);
	}
	@Override
	public List<FoodSection> selectSubSectionList(String foodDivisionNo) {
		return foodDAO.selectSubSectionList(foodDivisionNo);
	}
	@Override
	public List<FoodSection> selectFoodSectionNameList(Map<String, String> param) {
		return foodDAO.selectFoodSectionNameList(param);
	}
	@Override
	public List<Food> selectFoodBySect(Map<String, String> param) {
		return foodDAO.selectFoodBySect(param);
	}
}
