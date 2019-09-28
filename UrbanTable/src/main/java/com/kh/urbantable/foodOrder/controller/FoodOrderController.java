package com.kh.urbantable.foodOrder.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.urbantable.foodOrder.model.service.FoodOrderService;
import com.kh.urbantable.foodOrder.model.vo.MarketOrder;

@Controller
@RequestMapping("/foodOrder")
public class FoodOrderController {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	FoodOrderService foodOrderService;
	
	@RequestMapping("/foodOrderRequest.do")
	public String foodOrderRequest(@RequestParam String memberId, Model model) {
		logger.info("지점 발주 요청 리스트");
		String marketNo = foodOrderService.selectMarketNoByMemberId(memberId);
		model.addAttribute("marketNo", marketNo);
		return "foodOrder/foodOrderRequest";
	}
	
	@ResponseBody
	@RequestMapping(value="/marketFoodOrder.do", method=RequestMethod.POST)
	public Map<String, String> marketFoodOrder(@RequestBody List<Map<String, Object>> orderList){
		logger.info("orderList="+orderList);
		
		if(!orderList.isEmpty()) {
			for(Map<String, Object> order : orderList) {
				//MarketOrder marketOrder = new MarketOrder();
				logger.info((String) order.get("MARKET_NO"));
			}
		}
		
		Map<String, String> result = new HashMap<String, String>();
		
		return result;
	}
}
