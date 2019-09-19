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
	public int updateMarket(Market memberId) {
		
		int result = marketDAO.updateMarket(memberId);
		
		if(result > 0) {
			result = marketDAO.updateMember(memberId);
		}
			
		
		return result;
	}


	
}
