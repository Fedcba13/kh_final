package com.kh.urbantable.notice.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.urbantable.notice.model.service.NoticeService;
import com.kh.urbantable.notice.model.vo.Notice;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	
	private Logger logger = LoggerFactory.getLogger(getClass());

	
	@RequestMapping("/notice.do")
	private String notice() {
		
		logger.debug("공지사항 시작입니다.");
		return "notice/notice";
	}
	
	@RequestMapping("/noticeList.do")
	private String noticeList(Model model) {
		
		List<Notice> list = noticeService.noticeList();

		model.addAttribute("list", list);
		
		return "notice/notice";
	}
	
	@RequestMapping("/noticeView.do")
	private String noticeView(@RequestParam String noticeNo, Model model) {
		
		Notice notice = noticeService.selectOne(noticeNo);
		
		noticeService.readcount(noticeNo);
		
		logger.debug("noticeService={}", notice);
		
		model.addAttribute("notice", notice);
		
		
		return "notice/noticeView";
	}
}
