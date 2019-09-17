package com.kh.urbantable.payment.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PayDAOImple implements PayDAO {
	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	Logger logger = LoggerFactory.getLogger(getClass());

}
