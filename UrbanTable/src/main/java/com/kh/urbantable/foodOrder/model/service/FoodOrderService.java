package com.kh.urbantable.foodOrder.model.service;

import java.util.List;
import java.util.Map;

import com.kh.urbantable.foodOrder.model.vo.MarketCart;
import com.kh.urbantable.foodOrder.model.vo.MarketOrder;

public interface FoodOrderService {
	
	//페이지당 게시물 수
	int NUM_PER_PAGE = 10;

	String selectMarketNoByMemberId(String memberId);

	int insertMarketOrder(MarketOrder marketOrder, List<MarketCart> marketCartAllList);

	List<MarketCart> selectMarketCartAllList(String memberId);

	List<Map<String, String>> selectMarketOrderList(int cPage, String marketNo);

	int selectMarketOrderTotal(String marketNo);

	List<Map<String, String>> selectMarketOrderDetail(int cPage, Map<String, Object> param);

	int selectMarketOrderDetailTotal(String marketOrderNo);

	int marketOrderUpdateAmount(Map<String, Object> param);

	int marketOrderDeleteFood(Map<String, Object> param);

	int marketOrderDeleteFoodAll(String marketOrderNo);

	MarketOrder selectMarketOrderOne(String marketOrderNo);
	
	int selectMarketOrderDetailPrice(Map<String, Object> param);
	
	int updateMarketOrderPrice(Map<String, Object> param);

}
