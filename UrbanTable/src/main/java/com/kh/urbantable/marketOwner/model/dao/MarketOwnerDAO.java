package com.kh.urbantable.marketOwner.model.dao;

import com.kh.urbantable.admin.model.vo.MarketMember;
import com.kh.urbantable.marketOwner.model.vo.Market;

public interface MarketOwnerDAO {

	int insertMarketFounded(Market market);

	MarketMember selectByMemberId(String memberId);

	int updateMarketFounded(Market market);

	int cancelFounded(String marketNo);

	int updateMemberFounded(String memberId);

	int updateMemberCancelFounded(String memberId);

	int myMarketUpdate(Market market);

	int myMarketOpen(String marketNo);

}
