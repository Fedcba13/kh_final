package com.kh.urbantable.foodOrder.model.vo;

import com.kh.urbantable.cart.model.vo.Cart;

import lombok.Data;

@Data
public class MarketCart extends Cart {

	private String foodName;
	private int foodMarketPrice;
	private String foodCompany;
	
}
