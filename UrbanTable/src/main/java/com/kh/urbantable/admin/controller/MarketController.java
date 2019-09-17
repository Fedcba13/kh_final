package com.kh.urbantable.admin.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.urbantable.admin.model.service.MarketService;

@Controller
@RequestMapping("/admin")
public class MarketController {

	@Autowired
	MarketService marketService;
	
	private Logger logger = LoggerFactory.getLogger(getClass());
}
