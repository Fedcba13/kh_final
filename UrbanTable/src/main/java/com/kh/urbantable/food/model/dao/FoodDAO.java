package com.kh.urbantable.food.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.urbantable.food.model.vo.Food;
import com.kh.urbantable.food.model.vo.FoodDivision;
import com.kh.urbantable.food.model.vo.FoodSection;
import com.kh.urbantable.food.model.vo.FoodUpper;
import com.kh.urbantable.marketOwner.model.vo.Market;

public interface FoodDAO {
	List<FoodDivision> selectFoodDivisionList();

	List<FoodUpper> selectFoodUpperList();

	List<Food> selectFoodListByCat(Map<String, String> param);

	List<FoodUpper> getSubUpperList(String searchNo);

	List<Market> selectMarketList();

	List<Food> selectFoodByDiv(Map<String, String> param);

	List<FoodSection> getSubSectList(String searchNo);

	String getUpperNoBySectNo(String searchNo);

	List<FoodSection> selectBrotherSectList(String upperNo);

}
