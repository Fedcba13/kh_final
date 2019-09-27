package com.kh.urbantable.marketOwner.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kh.urbantable.admin.model.vo.MarketMember;
import com.kh.urbantable.food.model.vo.FoodWithFoodSection;
import com.kh.urbantable.marketOwner.model.vo.Event;
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

	List<Map<String, String>> selectFoodStockList(int cPage, String marketNo);

	int selectTotalContents(String marketNo);

}
