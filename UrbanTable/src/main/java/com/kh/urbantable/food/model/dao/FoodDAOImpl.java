package com.kh.urbantable.food.model.dao;

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
	public List<Food> selectFoodListByCat(Map<String, String> param) {
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
	public List<Food> selectFoodByDiv(Map<String, String> param) {
		return sqlSession.selectList("food.selectFoodByDiv", param);
	}

	@Override
	public List<FoodSection> selectBrotherSectList(String upperNo) {
		return sqlSession.selectList("food.selectBrotherSectList", upperNo);
	}

}
