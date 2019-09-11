package com.kh.urbantable.notice.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.urbantable.notice.model.service.NoticeService;
import com.kh.urbantable.notice.model.vo.Notice;

@Controller
@RequestMapping("/admin2")
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	
	private Logger logger = LoggerFactory.getLogger(getClass());

	
	@RequestMapping("/notice.do")
	private String notice() {
		
		logger.debug("공지사항 시작입니다.");
		return "admin2/notice";
	}
	
	@RequestMapping("/noticeList.do")
	private String noticeList(Model model) {
		
		List<Notice> list = noticeService.noticeList();
		if(list == null) {
			logger.error("망했다");
		}
		
		logger.debug("list={}", list);
		model.addAttribute("list", list);
		
		return "admin2/notice";
	}
}
