package com.kh.urbantable.admin.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.urbantable.admin.model.service.MarketService;
import com.kh.urbantable.admin.model.vo.MarketMember;
import com.kh.urbantable.marketOwner.model.vo.Market;

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
	
	@RequestMapping("/updateMarket.do")
	public String updateMarket(Market market, Model model) {
		
		int result = marketService.updateMarket(market);
		
		logger.debug("Market={}", market);
		
		List<MarketMember> list = new ArrayList<MarketMember>();
		if(result > 0) {
			list = marketService.selectMarketList();
		}
		
		logger.debug("Market={}", list);
		
		model.addAttribute("list", list);
		
		return "admin/foundation";
	}
	
	@RequestMapping("/refuseMarket.do")
	public String refuseMarket(Market market, Model model) {
		
		int result = marketService.refuseMarket(market);
		
		List<MarketMember> list = new ArrayList<MarketMember>();
		
		if(result > 0) {
			list = marketService.selectMarketList();
		}
		
		logger.debug("Market={}", list);
		
		model.addAttribute("list", list);
		
		return "admin/foundation";
	}

	@RequestMapping("/selectListBychoise.do")
	@ResponseBody
	public List<MarketMember> selectListBychoise(@RequestParam("param") int param, Model model) {
		
		List<MarketMember> list = marketService.selectListByChoise(param);
		
		return list;
	}

}
