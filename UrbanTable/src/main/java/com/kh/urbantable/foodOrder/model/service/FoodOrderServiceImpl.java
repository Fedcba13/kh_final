package com.kh.urbantable.foodOrder.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.foodOrder.model.dao.FoodOrderDAO;
import com.kh.urbantable.foodOrder.model.vo.MarketOrder;
import com.kh.urbantable.foodOrder.model.vo.MarketOrderDetail;

@Service
public class FoodOrderServiceImpl implements FoodOrderService {

	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	FoodOrderDAO foodOrderDAO;

	@Override
	public String selectMarketNoByMemberId(String memberId) {
		return foodOrderDAO.selectMarketNoByMemberId(memberId);
	}

	@Override
	public int insertMarketOrder(MarketOrder marketOrder, List<String> orderList) {
		int result = foodOrderDAO.insertMarketOrder(marketOrder);
		if(result > 0) {
			if(!orderList.isEmpty()) {
				for(String order : orderList) {
					JSONObject json = new JSONObject(String.valueOf(order));
					
					MarketOrderDetail marketOrderDetail = new MarketOrderDetail();
					marketOrderDetail.setFoodNo(json.getString("FOOD_NO"));
					marketOrderDetail.setMarketOrderDetailAmount(json.getInt("CART_AMOUNT"));
					marketOrderDetail.setFoodCompany(json.getString("FOOD_COMPANY"));
					result = foodOrderDAO.insertMarketOrderDetail(marketOrderDetail);
					
					if(result>0) { //장바구니 목록에서 삭제
						Map<String, String> param = new HashMap<String, String>();
						param.put("foodNo", json.getString("FOOD_NO"));
						param.put("memberId", json.getString("MEMBER_ID"));
						result = foodOrderDAO.deleteMarketCart(param);
					}
				}
			}
		}
		return result;
	}
	
}
