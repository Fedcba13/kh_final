package com.kh.urbantable.cart.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.urbantable.cart.model.service.CartService;
import com.kh.urbantable.cart.model.vo.Cart;
import com.kh.urbantable.marketOwner.model.vo.Market;
import com.kh.urbantable.payment.model.service.PayService;

@Controller
@RequestMapping("/cart")
public class CartController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	CartService cartService;
	
	@Autowired
	PayService payService;
	
	@RequestMapping("/cartList.do")
	public String cartList(@RequestParam String memberId, 
						   Model model) {
		if("".equals(memberId)) {
			model.addAttribute("msg", "로그인후 이용하세요");
			model.addAttribute("loc", "/");
			return "common/msg";
		}
		
		logger.debug("memberId={}", memberId);
		
		List<Cart> list = cartService.getCartList(memberId);
		logger.debug("cartList={}", list);
		
		model.addAttribute("list", list);		
		
		return "cart/cart";
	}	
	
	@ResponseBody
	@RequestMapping(value="/foodInfo.do", method=RequestMethod.POST, produces = "application/json; charset=utf-8")
	public String foodInfo(@RequestParam String foodNo){
		logger.debug("foodNo={}", foodNo);
		
		Map<String, String> map = cartService.getFoodInfo(foodNo);
		logger.debug("foodInfo={}", map);
		Gson gson = new Gson();
		
		return gson.toJson(map);
	}
	
	@ResponseBody
	@RequestMapping(value="/checkstock.do", method=RequestMethod.POST)
	public boolean checkStock(@RequestParam(value="foodNo") String foodNo,
							  @RequestParam(value="payDetailAmount") int payDetailAmount,
							  @RequestParam(value="market") String marketAddress) {
		boolean isEnough = false;
		String address = marketAddress.substring(marketAddress.indexOf(" ")+1);
		String marketNo = payService.getMarketNo(address);
		Map<String, String> map = new HashMap<String, String>();
		map.put("marketNo", marketNo);
		map.put("foodNo", foodNo);
		int isExist = cartService.getExist(map);
		if(isExist > 0) {
			int stock = cartService.getProductStock(map);
			if(stock >= payDetailAmount) {
				isEnough = true;
			}			
		}
		
		return isEnough;
	}
	
	@RequestMapping("/searchMarket.do")
	public String searchMarket(@RequestParam(value="addr", defaultValue="", required=false) String userAddress, Model model) {
		
		List<Market> list = cartService.getMarketList();
		logger.debug("marketList={}", list);
		model.addAttribute("userAddress", userAddress);
		model.addAttribute("marketList", list);
		
		return "map/map";
	}

}
