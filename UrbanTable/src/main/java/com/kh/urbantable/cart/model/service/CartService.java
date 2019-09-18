package com.kh.urbantable.cart.model.service;

import java.util.List;
import java.util.Map;

import com.kh.urbantable.cart.model.vo.Cart;
import com.kh.urbantable.marketOwner.model.vo.Market;

public interface CartService {

	List<Cart> getCartList(String memberId);

	Map<String, String> getFoodInfo(String foodNo);

	List<Market> getMarketList();

}
