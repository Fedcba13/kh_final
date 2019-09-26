package com.kh.urbantable.foodOrder.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.urbantable.foodOrder.model.service.FoodOrderService;

@Controller
@RequestMapping("/foodOrder")
public class FoodOrderController {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	FoodOrderService foodOrderService;
	
	@RequestMapping("/marketFoodOrder.do")
	public String marketFoodOrder() {
		logger.info("지점 발주 요청 리스트");
		return "foodOrder/marketFoodOrder";
	}
	
	@RequestMapping("/foodOrderRequest.do")
	public String foodOrderRequest(@RequestParam String memberId, Model model) {
		logger.info("지점 발주 요청 리스트");
		String marketNo = foodOrderService.selectMarketNoByMemberId(memberId);
		model.addAttribute("marketNo", marketNo);
		return "foodOrder/foodOrderRequest";
	}
}
