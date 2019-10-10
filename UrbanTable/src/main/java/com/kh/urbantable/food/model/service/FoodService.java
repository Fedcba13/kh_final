package com.kh.urbantable.food.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kh.urbantable.admin.model.vo.Good;
import com.kh.urbantable.event.model.vo.Event;
import com.kh.urbantable.food.model.vo.Food;
import com.kh.urbantable.food.model.vo.FoodSection;
import com.kh.urbantable.food.model.vo.FoodUpper;
import com.kh.urbantable.food.model.vo.FoodWithStockAndEvent;
import com.kh.urbantable.marketOwner.model.vo.Market;
import com.kh.urbantable.recipe.model.vo.RelatedRecipe;

public interface FoodService {

	// food 카테고리로 불러오기
	List<FoodWithStockAndEvent> selectFoodListByCat(Map<String, String> param);

	// foodList view 카테고리 표시
	List<FoodUpper> getSubUpperList(String searchNo);

	List<FoodSection> getSubSectList(String searchNo);

	List<FoodSection> selectBrotherSectList(String upperNo);

	// sect로 조회시 형제 가져오늘 upperNo
	String getUpperNoBySectNo(String searchNo);

	// foodList view markeList 표시
	List<Market> selectMarketList();
	
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

	Market getMarket(String marketNo);


}
