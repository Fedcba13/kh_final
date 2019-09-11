package com.kh.urbantable.cart.model.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.cart.model.dao.CartDAO;

@Service
public class CartServiceImpl implements CartService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	CartDAO cartDAO; 
	

}
