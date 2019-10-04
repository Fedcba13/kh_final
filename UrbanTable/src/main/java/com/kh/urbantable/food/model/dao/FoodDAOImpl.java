package com.kh.urbantable.food.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.urbantable.food.model.vo.Food;
import com.kh.urbantable.food.model.vo.FoodDivision;
import com.kh.urbantable.food.model.vo.FoodSection;
import com.kh.urbantable.food.model.vo.FoodUpper;
import com.kh.urbantable.food.model.vo.FoodWithStockAndEvent;
import com.kh.urbantable.marketOwner.model.vo.Market;

@Repository
public class FoodDAOImpl implements FoodDAO {
	private Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<FoodDivision> selectFoodDivisionList() {
		return sqlSession.selectList("food.selectFoodDivisionList");
	}

	@Override
	public List<FoodUpper> selectFoodUpperList() {
		return sqlSession.selectList("food.selectFoodUpperList");
	}

	@Override
	public List<Market> selectMarketList() {
		return sqlSession.selectList("food.selectMarketList");
	}

	@Override
	public List<FoodWithStockAndEvent> selectFoodListByCat(Map<String, String> param) {
		return sqlSession.selectList("food.selectFoodListByCat", param);

	}

	@Override
	public List<FoodUpper> getSubUpperList(String searchNo) {
		return sqlSession.selectList("food.getSubUpperList", searchNo);
	}

	@Override
	public List<FoodSection> getSubSectList(String searchNo) {
		return sqlSession.selectList("food.getSubSectList", searchNo);
	}

	@Override
	public String getUpperNoBySectNo(String searchNo) {
		return sqlSession.selectOne("food.getUpperNoBySectNo", searchNo);
	}

	@Override
	public List<FoodSection> selectBrotherSectList(String upperNo) {
		return sqlSession.selectList("food.selectBrotherSectList", upperNo);
	}

	@Override
	public int selectEventPercent(FoodWithStockAndEvent food) {
		return sqlSession.selectOne("food.selectEventPercent", food);
	}

	@Override
	public FoodWithStockAndEvent selectFood(HashMap<String, String> param) {
		return sqlSession.selectOne("food.selectFood", param);
	}

	@Override
	public List<FoodSection> getFoodSectionList() {
		return sqlSession.selectList("food.getFoodSectionList");
	}

	@Override
	public List<FoodUpper> getUpperListToInsertFood(String foodDivisionNo) {
		return sqlSession.selectList("food.getUpperListToInsertFood", foodDivisionNo);
	}

	@Override
	public List<FoodSection> getSectionListToInsertFood(String foodUpperNo) {
		return sqlSession.selectList("food.getSectionListToInsertFood", foodUpperNo);
	}

	@Override
	public int insertFood(Food food) {
		return sqlSession.insert("food.insertFood", food);
	}

	@Override
	public List<FoodWithStockAndEvent> selectFoodInMain1() {
		return sqlSession.selectList("food.selectFoodInMain1");
	}

	@Override
	public List<FoodWithStockAndEvent> selectFoodInMain2() {
		return sqlSession.selectList("food.selectFoodInMain2");
	}

	@Override
	public List<FoodWithStockAndEvent> selectFoodInMain3(String foodDivisionNo) {
		return sqlSession.selectList("food.selectFoodInMain3", foodDivisionNo);
	}

	@Override
	public List<FoodWithStockAndEvent> selectFoodInMain4() {
		return sqlSession.selectList("food.selectFoodInMain4");
	}



}
