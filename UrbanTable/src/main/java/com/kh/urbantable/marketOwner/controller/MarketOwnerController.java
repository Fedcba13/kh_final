package com.kh.urbantable.marketOwner.controller;

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

import com.kh.urbantable.admin.model.vo.MarketMember;
import com.kh.urbantable.marketOwner.model.service.MarketOwnerService;
import com.kh.urbantable.marketOwner.model.vo.Market;

@Controller
@RequestMapping("/market")
public class MarketOwnerController {

	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	MarketOwnerService marketOwnerService;
	
	@RequestMapping("/founded.do")
	public ModelAndView founded(@RequestParam(value="memberId") String memberId, ModelAndView mav) {
		logger.info("창업 신청 페이지 요청");
		
		//창업신청 했는지 여부 검사
		MarketMember market = marketOwnerService.selectByMemberId(memberId);
		logger.info("market@="+market);
		
		if(market!=null) {
			mav.addObject("founded", market);
			mav.setViewName("marketOwner/foundedEndView");
		} else if (market==null) {
			mav.setViewName("marketOwner/founded");
		}
		
		return mav;
	}
	
	@RequestMapping(value="/foundedEnd.do", method=RequestMethod.POST)
	public String foundedEnd(Market market, Model model) {
		logger.info("창업 신청 insert 요청");
		logger.info("market="+market);
		
		int result = marketOwnerService.insertMarketFounded(market);
		
		model.addAttribute("msg", result>0?"창업 신청이 완료되었습니다.":"창업 신청에 실패했습니다. 관리자에게 문의하세요.");
		model.addAttribute("loc", "/");
		
		return "common/msg";
	}
	
	@RequestMapping("/updateFounded.do")
	public ModelAndView updateFounded(@RequestParam(value="memberId") String memberId, ModelAndView mav) {
		logger.info("창업 신청 수정 페이지 요청");
		
		//기존 신청 정보 불러오기
		MarketMember market = marketOwnerService.selectByMemberId(memberId);
		logger.info("market@="+market);
		
		if(market!=null) {
			mav.addObject("founded", market);
			mav.setViewName("marketOwner/updateFounded");
		} else if (market==null) {
			mav.addObject("msg", "창업 신청 내역이 없습니다.");
			mav.addObject("loc", "/");
			mav.setViewName("common/msg");
		}
		
		return mav;
	}
	
	@RequestMapping(value="/updateFoundedEnd.do", method=RequestMethod.POST)
	public String updateFoundedEnd(Market market, Model model) {
		logger.info("창업 신청 수정 요청");
		logger.info("market="+market);
		
		int result = marketOwnerService.updateMarketFounded(market);
		
		model.addAttribute("msg", result>0?"창업 신청이 수정되었습니다.":"창업 신청 수정에 실패했습니다. 관리자에게 문의하세요.");
		model.addAttribute("loc", "/");
		
		return "common/msg";
	}
	
	@RequestMapping("/cancelFounded.do")
	public String cancleFounded(@RequestParam String marketNo, Model model) {
		logger.info("창업 신청 취소 요청");
		logger.info("marketNo="+marketNo);
		
		int result = marketOwnerService.cancelFounded(marketNo);
		
		model.addAttribute("msg", result>0?"창업 신청이 취소되었습니다.":"창업 신청 취소에 실패했습니다. 관리자에게 문의하세요.");
		model.addAttribute("loc", "/");
		
		return "common/msg";
	}
	
	@RequestMapping("/marketOrder.do")
	public String marketOrder() {
		logger.info("지점 주문내역 페이지 요청");
		return "marketOwner/marketOrder";
	}
	
	@RequestMapping("/myMarket.do")
	public String myMarket(@RequestParam String memberId, Model model) {
		logger.info("내 지점 관리 페이지 요청");
		
		MarketMember market = marketOwnerService.selectByMemberId(memberId);
		logger.info("market@="+market);
		
		model.addAttribute("market", market);
		
		return "marketOwner/myMarket";
	}
	
	@RequestMapping("/marketList.do")
	public String marketList() {
		logger.info("매장 리스트 페이지 요청");
		return "marketOwner/marketList";
	}
	
}
