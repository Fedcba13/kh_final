package com.kh.urbantable.payment.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.kh.urbantable.payment.model.service.PayService;

@Controller
public class PayController {
	
	@Autowired
	PayService payService;
	
	Logger logger = LoggerFactory.getLogger(getClass());

}
