package com.kh.urbantable.foodOrder.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.urbantable.foodOrder.model.vo.MarketOrder;
import com.kh.urbantable.foodOrder.model.vo.MarketOrderDetail;

@Repository
public class FoodOrderDAOImpl implements FoodOrderDAO {

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public String selectMarketNoByMemberId(String memberId) {
		return sqlSession.selectOne("marketOwner.selectMarketNoByMemberId", memberId);
	}

	@Override
	public int insertMarketOrder(MarketOrder marketOrder) {
		return sqlSession.insert("foodOrder.insertMarketOrder", marketOrder);
	}

	@Override
	public int insertMarketOrderDetail(MarketOrderDetail marketOrderDetail) {
		return sqlSession.insert("foodOrder.insertMarketOrderDetail", marketOrderDetail);
	}

	@Override
	public int deleteMarketCart(Map<String, String> param) {
		return sqlSession.delete("foodOrder.deleteMarketCart", param);
	}
	
}
