package com.kh.urbantable.payment.model.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.payment.model.dao.PayDAO;

@Service
public class PayServiceImple implements PayService {
	
	@Autowired
	PayDAO payDAO;
	
	Logger logger = LoggerFactory.getLogger(getClass());

}
