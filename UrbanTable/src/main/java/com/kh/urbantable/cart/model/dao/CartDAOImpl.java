package com.kh.urbantable.cart.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.urbantable.cart.model.vo.Cart;
import com.kh.urbantable.marketOwner.model.vo.Market;

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

	@Override
	public List<Market> getMarketList() {
		return sqlSession.selectList("cart.getMarketList");
	}

	@Override
	public int getProductStock(Map<String, String> map) {
		return sqlSession.selectOne("cart.getProductStock", map);
	}

	@Override
	public int getExist(Map<String, String> map) {
		return sqlSession.selectOne("cart.getExist", map);
	}

	@Override
	public String getFoodSection(String foodNo) {
		return sqlSession.selectOne("cart.getFoodSection", foodNo);
	}

	@Override
	public List<Map<String, Object>> getDiscountList() {
		return sqlSession.selectList("cart.getDiscountList");
	}

	@Override
	public int deleteCart(Map<String, String> map) {
		return sqlSession.delete("cart.deleteCart", map);
	}

}
