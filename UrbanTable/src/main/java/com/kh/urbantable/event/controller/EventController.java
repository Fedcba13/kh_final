package com.kh.urbantable.event.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.urbantable.common.util.FileRenameUtils;
import com.kh.urbantable.event.model.service.EventService;
import com.kh.urbantable.event.model.vo.Coupon;
import com.kh.urbantable.event.model.vo.Event;
import com.kh.urbantable.event.model.vo.EventWithFoodSection;
import com.kh.urbantable.member.model.vo.Member;

@Controller
@RequestMapping("/event")
public class EventController {

	@Autowired
	EventService eventService;

	private Logger logger = LoggerFactory.getLogger(getClass());

	@RequestMapping("/eventList.do")
	public String eventList(Model model) {

		List<EventWithFoodSection> list = eventService.selectEventList();

		logger.info("event={}", list);
		model.addAttribute("list", list);

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
		model.addAttribute("msg", result > 0 ? "쿠폰발급이 완료되었습니다" : "이미 쿠폰이 지급되었습니다.");
		model.addAttribute("loc", "/event/eventMain.do");

		return "/common/msg";

	}

	@RequestMapping("/marketEventEnroll.do")
	public String marketEventEnroll(@RequestParam(value = "memberId") String memberId, Model model) {

		String marketNo = "";
		String msg = "";
		String loc = "";
		try {
			if (memberId != null) {
				Member m = eventService.selectOne(memberId);

				logger.info("selectOne={}", m);
				if (m.getMemberCheck() != 9) {

					marketNo = eventService.selectMarketNoByMemberId(memberId);

				}

				model.addAttribute("eventMarketNo", marketNo);

				return "marketOwner/marketEventEnroll";
			} else {

			}
		} catch (NullPointerException e) {
			e.printStackTrace();
		}

		msg = "로그인 후 이용해주세요";
		loc = "/";
		model.addAttribute("msg", msg);
		model.addAttribute("loc", loc);
		return "/common/msg";
	}

	@PostMapping("/marketEventEnrollEnd.do")
	public String marketEventEnrollEnd(Event event, @RequestParam("eventCategory1") String eventCategory1,
			@RequestParam("eventFile1") MultipartFile eventFile, HttpServletRequest request) {

		logger.info("event={}", event);
		logger.info("event={}", eventCategory1);
		try {

			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/images/event");
			logger.info("saveDirectory={}", saveDirectory);

			String realFile = eventFile.getOriginalFilename();
			String renamed = FileRenameUtils.getRenamedFileName(realFile);
			event.setEventFile(renamed);

			try {

				eventFile.transferTo(new File(saveDirectory, "/" + renamed));

			} catch (Exception e) {
				e.printStackTrace();

			}

		} catch (Exception e) {

		}
		int result = eventService.insertEvent(event);

		return "marketOwner/marketEventEnroll";
	}

	@RequestMapping("/deleteEvent.do")
	public String deleteEvent(@RequestParam("eventId") String eventId, Model model) {

		eventService.deleteEvent(eventId);

		List<EventWithFoodSection> list = eventService.selectEventList();

		logger.info("event={}", list);
		model.addAttribute("list", list);

		return "/marketOwner/eventList";
	}

	@RequestMapping("/mainEventList.do")
	@ResponseBody
	public List<Event> mailList(Model model) {

		List<Event> list = eventService.selectEventAllList();

		logger.info("list={}", list);
		return list;
	}

	@RequestMapping("/eventMain.do")
	public String eventMail() {

		return "/event/event_main";
	}

}
