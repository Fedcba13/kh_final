package com.kh.urbantable.food.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kh.urbantable.admin.model.vo.Good;
import com.kh.urbantable.event.model.vo.Event;
import com.kh.urbantable.food.model.vo.Food;
import com.kh.urbantable.food.model.vo.FoodDivision;
import com.kh.urbantable.food.model.vo.FoodSection;
import com.kh.urbantable.food.model.vo.FoodUpper;
import com.kh.urbantable.food.model.vo.FoodWithStockAndEvent;
import com.kh.urbantable.marketOwner.model.vo.Market;
import com.kh.urbantable.recipe.model.vo.RelatedRecipe;

public interface FoodDAO {
	List<FoodDivision> selectFoodDivisionList();

	List<FoodUpper> selectFoodUpperList();

	List<FoodWithStockAndEvent> selectFoodListByCat(Map<String, String> param);

	List<FoodUpper> getSubUpperList(String searchNo);

	List<Market> selectMarketList();

	List<FoodSection> getSubSectList(String searchNo);

	String getUpperNoBySectNo(String searchNo);

	List<FoodSection> selectBrotherSectList(String upperNo);

	FoodWithStockAndEvent selectFood(HashMap<String, String> param);

	List<FoodSection> getFoodSectionList();

	List<FoodUpper> getUpperListToInsertFood(String foodDivisionNo);

	List<FoodSection> getSectionListToInsertFood(String foodSectionNo);

	int insertFood(Food food);

	List<FoodWithStockAndEvent> selectFoodInMain1();

	List<FoodWithStockAndEvent> selectFoodInMain2();

	List<FoodWithStockAndEvent> selectFoodInMain3(String foodDivisionNo);

	List<FoodWithStockAndEvent> selectFoodInMain4();

	List<FoodWithStockAndEvent> selectNewFoodList(String marketNo);

	List<FoodWithStockAndEvent> selectBestFoodList(Map<String, String> param);

	List<RelatedRecipe> selectRelatedRecipe(String foodNo);

	List<FoodWithStockAndEvent> selectNeedToOrderListListByCat(Map<String, String> param);

	List<FoodWithStockAndEvent> selectFoodBySearchKeyword(Map<String, String> param);

	Good selectGoodOne(Map<String, String> param);

	int cancelGood(Map<String, String> param);

	int changeGood(Map<String, String> param);

	int updateGood(Map<String, String> param);

	Good selectGoodTotal(String foodNo);

	List<FoodWithStockAndEvent> selectSaleFoodList(String marketNo);

	int insertGood(Map<String, String> param);

	FoodWithStockAndEvent selectNoStockFood(HashMap<String, String> param);

}
