package com.kh.urbantable.marketOwner.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.urbantable.admin.model.vo.MarketMember;
import com.kh.urbantable.marketOwner.model.service.MarketOwnerService;
import com.kh.urbantable.marketOwner.model.vo.Event;
import com.kh.urbantable.marketOwner.model.vo.Market;
import com.kh.urbantable.member.model.vo.Member;

@Controller
@RequestMapping("/market")
public class MarketOwnerController {

	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	MarketOwnerService marketOwnerService;
	
	@RequestMapping("/founded.do")
	public String founded() {
		logger.info("창업 신청 페이지 요청");
		return "marketOwner/founded";
	}
	
	@RequestMapping(value="/foundedEnd.do", method=RequestMethod.POST)
	public String foundedEnd(Market market, Model model, HttpServletRequest request) {
		logger.info("창업 신청 insert 요청");
		logger.info("market="+market);
		
		int result = marketOwnerService.insertMarketFounded(market);
		
		model.addAttribute("msg", result>0?"창업 신청이 완료되었습니다.":"창업 신청에 실패했습니다. 관리자에게 문의하세요.");
		model.addAttribute("loc", "/");
		
		if(result>0) {
			HttpSession session = request.getSession(true);
			Member member = (Member)session.getAttribute("memberLoggedIn");
			member.setMemberCheck(2);
		}
		
		return "common/msg";
	}
	
	@RequestMapping("/foundedEndView.do")
	public String foundedEndView(@RequestParam(value="memberId") String memberId, Model model) {
		logger.info("창업 신청 내역 페이지 요청");
		
		MarketMember market = marketOwnerService.selectByMemberId(memberId);
		logger.info("marketMember@controller="+market);
		
		model.addAttribute("founded", market);
		
		return "marketOwner/foundedEndView";
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
	public String cancleFounded(@RequestParam String marketNo, @RequestParam String memberId, 
			Model model, HttpServletRequest request) {
		logger.info("창업 신청 취소 요청");
		logger.info("marketNo="+marketNo);
		
		int result = marketOwnerService.cancelFounded(marketNo, memberId);
		
		model.addAttribute("msg", result>0?"창업 신청이 취소되었습니다.":"창업 신청 취소에 실패했습니다. 관리자에게 문의하세요.");
		model.addAttribute("loc", "/");
		
		if(result>0) {
			HttpSession session = request.getSession(true);
			Member member = (Member)session.getAttribute("memberLoggedIn");
			member.setMemberCheck(1);
		}
		
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
	
	@ResponseBody
	@RequestMapping("/myMarketUpdate.do")
	public Map<String, String> myMarketUpdate(@RequestParam(value="marketNo") String marketNo,
			@RequestParam(value="marketTelephone") String marketTelephone,
			@RequestParam(value="marketHoliday") String marketHoliday,
			@RequestParam(value="marketTime") String marketTime) {
		logger.info("내 지점 정보 수정 요청");
		
		Market market = new Market();
		market.setMarketNo(marketNo);
		market.setMarketTelephone(marketTelephone);
		market.setMarketHoliday(marketHoliday);
		market.setMarketTime(marketTime);
		
		int result = marketOwnerService.myMarketUpdate(market);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("marketTelephone", marketTelephone);
		map.put("result", result>0?"지점 정보를 수정하였습니다.":"지점 정보 수정에 실패했습니다. 관리자에게 문의하세요");
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping("/myMarketOpen.do")
	public Map<String, String> myMarketOpen(@RequestParam(value="marketNo") String marketNo){
		logger.info("지점 오픈 요청");
		
		int result = marketOwnerService.myMarketOpen(marketNo);
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", result>0?"지점을 오픈하였습니다.":"지점 오픈에 실패했습니다. 관리자에게 문의하세요");
		
		return map;
	}
	
	@RequestMapping("/marketList.do")
	public String marketList(Model model) {
		logger.info("매장 리스트 페이지 요청");
		//List<MarketEvent> marketList = marketOwnerService.selectMarketWithEvent();
		//model.addAttribute("marketList", marketList);
		return "marketOwner/marketList";
	}
	
	@ResponseBody
	@RequestMapping("/selectMarketList.do")
	public Map<String, Object> selectMarketList(@RequestParam(value="flag") int flag,
			@RequestParam(value="marketNo") String marketNo,
			@RequestParam(value="marketAddress") String marketAddress){
		
		logger.info("매장 리스트 타입={}, 매장 번호={}",flag, marketNo);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("flag", flag);
		param.put("marketNo", marketNo);
		param.put("marketAddress", marketAddress);
		logger.info("param="+param);
		
		List<Market> marketList = marketOwnerService.selectMarketList(param);
		List<Event> eventList = marketOwnerService.selectEventList(param);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("marketList", marketList);
		result.put("eventList", eventList);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/searchMarket.do") 
	public Map<String, Object> searchMarket(@RequestParam(value="flag") int flag,
			@RequestParam(value="marketAddress") String marketAddress){
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("flag", flag);
		param.put("marketAddress", marketAddress);
		logger.info("param="+param);
		
		Map<String, Object> searchList = marketOwnerService.searchMarketList(param);
		return searchList;
	}
	
	@RequestMapping("/event.do")
	public String marketEvent() {
		return "marketOwner/eventList";
	}
	
	@RequestMapping("/marketEventEnroll.do")
	public String marketEventEnroll(@RequestParam(value="memberId") String memberId, Model model) {
		String marketNo = marketOwnerService.selectMarketNoByMemberId(memberId);
		model.addAttribute("eventMarketNo", marketNo);
		return "marketOwner/marketEventEnroll";
	}
	
	@ResponseBody
	@RequestMapping("/eventCompanySearch.do")
	public List<String> eventCompanySearch(@RequestParam(value="srchCompany") String srchCompany){
		List<String> foodCompanyList = marketOwnerService.eventCompanySearch(srchCompany);
		return foodCompanyList;
	}
	
	@ResponseBody
	@RequestMapping("/eventSearchCategory.do")
	public List<Map<String, String>> eventSearchCategory(@RequestParam(value="srchCompany") String srchCompany,
			@RequestParam(value="eventCategory") String eventCategory){
		Map<String, String> param = new HashMap<String, String>();
		param.put("srchCompany", srchCompany);
		param.put("eventCategory", eventCategory);
		
		List<Map<String, String>> result = marketOwnerService.eventSearchCategory(param);
		
		return result;
	}
	
	@PostMapping("/marketEventEnrollEnd.do")
	public String marketEventEnrollEnd(Event event) {
		logger.info("event={}",event);
		return "marketOwner/marketEventEnroll";
	}
	
}
