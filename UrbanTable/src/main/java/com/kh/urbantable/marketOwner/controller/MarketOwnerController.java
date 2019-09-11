package com.kh.urbantable.marketOwner.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.urbantable.marketOwner.model.service.MarketOwnerService;

@Controller
@RequestMapping("/market")
public class MarketOwnerController {

	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	MarketOwnerService marketOwnerService;
	
	@RequestMapping("/founded.do")
	public String founded() {
		logger.info("창업 신청 페이지 요청");
		return "marketOwner/founded";
	}
	
}
