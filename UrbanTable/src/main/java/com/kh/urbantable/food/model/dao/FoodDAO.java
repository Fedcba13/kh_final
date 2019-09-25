package com.kh.urbantable.food.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.urbantable.food.model.vo.Food;
import com.kh.urbantable.food.model.vo.FoodDivision;
import com.kh.urbantable.food.model.vo.FoodSection;

public interface FoodDAO {

	List<FoodSection> selectFoodSectionList();

	List<FoodDivision> selectFoodDivisionList();

	List<Food> selectFoodByDiv(String foodDivisionNo);

	List<Food> selectFoodByUpper(Map<String, String> param);

	List<FoodSection> selectSubSectionList(String foodDivisionNo);

	List<FoodSection> selectFoodSectionNameList(Map<String, String> param);

	List<Food> selectFoodBySect(Map<String, String> param);

}
