package com.kh.urbantable.admin.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.urbantable.admin.model.vo.MarketMember;
import com.kh.urbantable.marketOwner.model.vo.Market;

@Repository
public class MarketDAOImpl implements MarketDAO{

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public List<MarketMember> selectList() {
		
		return sqlSession.selectList("admin.selectList");
	}

	@Override
	public int updateMarket(Market market) {
		
		return sqlSession.update("admin.updateMarket", market);
	}

	@Override
	public int updateMember(Market market) {

		return sqlSession.update("admin.updateMember", market);
	}

	@Override
	public int refuseMarket(Market market) {
		
		return sqlSession.update("admin.refuseMarket", market);
	}

	@Override
	public List<MarketMember> selectListByChoise(int param) {

		return sqlSession.selectList("admin.selectListByChoise", param);
	}




	
}
