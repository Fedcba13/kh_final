package com.kh.urbantable.foodOrder.model.dao;

import java.util.Map;

import com.kh.urbantable.foodOrder.model.vo.MarketOrder;
import com.kh.urbantable.foodOrder.model.vo.MarketOrderDetail;

public interface FoodOrderDAO {

	String selectMarketNoByMemberId(String memberId);

	int insertMarketOrder(MarketOrder marketOrder);

	int insertMarketOrderDetail(MarketOrderDetail marketOrderDetail);

	int deleteMarketCart(Map<String, String> param);

}
