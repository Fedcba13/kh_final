package com.kh.urbantable.foodOrder.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FoodOrderDAOImpl implements FoodOrderDAO {

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public String selectMarketNoByMemberId(String memberId) {
		return sqlSession.selectOne("marketOwner.selectMarketNoByMemberId", memberId);
	}
	
}
