package com.kh.urbantable.marketOwner.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	
}
