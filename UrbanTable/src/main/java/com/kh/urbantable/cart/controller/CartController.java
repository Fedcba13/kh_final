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
import com.kh.urbantable.common.util.Utils;
import com.kh.urbantable.marketOwner.model.service.MarketOwnerService;
import com.kh.urbantable.marketOwner.model.vo.Market;
import com.kh.urbantable.member.model.service.MemberService;
import com.kh.urbantable.payment.model.service.PayService;

@Controller
@RequestMapping("/cart")
public class CartController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	CartService cartService;
	
	@Autowired
	PayService payService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	MarketOwnerService marketOwnerService; 
	
	@RequestMapping("/cartList.do")
	public String cartList(@RequestParam String memberId, 
						   @RequestParam int memberCheck,
						   Model model) {
		if(memberCheck != 1) {
			model.addAttribute("msg", "일반사용자만 이용 가능합니다");
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
	
	@ResponseBody
	@RequestMapping("/getMarket.do")
	public Map<String, String> getMarket(@RequestParam String address){
HashMap<String, String> result = new HashMap<String, String>();
		
		HashMap<String, Double> map = Utils.getLocation(address);
		
		HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("flag", 2);
        
        //현재 오픈된 매장만 가져옵니다.
        List<Market> list = marketOwnerService.selectMarketList(param);
        logger.debug("list={}", list);
        
		double nearLenth = Double.MAX_VALUE;
		result.put("msg", "배송 불가 지역");
		
		if(list == null || list.size() == 0) {
			
		}else {
			for(int i = 0; i<list.size(); i++) {
				HashMap<String, Double> difMap = Utils.getLocation(list.get(i).getMarketAddress());
				
				double distanceMile = Utils.distance(map, difMap, "kilometer");
				
				if(distanceMile < nearLenth) {
					nearLenth = distanceMile;
					result.put("nearMarket", list.get(i).getMarketAddress());
					result.put("marketName", list.get(i).getMarketName());
					result.put("marketNo", list.get(i).getMarketNo());
				}
			}
		}		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/getDiscount.do", method=RequestMethod.POST)
	public int getDiscount(@RequestParam String marketNo,
						   @RequestParam String foodNo) {
		int dcRate = 0;
		//foodNo를 이용해서 foodSection을 받아옴
		String foodSection = cartService.getFoodSection(foodNo);
		//오늘날짜 기준으로 진행중인 이벤트 목록을 받아와서 해당 매장과 상품이 할인중인지를 확인
		//market과 category가 모두 null인경우:전매장 전품목 할인
		//market만 null인경우: 전매장 해당품목 할인
		//category만 null인경우: 해당매장 전품목 할인
		//모두 null이 아닌경우: 해당매장 해당품목 할인
		List<Map<String, Object>> dcList = cartService.getDiscountList();
		logger.debug("dcList={}", dcList);
		for(Map<String, Object> map : dcList) {
			if(map.get("MARKET_NO")==null && map.get("EVENT_CATEGORY")==null) {
				if(Integer.parseInt(String.valueOf(map.get("EVENT_PRICE"))) > dcRate) {
					dcRate = Integer.parseInt(String.valueOf(map.get("EVENT_PRICE")));
				}
			} else if (marketNo.equals(map.get("MARKET_NO")) && map.get("EVENT_CATEGORY")==null) {
				if(Integer.parseInt(String.valueOf(map.get("EVENT_PRICE"))) > dcRate) {
					dcRate = Integer.parseInt(String.valueOf(map.get("EVENT_PRICE")));
				}
			} else if (map.get("MARKET_NO")==null && foodSection.equals(map.get("EVENT_CATEGORY"))) {
				if(Integer.parseInt(String.valueOf(map.get("EVENT_PRICE"))) > dcRate) {
					dcRate = Integer.parseInt(String.valueOf(map.get("EVENT_PRICE")));
				}
			} else if (marketNo.equals(map.get("MARKET_NO")) && foodSection.equals(map.get("EVENT_CATEGORY"))) {
				if(Integer.parseInt(String.valueOf(map.get("EVENT_PRICE"))) > dcRate) {
					dcRate = Integer.parseInt(String.valueOf(map.get("EVENT_PRICE")));
				}
			}
		}
		
		return dcRate;
	}
	
	@ResponseBody
	@RequestMapping("/deleteCart.do")
	public List<Cart> deleteCart(@RequestParam String foodNo, @RequestParam String memberId, Model model) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("foodNo", foodNo);
		map.put("memberId", memberId);
		int result = cartService.deleteCart(map);
		if(result > 0) {
			List<Cart> list = cartService.getCartList(memberId);
			logger.debug("listAfterDelete={}", list);
			model.addAttribute("list", list);
			return list;
		} else {
			return null;
		}		
	}
	
	@ResponseBody
	@RequestMapping(value="/deleteCartAll.do", method=RequestMethod.POST)
	public int deleteCartAll(@RequestParam String memberId) {
		int result = cartService.deleteCartAll(memberId);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/getAddress.do", method=RequestMethod.POST)
	public List<Map<String, String>> getAddressList(@RequestParam String memberId){
		List<Map<String, String>> list = memberService.selectAddress(memberId); 
		logger.debug("list={}", list);
		
		return list;
	}
	
	@ResponseBody
	@RequestMapping("/insertToCartByUser.do")
	public int insertToCartByUser(@RequestParam  String memberId,
			@RequestParam  String foodNo,
			@RequestParam  String cartAmount) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("memberId", memberId);
		param.put("foodNo", foodNo);
		param.put("cartAmount", cartAmount);
		
		int result = cartService.insertCartByUser(param);
		
		return result; 
		
	}
}
