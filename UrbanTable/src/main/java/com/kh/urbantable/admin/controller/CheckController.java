package com.kh.urbantable.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.urbantable.admin.model.service.CheckService;
import com.kh.urbantable.foodOrder.model.vo.MarketOrderDetail;
import com.kh.urbantable.recipe.model.vo.Blame;

@Controller
@RequestMapping("/check")

public class CheckController {

	@Autowired
	CheckService checkService;
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/marketOrderCheckList.do")
	private String marketOrderCheckList(Model model) {
		
		List<Map<String, Object>> list = checkService.selectAllList();
		
		
		
		model.addAttribute("list", list);
				
		return "/admin/marketOrderCheck";
	}
	
	@RequestMapping("/marketOrderCheckList1.do")
	@ResponseBody
	private List<Map<String, Object>> marketOrderCheckList1(Model model) {
		
		List<Map<String, Object>> list = checkService.selectAllList();
				
		return list;
	}
	
	@RequestMapping("/updateOrder.do")
	private String updateOrder(@RequestParam("marketNo") String marketNo, @RequestParam("orderNo") String orderNo, Model model) {
		
		
		logger.info("marketNo={}", marketNo);
		logger.info("orderNo={}", orderNo);
		
		// 주문번호에 해당하는 detail 가져오기
		List<MarketOrderDetail> mod = checkService.selectMODList(orderNo);
		logger.info("mod={}", mod);
		
		// 사용할 param 
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("marketNo", marketNo);
		
		// foodNo
		String food = "";
		int amount = 0;
		int result = 0;
		for(int i = 0; i < mod.size(); i++) {
			food = mod.get(i).getFoodNo();
			amount = mod.get(i).getMarketOrderDetailAmount();
			param.put("food", food);
			param.put("amount", amount);
			
			// 해당 매장에 foodNo가 있는지 확인
			result = checkService.selectFoodNo(param);
			
			
			if(result > 0) {	
				checkService.updateAmount(param);
				
			} else {
				checkService.insertFood(param);
			}
			
		
		}
		
			// update완료 후 flag값 변경
			checkService.updateFlag(orderNo);
//		param.put("marketNo", marketNo);
//		param.put("amount", amount);
//		param.put("foodNo", foodNo);
//		
//		int result = checkService.selectFoodNo(param);
//		
//		logger.info("result={}", result);
//		
//		if(result > 0) {
//			//
//		}else {
//			
//		}
		
		
		List<Map<String, Object>> list = checkService.selectAllList();
		
		model.addAttribute("list", list);
				
		return "/admin/marketOrderCheck";
	}
	
	@RequestMapping("/blameList.do")
	public String blameList(Model model) {
		
		List<Blame> list = checkService.selectBlameList();
		model.addAttribute("list", list);
		
		return "/admin/blameList";
	}
	
	@RequestMapping("/blameCheck.do")
	public String blameCheck(String blameId, Model model) {
		
		// 해당 blame찾기
		Blame b = checkService.selectBlame(blameId);
	
		// blame신고액션변경및 댓글 비노출
		int result = checkService.blameActionChk(b);
		
		List<Blame> list = checkService.selectBlameList();
		
		model.addAttribute("list", list);
		
		return "/admin/blameList";
	}
	
}
