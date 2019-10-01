package com.kh.urbantable.food.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kh.urbantable.event.model.vo.Event;
import com.kh.urbantable.food.model.vo.FoodDivision;
import com.kh.urbantable.food.model.vo.FoodSection;
import com.kh.urbantable.food.model.vo.FoodUpper;
import com.kh.urbantable.food.model.vo.FoodWithStockAndEvent;
import com.kh.urbantable.marketOwner.model.vo.Market;

public interface FoodDAO {
	List<FoodDivision> selectFoodDivisionList();

	List<FoodUpper> selectFoodUpperList();

	List<FoodWithStockAndEvent> selectFoodListByCat(Map<String, String> param);

	List<FoodUpper> getSubUpperList(String searchNo);

	List<Market> selectMarketList();

	List<FoodSection> getSubSectList(String searchNo);

	String getUpperNoBySectNo(String searchNo);

	List<FoodSection> selectBrotherSectList(String upperNo);

	int selectEventPercent(FoodWithStockAndEvent food);

	FoodWithStockAndEvent selectFood(HashMap<String, String> param);

}
