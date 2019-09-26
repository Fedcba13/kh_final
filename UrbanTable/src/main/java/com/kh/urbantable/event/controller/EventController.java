package com.kh.urbantable.event.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.urbantable.event.model.service.EventService;
import com.kh.urbantable.event.model.vo.Coupon;
import com.kh.urbantable.member.model.vo.Member;

@Controller
@RequestMapping("/event")
public class EventController {

	@Autowired
	EventService eventService;
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/eventList.do")
	public String eventList() {
		
		return "/event/event_main";
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
		model.addAttribute("loc", "/event/event_main");
		
		return "/common/msg";
	}
	
}
