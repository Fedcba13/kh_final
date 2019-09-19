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
	public int updateMarket(Market memberId) {
		
		return sqlSession.update("admin.updateMarket", memberId);
	}

	@Override
	public int updateMember(Market memberId) {

		return sqlSession.update("admin.updateMember", memberId);
	}


	
}
