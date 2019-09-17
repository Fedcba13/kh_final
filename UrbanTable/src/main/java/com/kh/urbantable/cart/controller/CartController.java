package com.kh.urbantable.cart.controller;

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

@Controller
@RequestMapping("/cart")
public class CartController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	CartService cartService;
	
	@RequestMapping("/cartList.do")
	public String cartList(@RequestParam String memberId, 
						   Model model) {
		
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

}
