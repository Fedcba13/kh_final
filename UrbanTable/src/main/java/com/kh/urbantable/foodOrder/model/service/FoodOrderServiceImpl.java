package com.kh.urbantable.foodOrder.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.foodOrder.model.dao.FoodOrderDAO;
import com.kh.urbantable.foodOrder.model.vo.MarketCart;
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
	public int insertMarketOrder(MarketOrder marketOrder, List<MarketCart> marketCartAllList) {
		int result = foodOrderDAO.insertMarketOrder(marketOrder);
		if(result > 0) {
			if(!marketCartAllList.isEmpty()) {
				for(MarketCart order : marketCartAllList) {
					
					MarketOrderDetail marketOrderDetail = new MarketOrderDetail();
					marketOrderDetail.setFoodNo(order.getFoodNo());
					marketOrderDetail.setMarketOrderDetailAmount(order.getCartAmount());
					marketOrderDetail.setFoodCompany(order.getFoodCompany());
					result = foodOrderDAO.insertMarketOrderDetail(marketOrderDetail);
					
					if(result>0) { //장바구니 목록에서 삭제
						Map<String, String> param = new HashMap<String, String>();
						param.put("foodNo", order.getFoodNo());
						param.put("memberId", order.getMemberId());
						result = foodOrderDAO.deleteMarketCart(param);
					}
				}
			}
		}
		return result;
	}

	@Override
	public List<MarketCart> selectMarketCartAllList(String memberId) {
		return foodOrderDAO.selectMarketCartAllList(memberId);
	}

	@Override
	public List<Map<String, String>> selectMarketOrderList(int cPage,String marketNo) {
		return foodOrderDAO.selectMarketOrderList(cPage, marketNo);
	}

	@Override
	public int selectMarketOrderTotal(String marketNo) {
		return foodOrderDAO.selectMarketOrderTotal(marketNo);
	}

	@Override
	public List<Map<String, String>> selectMarketOrderDetail(int cPage, String marketOrderNo) {
		return foodOrderDAO.selectMarketOrderDetail(cPage, marketOrderNo);
	}

	@Override
	public int selectMarketOrderDetailTotal(String marketOrderNo) {
		return foodOrderDAO.selectMarketOrderDetailTotal(marketOrderNo);
	}

	@Override
	public int selectMarketOrderFlag(String marketOrderNo) {
		return foodOrderDAO.selectMarketOrderFlag(marketOrderNo);
	}

	@Override
	public int marketOrderUpdateAmount(Map<String, Object> param) {
		return foodOrderDAO.marketOrderUpdateAmount(param);
	}

	@Override
	public int marketOrderDeleteFood(String marketOrderDetailNo) {
		return foodOrderDAO.marketOrderDeleteFood(marketOrderDetailNo);
	}

	@Override
	public int marketOrderDeleteFoodAll(String marketOrderNo) {
		int deleteAll = foodOrderDAO.marketOrderDetailDeleteAll(marketOrderNo);
		if(deleteAll>0) {
			deleteAll=foodOrderDAO.marketOrderDeleteAll(marketOrderNo);
		}
		return deleteAll;
	}

	@Override
	public int selectMarketOrderPriceTotal(String marketOrderNo) {
		return foodOrderDAO.selectMarketOrderPriceTotal(marketOrderNo);
	}
	
}
