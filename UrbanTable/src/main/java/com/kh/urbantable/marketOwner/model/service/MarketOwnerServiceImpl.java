package com.kh.urbantable.marketOwner.model.service;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.admin.model.vo.MarketMember;
import com.kh.urbantable.cart.model.vo.Cart;
import com.kh.urbantable.event.model.vo.Event;
import com.kh.urbantable.food.model.vo.FoodDivision;
import com.kh.urbantable.food.model.vo.FoodWithFoodSection;
import com.kh.urbantable.marketOwner.model.dao.MarketOwnerDAO;
import com.kh.urbantable.marketOwner.model.vo.Market;
import com.kh.urbantable.marketOwner.model.vo.MarketEvent;

@Service
public class MarketOwnerServiceImpl implements MarketOwnerService {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	MarketOwnerDAO marketOwnerDAO;

	@Override
	public int insertMarketFounded(Market market) {
		int result = marketOwnerDAO.insertMarketFounded(market);
		if(result>0) {
			result = marketOwnerDAO.updateMemberFounded(market.getMemberId());
		} else {
			result = 0;
		}
		return result;
	}

	@Override
	public MarketMember selectByMemberId(String memberId) {
		return marketOwnerDAO.selectByMemberId(memberId);
	}

	@Override
	public int updateMarketFounded(Market market) {
		return marketOwnerDAO.updateMarketFounded(market);
	}

	@Override
	public int cancelFounded(String marketNo, String memberId) {
		int result = marketOwnerDAO.cancelFounded(marketNo);
		if(result>0) {
			result = marketOwnerDAO.updateMemberCancelFounded(memberId);
		} else {
			result = 0;
		}
		return result;
	}

	@Override
	public int myMarketUpdate(Market market) {
		return marketOwnerDAO.myMarketUpdate(market);
	}

	@Override
	public int myMarketOpen(String marketNo) {
		return marketOwnerDAO.myMarketOpen(marketNo);
	}

	@Override
	public List<Market> selectMarketList(Map<String, Object> param) {
		return marketOwnerDAO.selectMarketList(param);
	}

	@Override
	public List<MarketEvent> selectMarketWithEvent(Map<String, Object> param) {
		return marketOwnerDAO.selectMarketWithEvent(param);
	}

	@Override
	public List<Event> selectEventList(Map<String, Object> param) {
		return marketOwnerDAO.selectEventList(param);
	}

	@Override
	public Map<String, Object> searchMarketList(Map<String, Object> param) {
		List<Market> marketList = marketOwnerDAO.searchMarketList(param);
		Set<Event> eventList = new HashSet<Event>();
		
		if(!marketList.isEmpty()) {
			for(Market m : marketList) {
				param.put("marketNo", m.getMarketNo());
				eventList.addAll(marketOwnerDAO.selectEventList(param));
			}
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("marketList", marketList); 
		result.put("eventList", eventList); 
		
		return result;
	}

	@Override
	public List<String> eventCompanySearch(String srchCompany) {
		return marketOwnerDAO.eventCompanySearch(srchCompany);
	}

	@Override
	public List<Map<String, String>> eventSearchCategory(Map<String, String> param) {
		return marketOwnerDAO.eventSearchCategory(param);
	}

	@Override
	public String selectMarketNoByMemberId(String memberId) {
		return marketOwnerDAO.selectMarketNoByMemberId(memberId);
	}

	@Override
	public List<Map<String, String>> selectFoodStockList(int cPage, Map<String, String> param) {
		return marketOwnerDAO.selectFoodStockList(cPage, param);
	}

	@Override
	public int selectTotalContents(Map<String, String> param) {
		return marketOwnerDAO.selectTotalContents(param);
	}

	@Override
	public List<FoodDivision> selectFoodDivision() {
		return marketOwnerDAO.selectFoodDivision();
	}
	
	@Override
	public List<Cart> checkMarketCart(Map<String, Object> param) {
		return marketOwnerDAO.checkMarketCart(param);
	}
	
	@Override
	public int insertMarketOrderCart(Map<String, Object> param) {
		List<Cart> checkMarketCart = marketOwnerDAO.checkMarketCart(param);
		int result = -1;
		if(checkMarketCart.isEmpty()) {
			result = marketOwnerDAO.insertMarketOrderCart(param);
		} else if(!checkMarketCart.isEmpty()) {
			result = 0;
		}
		
		return result;
	}

	@Override
	public int updateMarketOrderCart(Map<String, Object> param) {
		return marketOwnerDAO.updateMarketOrderCart(param);
	}

	@Override
	public List<Map<String, String>> selectMarketCartList(int cPage, Map<String, String> param) {
		return marketOwnerDAO.selectMarketCartList(cPage, param);
	}

	@Override
	public int selectCartTotalContents(Map<String, String> param) {
		return marketOwnerDAO.selectCartTotalContents(param);
	}

	@Override
	public int delMarketOrderCart(Map<String, String> param) {
		return marketOwnerDAO.delMarketOrderCart(param);
	}

	@Override
	public int selectCartTotal(String memberId) {
		return marketOwnerDAO.selectCartTotal(memberId);
	}

	@Override
	public List<Map<String, Object>> selectMarketOrderList(int cPage, Map<String, Object> param) {
		return marketOwnerDAO.selectMarketOrderList(cPage, param);
	}

	@Override
	public int selectMarketOrderTotalContents(Map<String, Object> param) {
		return marketOwnerDAO.selectMarketOrderTotalContents(param);
	}

	@Override
	public List<Map<String, Object>> selectOrderDetailFoodByPayNo(String payNo) {
		return marketOwnerDAO.selectOrderDetailFoodByPayNo(payNo);
	}

	@Override
	public Map<String, Object> selectOrderDetailPayByPayNo(String payNo) {
		return marketOwnerDAO.selectOrderDetailPayByPayNo(payNo);
	}

	@Override
	public Map<String, Object> selectOrderDetailMemberByPayNo(String payNo) {
		return marketOwnerDAO.selectOrderDetailMemberByPayNo(payNo);
	}

	@Override
	public int updatePayFlag(String payNo) {
		return marketOwnerDAO.updatePayFlag(payNo);
	}

	
}
