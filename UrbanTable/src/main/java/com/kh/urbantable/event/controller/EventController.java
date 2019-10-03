package com.kh.urbantable.event.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.urbantable.event.model.service.EventService;
import com.kh.urbantable.event.model.vo.Coupon;
import com.kh.urbantable.event.model.vo.Event;
import com.kh.urbantable.member.model.vo.Member;

@Controller
@RequestMapping("/event")
public class EventController {

	@Autowired
	EventService eventService;
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/eventList.do")
	public String eventList() {
		
		return "/marketOwner/eventList";
	}
	
	@RequestMapping("/insertCoupon.do")
	public String insertCoupun1(Member memberLoggedIn, Model model, HttpSession session, Coupon coupon) {
		
		memberLoggedIn = (Member) session.getAttribute("memberLoggedIn");
		
		Map<String, String> event = new HashMap();
		event.put("memberId", memberLoggedIn.getMemberId());
		event.put("couponDiscount", coupon.getCouponDiscount());
		
		int result = eventService.insertCoupon1(event);
		
		String msg = "";
		String loc = "";
		model.addAttribute("msg", result>0?"쿠폰발급이 완료되었습니다":"관리자에게 문의하세요");
		model.addAttribute("loc", "/event/eventList.do");
		
		return "/common/msg";
	}

	@RequestMapping("/marketEventEnroll.do")
	public String marketEventEnroll(@RequestParam(value="memberId") String memberId, Model model) {
		
		Member m = eventService.selectOne(memberId);
		logger.info("selectOne={}", m);

		String marketNo = "";
		if(m.getMemberCheck() != 9) {
			
			marketNo = eventService.selectMarketNoByMemberId(memberId);
			
		}
		
		model.addAttribute("eventMarketNo", marketNo);
		
		return "marketOwner/marketEventEnroll";
	}
	
	@PostMapping("/marketEventEnrollEnd.do")
	public String marketEventEnrollEnd(Event event, @RequestParam("eventCategory1") String eventCategory1) {
		
		logger.info("event={}",event);
		logger.info("event={}",eventCategory1);
		int result = eventService.insertEvent(event);
		
		return "marketOwner/marketEventEnroll";
	}
	

	
}
