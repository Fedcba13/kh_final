package com.kh.urbantable.food.model.service;

import java.util.List;
import java.util.Map;

import com.kh.urbantable.food.model.vo.Food;
import com.kh.urbantable.food.model.vo.FoodSection;
import com.kh.urbantable.food.model.vo.FoodUpper;
import com.kh.urbantable.marketOwner.model.vo.Market;

public interface FoodService {

	// food 카테고리로 불러오기
	List<Food> selectFoodListByCat(Map<String, String> param);

	// foodList view 카테고리 표시
	List<FoodUpper> getSubUpperList(String searchNo);

	List<FoodSection> getSubSectList(String searchNo);

	List<FoodSection> selectBrotherSectList(String upperNo);

	// sect로 조회시 형제 가져오늘 upperNo
	String getUpperNoBySectNo(String searchNo);

	// foodList view markeList 표시
	List<Market> selectMarketList();

}
