package com.kh.urbantable.payment.controller;

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
import org.springframework.web.servlet.ModelAndView;

import com.kh.urbantable.payment.model.service.PayService;
import com.kh.urbantable.payment.model.vo.Pay;
import com.kh.urbantable.payment.model.vo.PayDetail;
import com.kh.urbantable.payment.model.vo.Payment_;
import com.siot.IamportRestHttpClientJava.IamportClient;
import com.siot.IamportRestHttpClientJava.response.IamportResponse;
import com.siot.IamportRestHttpClientJava.response.Payment;

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
			Map<String, Object> map = new HashMap<String, Object>();
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
			Map<String, Object> map = new HashMap<String, Object>();
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
	
	@ResponseBody
	@RequestMapping(value="/updatePay.do", method=RequestMethod.POST)
	public int updatePayInfo(Pay pay) {
		logger.debug("pay={}", pay);
		int result = payService.updatePayInfo(pay);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/getPayInfo.do", method=RequestMethod.POST)
	public IamportResponse<Payment> getPayInfo(@RequestParam(value="imp_uid") String impUid) throws Exception {
		String apiKey = "7903224613824328";
		String apiSecret = "utPGLpItmOQA5kegG7tavI27G89WTILnbA4X0NrmBhWHCbXiirtOavVQE5NxOzV0aZXaNpxpGt6iF4BX";
		IamportClient client = new IamportClient(apiKey, apiSecret);
		
		IamportResponse<Payment> paymentInfo = client.paymentByImpUid(impUid);
		logger.debug("payInfo={}", paymentInfo);
		
		return paymentInfo;
	}
	
	@ResponseBody
	@RequestMapping(value="/insertPayment.do", method=RequestMethod.POST)
	public int insertPayment(Payment_ payment) {
		int result = payService.insertPayment(payment);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/deleteCart.do", method=RequestMethod.POST)
	public int deleteCart(@RequestParam(value="memberId") String memberId,
						  @RequestParam(value="flag") int flag) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		map.put("flag", flag);
		int result = payService.deleteCart(map);
		
		return result;
	}
	
	@RequestMapping(value="/payEnd.do")
	public String payEnd(@RequestParam String payNo, Model model) {
		
		model.addAttribute("payNo", payNo);
		
		return "pay/payEnd";
	}
	
	@ResponseBody
	@RequestMapping(value="/getCoupons.do", method=RequestMethod.POST)
	public List<Map<String, Object>> getCoupons(@RequestParam String memberId){
		List<Map<String, Object>> list = payService.getCoupons(memberId);
		logger.debug("list={}", list);
		
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value="/updateCoupon.do", method=RequestMethod.POST)
	public int updateCoupon(@RequestParam String memberId,
							@RequestParam String couponId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberId", memberId);
		map.put("couponId", couponId);
		int result = payService.updateCoupon(map);
		
		return result;		
	}
	
	@ResponseBody
	@RequestMapping(value="/updatePoint.do", method=RequestMethod.POST)
	public int updatePoint(@RequestParam String memberId,
						   @RequestParam int memberPoint) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		map.put("memberPoint", memberPoint);
		int result = payService.updatePoint(map);
		
		return result;
	}

}
