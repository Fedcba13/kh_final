package com.kh.urbantable.admin.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.urbantable.admin.model.vo.MarketMember;

@Repository
public class MarketDAOImpl implements MarketDAO{

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public List<MarketMember> selectList() {
		
		return sqlSession.selectList("admin.selectList");
	}
	
	
}
