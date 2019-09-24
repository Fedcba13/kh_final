package com.kh.urbantable.marketOwner.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.admin.model.vo.MarketMember;
import com.kh.urbantable.marketOwner.model.dao.MarketOwnerDAO;
import com.kh.urbantable.marketOwner.model.vo.Event;
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
	public List<Market> searchMarketList(Map<String, Object> param) {
		return marketOwnerDAO.searchMarketList(param);
	}

	@Override
	public List<Event> searchEventList(String marketNo) {
		return marketOwnerDAO.searchEventList(marketNo);
	}

	
}
