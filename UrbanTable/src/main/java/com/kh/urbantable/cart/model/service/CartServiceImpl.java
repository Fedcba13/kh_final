package com.kh.urbantable.cart.model.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.cart.model.dao.CartDAO;
import com.kh.urbantable.cart.model.vo.Cart;
import com.kh.urbantable.marketOwner.model.vo.Market;

@Service
public class CartServiceImpl implements CartService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	CartDAO cartDAO;

	@Override
	public List<Cart> getCartList(String memberId) {
		return cartDAO.getCartList(memberId);
	}

	@Override
	public Map<String, String> getFoodInfo(String foodNo) {
		return cartDAO.getFoodInfo(foodNo);
	}

	@Override
	public List<Market> getMarketList() {
		return cartDAO.getMarketList();
	}

	@Override
	public int getProductStock(Map<String, String> map) {
		return cartDAO.getProductStock(map);
	}

	@Override
	public int getExist(Map<String, String> map) {
		return cartDAO.getExist(map);
	}

	@Override
	public String getFoodSection(String foodNo) {
		return cartDAO.getFoodSection(foodNo);
	}

	@Override
	public List<Map<String, Object>> getDiscountList() {
		return cartDAO.getDiscountList();
	}

	@Override
	public int deleteCart(Map<String, String> map) {
		return cartDAO.deleteCart(map);
	} 
	

}
