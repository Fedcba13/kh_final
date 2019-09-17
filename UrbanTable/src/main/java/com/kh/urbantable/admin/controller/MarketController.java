package com.kh.urbantable.admin.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.urbantable.admin.model.service.MarketService;
import com.kh.urbantable.admin.model.vo.MarketMember;

@Controller
@RequestMapping("/admin")
public class MarketController {

	@Autowired
	MarketService marketService;
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/foundationList.do")
	public String foundationList(Model model) {
		
		List<MarketMember> list = marketService.selectMarketList();

		logger.debug("list={}", list);
		model.addAttribute("list", list);
		
		
		return "admin/foundation";
	}
	
}
