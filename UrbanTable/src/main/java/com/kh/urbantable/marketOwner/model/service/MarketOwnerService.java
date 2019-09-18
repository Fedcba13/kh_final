package com.kh.urbantable.marketOwner.model.service;

import com.kh.urbantable.admin.model.vo.MarketMember;
import com.kh.urbantable.marketOwner.model.vo.Market;

public interface MarketOwnerService {

	int insertMarketFounded(Market market);

	MarketMember selectByMemberId(String memberId);

	int updateMarketFounded(Market market);

	int cancelFounded(String marketNo);

}
