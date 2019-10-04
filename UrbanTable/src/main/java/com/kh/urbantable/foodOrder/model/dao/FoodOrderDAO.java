package com.kh.urbantable.foodOrder.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.urbantable.foodOrder.model.vo.MarketCart;
import com.kh.urbantable.foodOrder.model.vo.MarketOrder;
import com.kh.urbantable.foodOrder.model.vo.MarketOrderDetail;

public interface FoodOrderDAO {

	String selectMarketNoByMemberId(String memberId);

	int insertMarketOrder(MarketOrder marketOrder);

	int insertMarketOrderDetail(MarketOrderDetail marketOrderDetail);

	int deleteMarketCart(Map<String, String> param);

	List<MarketCart> selectMarketCartAllList(String memberId);

	List<Map<String, String>> selectMarketOrderList(int cPage, String marketNo);

	int selectMarketOrderTotal(String marketNo);

	List<Map<String, String>> selectMarketOrderDetail(int cPage, Map<String, Object> param);

	int selectMarketOrderDetailTotal(String marketOrderNo);

	int marketOrderUpdateAmount(Map<String, Object> param);

	int marketOrderDeleteFood(Map<String, Object> param);

	int marketOrderDetailDeleteAll(String marketOrderNo);

	int marketOrderDeleteAll(String marketOrderNo);

	MarketOrder selectMarketOrderOne(String marketOrderNo);

	int selectMarketOrderDetailPrice(Map<String, Object> param);

	int updateMarketOrderPrice(Map<String, Object> param);

}
