package com.kh.urbantable.event.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class EventDAOImple implements EventDAO{

	@Autowired
	SqlSessionTemplate sqlSession;
}
