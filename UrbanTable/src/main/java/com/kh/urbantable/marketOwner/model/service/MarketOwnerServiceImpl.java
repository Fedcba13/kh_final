package com.kh.urbantable.marketOwner.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.admin.model.vo.MarketMember;
import com.kh.urbantable.marketOwner.model.dao.MarketOwnerDAO;
import com.kh.urbantable.marketOwner.model.vo.Market;

@Service
public class MarketOwnerServiceImpl implements MarketOwnerService {

	@Autowired
	MarketOwnerDAO marketOwnerDAO;

	@Override
	public int insertMarketFounded(Market market) {
		return marketOwnerDAO.insertMarketFounded(market);
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
	public int cancelFounded(String marketNo) {
		return marketOwnerDAO.cancelFounded(marketNo);
	}

	@Override
	public List<Market> selectMarketList(int flag) {
		return marketOwnerDAO.selectMarketList(flag);
	}

	
}
