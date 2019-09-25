package com.kh.urbantable.event.controller;

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
	public String eventList(Member memberLoggedIn, Model model, HttpSession session, Coupon coupon) {
		
		memberLoggedIn = (Member) session.getAttribute("memberLoggedIn");
		
		logger.info("memberLoggedIn={}", memberLoggedIn);
		logger.info("coupon={}", coupon.getCouponDiscount());
		
		return "/event/event_main";
	}
	
}
