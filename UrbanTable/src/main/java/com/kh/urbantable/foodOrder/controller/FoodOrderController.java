package com.kh.urbantable.foodOrder.controller;

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

import com.kh.urbantable.foodOrder.model.service.FoodOrderService;
import com.kh.urbantable.foodOrder.model.vo.MarketCart;
import com.kh.urbantable.foodOrder.model.vo.MarketOrder;

@Controller
@RequestMapping("/foodOrder")
public class FoodOrderController {
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	FoodOrderService foodOrderService;
	
	@RequestMapping("/foodOrderRequest.do")
	public String foodOrderRequest(@RequestParam String memberId, 
			@RequestParam(value="cPage", defaultValue="1") int cPage, Model model) {
		logger.info("지점 발주 요청 리스트");
		String marketNo = foodOrderService.selectMarketNoByMemberId(memberId);
		model.addAttribute("marketNo", marketNo);
		model.addAttribute("cPage", cPage);
		return "foodOrder/marketOrderList";
	}
	
	@ResponseBody
	@RequestMapping(value="/marketFoodOrder.do", method=RequestMethod.POST)
	public Map<String, String> marketFoodOrder(
			@RequestParam(value="memberId") String memberId,
			@RequestParam(value="marketNo") String marketNo, 
			@RequestParam(value="orderTotal") int orderTotal){
		//@RequestParam(value="orderList") List<String> orderList
		logger.info("memberId="+memberId);
		logger.info("marketNo="+marketNo);
		logger.info("orderTotal="+orderTotal);
		
		List<MarketCart> marketCartAllList = foodOrderService.selectMarketCartAllList(memberId);
		logger.info("marketCartAllList="+marketCartAllList);
		
		MarketOrder marketOrder = new MarketOrder();
		marketOrder.setMarketNo(marketNo);
		marketOrder.setMarketOrderPrice(orderTotal);
		
		int moResult = foodOrderService.insertMarketOrder(marketOrder, marketCartAllList);
		
		Map<String, String> result = new HashMap<String, String>();
		result.put("msg", moResult>0?"발주 요청이 완료되었습니다.":"발주 요청에 실패하였습니다. 관리자에게 문의하세요.");
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/marketOrderList.do")
	public Map<String, Object> marketOrderList(@RequestParam String marketNo,
			@RequestParam(value="cPage", defaultValue="1") int cPage){
		List<Map<String, String>> marketOrderList = foodOrderService.selectMarketOrderList(cPage, marketNo);
		int totalContents = foodOrderService.selectMarketOrderTotal(marketNo);
		int totalPage = (int)Math.ceil((double)totalContents/foodOrderService.NUM_PER_PAGE);
		
		final int pageBarSize = 10;
		String pageBar = "";
		
		int pageStart = ((cPage-1)/pageBarSize)*pageBarSize+1;
		int pageEnd = pageStart+pageBarSize-1;
		
		int pageNo = pageStart;
		
		if(pageNo!=1) { //이전
			pageBar += "<a href='#' rel='"+(pageNo-1)+"'><</a>";
		}
		
		while(pageNo<=pageEnd && pageNo<=totalPage) {
			if(pageNo==cPage) {
				pageBar+="<span class='cPage'>"+pageNo+"</span>";
			} else {
				pageBar+="<a href='#' rel='"+pageNo+"'>"+pageNo+"</a>";
			}
			pageNo++;
		}
		
		if(pageNo<=totalPage) { //다음
			pageBar += "<a href='#' rel='"+(pageNo)+"'><</a>";
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("marketOrderList", marketOrderList);
		result.put("pageBar", pageBar);
		
		return result;
	}
	
	@RequestMapping("/marketOrderView.do")
	public String marketOrderView(@RequestParam String marketOrderNo, 
			@RequestParam(value="cPage", defaultValue="1") int cPage, Model model) {
		model.addAttribute("marketOrderNo", marketOrderNo);
		model.addAttribute("cPage", cPage);
		return "foodOrder/marketOrderView";
	}
	
	@ResponseBody
	@RequestMapping("/marketOrderViewDetail.do")
	public Map<String, Object> marketOrderViewDetail(@RequestParam String marketOrderNo, 
			@RequestParam(value="cPage", defaultValue="1") int cPage){
		List<Map<String, String>> marketOrderDetail = foodOrderService.selectMarketOrderDetail(cPage, marketOrderNo);
		int totalContents = foodOrderService.selectMarketOrderDetailTotal(marketOrderNo);
		int totalPage = (int)Math.ceil((double)totalContents/foodOrderService.NUM_PER_PAGE);
		
		final int pageBarSize = 10;
		String pageBar = "";
		
		int pageStart = ((cPage-1)/pageBarSize)*pageBarSize+1;
		int pageEnd = pageStart+pageBarSize-1;
		
		int pageNo = pageStart;
		
		if(pageNo!=1) { //이전
			pageBar += "<a href='#' rel='"+(pageNo-1)+"'><</a>";
		}
		
		while(pageNo<=pageEnd && pageNo<=totalPage) {
			if(pageNo==cPage) {
				pageBar+="<span class='cPage'>"+pageNo+"</span>";
			} else {
				pageBar+="<a href='#' rel='"+pageNo+"'>"+pageNo+"</a>";
			}
			pageNo++;
		}
		
		if(pageNo<=totalPage) { //다음
			pageBar += "<a href='#' rel='"+(pageNo)+"'><</a>";
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("marketOrderDetailList", marketOrderDetail);
		result.put("pageBar", pageBar);
		
		return result;
	}
	
}
