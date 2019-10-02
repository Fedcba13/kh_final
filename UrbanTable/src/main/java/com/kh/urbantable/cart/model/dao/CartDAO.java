package com.kh.urbantable.cart.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.urbantable.cart.model.vo.Cart;
import com.kh.urbantable.marketOwner.model.vo.Market;

public interface CartDAO {

	List<Cart> getCartList(String memberId);

	Map<String, String> getFoodInfo(String foodNo);

	List<Market> getMarketList();

	int getProductStock(Map<String, String> map);

	int getExist(Map<String, String> map);

	String getFoodSection(String foodNo);

	List<Map<String, Object>> getDiscountList();

	int deleteCart(Map<String, String> map);

	int deleteCartAll(String memberId);
	

}
