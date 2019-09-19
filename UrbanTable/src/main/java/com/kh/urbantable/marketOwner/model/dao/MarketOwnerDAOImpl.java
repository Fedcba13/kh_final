package com.kh.urbantable.marketOwner.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.urbantable.admin.model.vo.MarketMember;
import com.kh.urbantable.marketOwner.model.vo.Market;

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

}
