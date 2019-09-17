package com.kh.urbantable.cart.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.urbantable.cart.model.vo.Cart;

@Repository
public class CartDAOImpl implements CartDAO{
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public List<Cart> getCartList(String memberId) {
		return sqlSession.selectList("cart.getList", memberId);
	}

	@Override
	public Map<String, String> getFoodInfo(String foodNo) {
		return sqlSession.selectOne("cart.getFoodInfo", foodNo); 
	}

}
