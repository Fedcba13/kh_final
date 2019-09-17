package com.kh.urbantable.marketOwner.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MarketOwnerDAOImpl implements MarketOwnerDAO {
	
	@Autowired
	SqlSessionTemplate sqlSession;

}
