package com.kh.urbantable.food.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.event.model.vo.Event;
import com.kh.urbantable.food.model.dao.FoodDAO;
import com.kh.urbantable.food.model.vo.Food;
import com.kh.urbantable.food.model.vo.FoodDivision;
import com.kh.urbantable.food.model.vo.FoodSection;
import com.kh.urbantable.food.model.vo.FoodUpper;
import com.kh.urbantable.food.model.vo.FoodWithStockAndEvent;
import com.kh.urbantable.marketOwner.model.vo.Market;

@Service
public class FoodServiceImpl implements FoodService {
	private Logger logger = LoggerFactory.getLogger(getClass());

	public static List<FoodDivision> foodDivisionList = null;
	public static List<FoodUpper> foodUpperList = null;
	public static List<Market> marketList = null;

	@Autowired
	private FoodDAO foodDAO;

	@PostConstruct
	public void init() {
		foodDivisionList = foodDAO.selectFoodDivisionList();
		foodUpperList = foodDAO.selectFoodUpperList();
		marketList = foodDAO.selectMarketList();
	}

	@Override
	public List<FoodWithStockAndEvent> selectFoodListByCat(Map<String, String> param) {
		return foodDAO.selectFoodListByCat(param);
	}

	@Override
	public List<FoodUpper> getSubUpperList(String searchNo) {
		return foodDAO.getSubUpperList(searchNo);
	}

	@Override
	public List<FoodSection> getSubSectList(String searchNo) {
		return foodDAO.getSubSectList(searchNo);
	}

	@Override
	public List<Market> selectMarketList() {
		return foodDAO.selectMarketList();
	}

	@Override
	public String getUpperNoBySectNo(String searchNo) {
		return foodDAO.getUpperNoBySectNo(searchNo);
	}

	@Override
	public List<FoodSection> selectBrotherSectList(String upperNo) {
		return foodDAO.selectBrotherSectList(upperNo);
	}


	@Override
	public int selectEventPercent(FoodWithStockAndEvent food) {
		return foodDAO.selectEventPercent(food);
	}

	@Override
	public FoodWithStockAndEvent selectFood(HashMap<String, String> param) {
		return foodDAO.selectFood(param);
	}

	@Override
	public List<FoodSection> getFoodSectionList() {
		return foodDAO.getFoodSectionList();
	}

	@Override
	public List<FoodUpper> getUpperListToInsertFood(String foodDivisionNo) {
		return foodDAO.getUpperListToInsertFood(foodDivisionNo);
	}

	@Override
	public List<FoodSection> getSectionListToInsertFood(String foodUpperNo) {
		return foodDAO.getSectionListToInsertFood(foodUpperNo);
	}

	@Override
	public int insertFood(Food food) {
		return foodDAO.insertFood(food);
	}

	@Override
	public List<FoodWithStockAndEvent> selectFoodInMain1() {
		return foodDAO.selectFoodInMain1();
	}

	@Override
	public List<FoodWithStockAndEvent> selectFoodInMain2() {
		return foodDAO.selectFoodInMain2();
	}

	@Override
	public List<FoodWithStockAndEvent> selectFoodInMain3(String foodDivisionNo) {
		return foodDAO.selectFoodInMain3(foodDivisionNo);
	}

	@Override
	public List<FoodWithStockAndEvent> selectFoodInMain4() {
		return foodDAO.selectFoodInMain4();
	}


}
