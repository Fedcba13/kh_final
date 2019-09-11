package com.kh.urbantable.cart.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.urbantable.cart.model.service.CartService;

@Controller
@RequestMapping("/cart")
public class CartController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	CartService cartService;
	
	@RequestMapping("/cartList.do")
	public String cartList() {		
		
		return "cart/cart";
	}

}
