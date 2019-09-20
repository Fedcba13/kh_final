package com.kh.urbantable.admin.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.admin.model.dao.MarketDAO;
import com.kh.urbantable.admin.model.vo.MarketMember;
import com.kh.urbantable.marketOwner.model.vo.Market;


@Service
public class MarketServiceImpl implements MarketService{
	
	@Autowired
	MarketDAO marketDAO;


	@Override
	public List<MarketMember> selectMarketList() {

		return marketDAO.selectList();
	}


	@Override
	public int updateMarket(Market market) {
		
		int result = marketDAO.updateMarket(market);
		
		if(result > 0) {
			result = marketDAO.updateMember(market);
		}
			
		
		return result;
	}


	@Override
	public int refuseMarket(Market market) {

		return marketDAO.refuseMarket(market);
	}


	@Override
	public List<MarketMember> selectListByChoise(int param) {

		return marketDAO.selectListByChoise(param);
	}




	
}
