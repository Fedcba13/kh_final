package com.kh.urbantable.food.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.urbantable.food.model.vo.Food;
import com.kh.urbantable.food.model.vo.FoodDivision;
import com.kh.urbantable.food.model.vo.FoodSection;
import com.kh.urbantable.marketOwner.model.vo.Market;

@Repository
public class FoodDAOImpl implements FoodDAO {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<FoodSection> selectFoodSectionList() {
		return sqlSession.selectList("food.selectFoodSectionList");
	}

	@Override
	public List<FoodDivision> selectFoodDivisionList() {
		return sqlSession.selectList("food.selectFoodDivisionList");
	}

	@Override
	public List<Food> selectFoodByDiv(Map<String, String> param) {
		return sqlSession.selectList("food.selectFoodByDiv", param);
	}

	@Override
	public List<Food> selectFoodByUpper(Map<String, String> param) {
		return sqlSession.selectList("food.selectFoodByUpper", param);
	}

	@Override
	public List<FoodSection> selectSubSectionList(String foodDivisionNo) {
		return sqlSession.selectList("food.selectSubSectionList", foodDivisionNo);
	}

	@Override
	public List<FoodSection> selectFoodSectionNameList(Map<String, String> param) {
		return sqlSession.selectList("food.selectFoodSectionNameList", param);
	}

	@Override
	public List<Food> selectFoodBySect(Map<String, String> param) {
		return sqlSession.selectList("food.selectFoodBySect", param);
	}

	@Override
	public List<Market> selectMarketList() {
		return sqlSession.selectList("food.selectMarketList");
	}

}
