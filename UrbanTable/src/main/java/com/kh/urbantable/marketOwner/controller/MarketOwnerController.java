package com.kh.urbantable.marketOwner.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.urbantable.marketOwner.model.service.MarketOwnerService;
import com.kh.urbantable.marketOwner.model.vo.Market;

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
	
	@RequestMapping(value="/foundedEnd.do", method=RequestMethod.POST)
	public String foundedEnd(Market market, Model model) {
		logger.info("창업 신청 insert 요청");
		logger.info("market="+market);
		
		int result = marketOwnerService.insertMarketFounded(market);
		
		model.addAttribute("msg", result>0?"창업 신청이 완료되었습니다.":"창업 신청에 실패했습니다. 관리자에게 문의하세요.");
		model.addAttribute("loc", "/");
		
		return "common/msg";
	}
	
	@RequestMapping("/marketOrder.do")
	public String marketOrder() {
		logger.info("지점 주문내역 페이지 요청");
		return "marketOwner/marketOrder";
	}
	
	@RequestMapping("/myMarket.do")
	public String myMarket() {
		logger.info("내 지점 관리 페이지 요청");
		return "marketOwner/myMarket";
	}
	
	@RequestMapping("/marketList.do")
	public String marketList() {
		logger.info("매장 리스트 페이지 요청");
		return "marketOwner/marketList";
	}
	
}
