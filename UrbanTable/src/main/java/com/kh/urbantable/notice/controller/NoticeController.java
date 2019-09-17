package com.kh.urbantable.notice.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.urbantable.member.model.vo.Member;
import com.kh.urbantable.notice.model.service.NoticeService;
import com.kh.urbantable.notice.model.vo.Notice;

@Controller
@RequestMapping("/notice")
public class NoticeController {

	@Autowired
	NoticeService noticeService;

	private Logger logger = LoggerFactory.getLogger(getClass());

	@RequestMapping("/noticeList.do")
	public String noticeList(Model model) {

		List<Notice> list = noticeService.noticeList();

		model.addAttribute("list", list);

		return "notice/notice";
	}

	@RequestMapping("/noticeView.do")
	public String noticeView(@RequestParam String noticeNo, Model model) {

		noticeService.readcount(noticeNo);
		Notice notice = noticeService.selectOne(noticeNo);

		logger.debug("noticeService={}", notice);

		model.addAttribute("notice", notice);

		return "notice/noticeView";
	}

	@RequestMapping("/insertNotice.do")
	public String insertNotice(Member memberLoggedIn, Model model, HttpSession session) {

		String msg = "";
		String view = "";
		memberLoggedIn = (Member) session.getAttribute("memberLoggedIn");
		if (memberLoggedIn.getMemberCheck() != 9) {
			logger.debug("memberLoggedIn={}", memberLoggedIn);
			msg = "관리자 로그인 후 이용 가능합니다.";
			model.addAttribute("msg", "관리자 로그인 후 이용 가능합니다.");
			model.addAttribute("loc", "/notice/noticeList.do");
		} else {
			
			model.addAttribute("loc", "/notice/insertNotice.jsp");
		}

		return "common/msg";
	}

	@RequestMapping("/insertNoticeEnd.do")
	public String insertNoticeEnd(HttpServletRequest request, Notice notice) {

		logger.debug("noticeInsert={}", notice);

		Notice noti = noticeService.selectOne(notice.getNoticeNo());

		logger.debug("notice={}", noti);

		if (noti.getNoticeNo() != notice.getNoticeNo()) {
			noticeService.updateNotice(notice);
		} else {
			noticeService.insertNotice(notice);

		}

		return "notice/noticeView";
	}

	@RequestMapping("/noticeUpdateFrm.do")
	public String updateFrm(@RequestParam String noticeNo, Model model) {
		Notice notice = noticeService.selectOne(noticeNo);

		logger.debug("noticeService={}", notice);

		model.addAttribute("notice", notice);
		return "notice/updateForm";
	}

	@RequestMapping("/deleteNotice.do")
	public String deleteNotice(@RequestParam String noticeNo, Model model) {

		noticeService.deleteNotice(noticeNo);

		List<Notice> list = noticeService.noticeList();

		model.addAttribute("list", list);

		return "notice/notice";
	}

}
