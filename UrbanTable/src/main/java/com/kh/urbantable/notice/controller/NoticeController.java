package com.kh.urbantable.notice.controller;

import java.io.File;
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
import org.springframework.web.multipart.MultipartFile;

import com.kh.urbantable.common.util.FileRenameUtils;
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
		Map<String, String> preNext = noticeService.selectPreNext(noticeNo);

		logger.info("preNext={}", preNext);
		model.addAttribute("notice", notice);
		model.addAttribute("preNext", preNext);

		return "notice/noticeView";
	}

	@RequestMapping("/insertNotice.do")
	public String insertNotice(@SessionAttribute Member memberLoggedIn, Model model, HttpSession session) {

		return "/notice/insertNotice";
	}

	@RequestMapping("/insertNoticeEnd.do")
	public String insertNoticeEnd(@SessionAttribute Member memberLoggedIn, Model model,
			@RequestParam("noticeFile1") MultipartFile noticeFile, HttpServletRequest request, Notice notice) {

		logger.debug("noticeInsert={}", notice);
		Notice noti = new Notice();

		logger.info("noticeFile={}", noticeFile);

		// 파일 저장
		try {

			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/images/notice");
			logger.info("saveDirectory={}", saveDirectory);

			String realFile = noticeFile.getOriginalFilename();
			String renamed = FileRenameUtils.getRenamedFileName(realFile);
			notice.setNoticeFile(renamed);
			notice.setNoticeWriter(memberLoggedIn.getMemberId());

			try {

				noticeFile.transferTo(new File(saveDirectory + "/" + renamed));

			} catch (Exception e) {
				e.printStackTrace();

			}
		} catch (Exception e) {

		}
		// 유효성검사
		try {
			noti = noticeService.selectOne(notice.getNoticeNo());
		} catch (NullPointerException e) {
			e.printStackTrace();
		}

		logger.debug("noti={}", noti);

		if (noti == null) {
			noticeService.insertNotice(notice);
		} else {
			noticeService.updateNotice(notice);
		}

		logger.debug("notice={}", notice);
		
		List<Notice> list = noticeService.noticeList();

		model.addAttribute("list", list);


		return "notice/notice";
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
