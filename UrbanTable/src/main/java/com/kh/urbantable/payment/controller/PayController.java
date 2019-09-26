package com.kh.urbantable.payment.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.urbantable.payment.model.service.PayService;
import com.kh.urbantable.payment.model.vo.Pay;
import com.kh.urbantable.payment.model.vo.PayDetail;

@Controller
@RequestMapping("/pay")
public class PayController {
	
	@Autowired
	PayService payService;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@ResponseBody
	@RequestMapping(value="/order.do", method=RequestMethod.POST, produces = "application/json; charset=utf-8")
	public ModelAndView getOrder(@RequestParam("cartInfo") String cartArr, ModelAndView mav) {
		logger.debug("cartArr={}", cartArr);
//		JsonParser jsonParser = new JsonParser();
//		JsonArray jsonArray = (JsonArray) jsonParser.parse(cartArr);
//		JsonObject jsonObject = (JsonObject) jsonArray.get(0);			
//		String memberId = jsonObject.get("memberId").getAsString();
//		int payPrice = jsonObject.get("payPrice").getAsInt();
//		int payFlag = jsonObject.get("payFlag").getAsInt();
//		String deliverType = jsonObject.get("deliverType").getAsString();
//		String market = jsonObject.get("market").getAsString();
//		//결제정보를 생성하여 테이블에 넣는다
//		Pay pay = new Pay(null, memberId, null, payPrice, payFlag, 1, deliverType, null);
//		int result = payService.insertPay(pay);
//		for(int i = 0; i < jsonArray.size(); i++) {
//		}
		
		mav.addObject("cartInfo", cartArr);
		mav.setViewName("pay/orderPage");
		
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value="/marketNo.do", method=RequestMethod.POST)
	public String getMarketNo(@RequestParam(value="address") String address) {
		
		String marketNo = payService.getMarketNo(address);
		
		return marketNo;
	}
	
	@ResponseBody
	@RequestMapping(value="/pay.do", method=RequestMethod.POST)
	public String createPayTable(Pay pay) {
		logger.debug("pay={}", pay);
		String payNo = "";
		int result = payService.insertPay(pay);
		if(result > 0) {
			payNo = payService.getPayNo(pay.getMemberId());			
		} 
		
		return payNo;
	}
	
	@ResponseBody
	@RequestMapping(value="/payDetail.do", method=RequestMethod.POST)
	public List<Pay> insertPayDetail(@RequestParam(value="marketNo") String marketNo, PayDetail payDetail){
		logger.debug("payDetail={}", payDetail);
		logger.debug("marketNo={}", marketNo);
		List<Pay> list = null;
		int result = payService.insertPayDetail(payDetail);
		if(result > 0) {
			list = payService.getPayDetail();
			Map<String, Object> map = new HashMap<>();
			map.put("marketNo", marketNo);
			map.put("foodNo", payDetail.getFoodNo());
			map.put("amount", payDetail.getPayDetailAmount());
			payService.updateStock(map);
		}
		
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value="/delDetail.do", method=RequestMethod.POST)
	public int deletePayDetail(@RequestParam(value="marketNo") String marketNo, PayDetail payDetail) {
		int result = payService.deletePayDetail(payDetail);
		if(result > 0) {
			Map<String, Object> map = new HashMap<>();
			map.put("marketNo", marketNo);
			map.put("foodNo", payDetail.getFoodNo());
			map.put("amount", payDetail.getPayDetailAmount());
			payService.rollbackStock(map);
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/delPay.do", method=RequestMethod.POST)
	public int deletePayInfo(Pay pay) {
		logger.debug("deleteDetail={}", pay);
		int result = payService.deletePayInfo(pay);
		
		return result;
	}

}
