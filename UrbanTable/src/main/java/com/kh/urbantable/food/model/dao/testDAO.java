package com.kh.urbantable.food.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.urbantable.food.model.vo.Food;
import com.kh.urbantable.food.model.vo.FoodSection;
@Repository
public class testDAO {
	
	@Autowired
	SqlSessionTemplate sqlSession;

	public void insertTest(String string) {
		 sqlSession.insert("t.inserTest", string);
	}


	public List<FoodSection> getfoodSectionList() {
		return sqlSession.selectList("t.getfoodSectionList");
	}


	public int insertFoodToDB(Food insertFood) {
		return sqlSession.insert("t.insertFoodToDB", insertFood);
	}
	
	
	
}
