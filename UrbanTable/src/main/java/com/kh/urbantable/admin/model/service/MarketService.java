package com.kh.urbantable.admin.model.service;

import java.util.List;

import com.kh.urbantable.admin.model.vo.MarketMember;
import com.kh.urbantable.marketOwner.model.vo.Market;

public interface MarketService {

	List<MarketMember> selectMarketList();

}
