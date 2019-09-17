package com.kh.urbantable.cart.model.service;

import java.util.List;
import java.util.Map;

import com.kh.urbantable.cart.model.vo.Cart;

public interface CartService {

	List<Cart> getCartList(String memberId);

	Map<String, String> getFoodInfo(String foodNo);

}
