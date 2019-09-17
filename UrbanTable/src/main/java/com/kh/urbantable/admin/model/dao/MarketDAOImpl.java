package com.kh.urbantable.admin.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MarketDAOImpl implements MarketDAO{
	
	@Autowired
	SqlSessionTemplate sqlSession;

}
