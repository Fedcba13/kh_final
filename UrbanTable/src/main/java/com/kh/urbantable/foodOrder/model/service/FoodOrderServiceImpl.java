package com.kh.urbantable.foodOrder.model.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.foodOrder.model.dao.FoodOrderDAO;

@Service
public class FoodOrderServiceImpl implements FoodOrderService {

	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	FoodOrderDAO foodOrderDAO;
	
}
