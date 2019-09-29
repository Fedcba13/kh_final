package com.kh.urbantable.foodOrder.model.service;

import java.util.List;

import com.kh.urbantable.foodOrder.model.vo.MarketOrder;

public interface FoodOrderService {

	String selectMarketNoByMemberId(String memberId);

	int insertMarketOrder(MarketOrder marketOrder, List<String> orderList);

}
