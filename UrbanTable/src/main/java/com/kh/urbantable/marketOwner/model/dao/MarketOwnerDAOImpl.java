package com.kh.urbantable.marketOwner.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.urbantable.admin.model.vo.MarketMember;
import com.kh.urbantable.marketOwner.model.vo.Market;
import com.kh.urbantable.marketOwner.model.vo.MarketEvent;

@Repository
public class MarketOwnerDAOImpl implements MarketOwnerDAO {
	
	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public int insertMarketFounded(Market market) {
		return sqlSession.insert("marketOwner.insertMarketFounded", market);
	}

	@Override
	public MarketMember selectByMemberId(String memberId) {
		return sqlSession.selectOne("marketOwner.selectByMemberId", memberId);
	}

	@Override
	public int updateMarketFounded(Market market) {
		return sqlSession.update("marketOwner.updateMarketFounded", market);
	}

	@Override
	public int cancelFounded(String marketNo) {
		return sqlSession.update("marketOwner.cancelFounded", marketNo);
	}

	@Override
	public List<Market> selectMarketList(int flag) {
		return sqlSession.selectList("marketOwner.selectMarketList", flag);
	}
	
	public int updateMemberFounded(String memberId) {
		return sqlSession.update("marketOwner.updateMemberFounded", memberId);
	}

	@Override
	public int updateMemberCancelFounded(String memberId) {
		return sqlSession.update("marketOwner.updateMemberCancelFounded", memberId);
	}

	@Override
	public int myMarketUpdate(Market market) {
		return sqlSession.update("marketOwner.myMarketUpdate", market);
	}

	@Override
	public int myMarketOpen(String marketNo) {
		return sqlSession.update("marketOwner.myMarketOpen", marketNo);
	}

	@Override
	public List<MarketEvent> selectMarketWithEvent() {
		return sqlSession.selectList("marketOwner.selectMarketWithEvent");
	}

}
