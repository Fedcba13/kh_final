package com.kh.urbantable.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.urbantable.foodOrder.model.vo.MarketOrderDetail;
import com.kh.urbantable.recipe.model.vo.Blame;

@Repository
public class CheckDAOImpl implements CheckDAO{

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public List<Map<String, Object>> selectAllList() {
		
		return sqlSession.selectList("check.selectAllList");
	}

	@Override
	public int selectFoodNo(Map<String, Object> param) {
		
		return sqlSession.selectOne("check.selectFoodNo", param);
	}

	@Override
	public int updateAmount(Map<String, Object> param) {
		
		return sqlSession.update("check.updateAmount", param);
	}

	@Override
	public int updateFlag(String orderNo) {
		
		return sqlSession.update("check.updateFlag", orderNo);
	}

	@Override
	public int insertFood(Map<String, Object> param) {

		return sqlSession.insert("check.insertFood", param);
	}

	@Override
	public List<MarketOrderDetail> selectMODList(String orderNo) {
		
		return sqlSession.selectList("check.selectMODList", orderNo);
	}

	@Override
	public List<Blame> selectBlameList() {
		
		return sqlSession.selectList("check.selectBlameList");
	}
	
	
}
