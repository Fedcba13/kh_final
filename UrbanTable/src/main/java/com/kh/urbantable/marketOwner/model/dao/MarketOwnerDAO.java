package com.kh.urbantable.marketOwner.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kh.urbantable.admin.model.vo.MarketMember;
import com.kh.urbantable.cart.model.vo.Cart;
import com.kh.urbantable.event.model.vo.Event;
import com.kh.urbantable.food.model.vo.FoodDivision;
import com.kh.urbantable.food.model.vo.FoodWithFoodSection;
import com.kh.urbantable.marketOwner.model.vo.Market;
import com.kh.urbantable.marketOwner.model.vo.MarketEvent;

public interface MarketOwnerDAO {

	int insertMarketFounded(Market market);

	MarketMember selectByMemberId(String memberId);

	int updateMarketFounded(Market market);

	int cancelFounded(String marketNo);

	List<Market> selectMarketList(Map<String, Object> param);
	
	int updateMemberFounded(String memberId);

	int updateMemberCancelFounded(String memberId);

	int myMarketUpdate(Market market);

	int myMarketOpen(String marketNo);

	List<MarketEvent> selectMarketWithEvent(Map<String, Object> param);

	List<Event> selectEventList(Map<String, Object> param);

	List<Market> searchMarketList(Map<String, Object> param);

	List<String> eventCompanySearch(String srchCompany);

	List<Map<String, String>> eventSearchCategory(Map<String, String> param);

	String selectMarketNoByMemberId(String memberId);

	List<Map<String, String>> selectFoodStockList(int cPage, Map<String, String> param);

	int selectTotalContents(Map<String, String> param);

	List<FoodDivision> selectFoodDivision();

	int insertMarketOrderCart(Map<String, Object> param);

	List<Cart> checkMarketCart(Map<String, Object> param);

	int updateMarketOrderCart(Map<String, Object> param);

	List<Map<String, String>> selectMarketCartList(int cPage, Map<String, String> param);

	int selectCartTotalContents(Map<String, String> param);

	int delMarketOrderCart(Map<String, String> param);

	int selectCartTotal(String memberId);

}
