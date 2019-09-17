package com.kh.urbantable.cart.model.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.cart.model.dao.CartDAO;
import com.kh.urbantable.cart.model.vo.Cart;

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
	

}
