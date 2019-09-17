package com.kh.urbantable.cart.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.urbantable.cart.model.vo.Cart;

public interface CartDAO {

	List<Cart> getCartList(String memberId);

	Map<String, String> getFoodInfo(String foodNo);
	

}
