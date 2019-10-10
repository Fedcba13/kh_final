package com.kh.urbantable.faq.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.kh.urbantable.faq.model.exception.FaqException;
import com.kh.urbantable.faq.model.service.FaqService;
import com.kh.urbantable.faq.model.vo.Faq;
import com.kh.urbantable.member.model.vo.Member;
import com.kh.urbantable.notice.model.vo.Notice;

@Controller
@RequestMapping("/faq")
public class FaqController {

	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	FaqService faqService;
	
	//@FAQ: 목록
	@RequestMapping("/faqList.do")
	public String faqList(Model model) {
		
		List<Faq> list = faqService.selectFaqList();
		
		model.addAttribute("list", list);
		
		return "faq/faqList";
	}
	
	//@FAQ: 상세보기
	@RequestMapping("/faqView.do")
	public String faqView(@RequestParam String noticeNo,
						  Model model) {
		
		Faq faq = faqService.selectOneFaq(noticeNo);
		
		logger.debug("faqService={}", faq);
		Map<String, String> preNext = faqService.selectPreNext(noticeNo);
		
		logger.info("preNext={}", preNext);
		model.addAttribute("faq", faq);
		model.addAttribute("preNext", preNext);
		
		return "faq/faqView";
	}
	
	//@FAQ: 작성
	@RequestMapping("/faqForm.do")
	public String faqForm(@SessionAttribute Member memberLoggedIn,
						  Model model, HttpSession session) {
		logger.debug("FAQ 작성요청!!");
		return "/faq/faqForm";
	}
	
	//@FAQ: 작성 후
	@RequestMapping("/faqFormEnd.do")
	public String faqFormEnd(@SessionAttribute Member memberLoggedIn,
							 Faq faq,
							 Model model,
							 HttpServletRequest request) {
		logger.debug("FAQ 저장요청!!");
		logger.debug("faqList={}", faq);
		Faq aq = new Faq();
		
		// 유효성검사
		try {
			aq = faqService.selectOneFaq(faq.getNoticeNo());
		} catch (NullPointerException e) {
			e.printStackTrace();
		}

		logger.debug("aq={}", aq);

		if (aq == null) {
			faqService.insertFaq(faq);
		} else {
			faqService.updateFaq(faq);
		}

		logger.debug("faq={}", faq);
		
		List<Faq> list = faqService.selectFaqList();

		model.addAttribute("list", list);

		return "faq/faqList";
		
//		try {
//			
//			logger.debug("faq={}", faq);
//			int result = faqService.insertFaq(faq);
//			String msg = result>0?"FAQ 작성 성공":"FAQ 작성 실패";
//			
//			model.addAttribute("msg", msg);
//			model.addAttribute("loc", "/faq/faqList.do");
//			
//		} catch(Exception e) {
//			logger.error("FAQ 작성 오류", e);
//			
//			throw new FaqException("FAQ 작성 오류", e);
//		}
//		
//		return "common/msg";
	}
	
	
	
	//@FAQ: 수정
	@RequestMapping("/faqUpdate.do")
	public String faqUpdate(@RequestParam String noticeNo,
							Model model) {
		
		logger.debug("FAQ 수정요청!!");
		
		Faq faq = faqService.selectOneFaq(noticeNo);
		
		logger.debug("faqService={}", faq);
		
		model.addAttribute("faq", faq);
		
		return "faq/faqUpdate";
	}
	
	//@FAQ: 삭제
	@RequestMapping("/deleteFaq.do")
	public String deleteFaq(@RequestParam String noticeNo,
							Model model) {
		
		logger.debug("FAQ 삭제요청!!");
		
		faqService.deleteFaq(noticeNo);
		
		List<Faq> list = faqService.selectFaqList();
		
		model.addAttribute("list", list);
		
		return "faq/faqList";
	}
	
//		try {
//			
//			logger.debug("faq={}", faq);
//			int result = faqService.updateFaq(faq);
//			String msg = result>0?"FAQ 수정 성공":"FAQ 수정 실패";
//			
//			model.addAttribute("msg", msg);
//			model.addAttribute("loc", "/faq/faqView.do");
//			
//		} catch(Exception e) {
//			logger.error("FAQ 수정 오류", e);
//			
//			throw new FaqException("FAQ 수정 오류", e);
//		}
//		
//		return "common/msg";
//		
//	}
	
	
}
