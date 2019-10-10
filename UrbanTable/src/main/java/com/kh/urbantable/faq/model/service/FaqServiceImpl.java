package com.kh.urbantable.faq.model.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.faq.model.dao.FaqDAO;
import com.kh.urbantable.faq.model.exception.FaqException;
import com.kh.urbantable.faq.model.vo.Faq;

@Service
public class FaqServiceImpl implements FaqService {

	@Autowired
	FaqDAO faqDAO;

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Override
	public List<Faq> selectFaqList() {
		return faqDAO.selectFaqList();
	}

	@Override
	public Faq selectOneFaq(String noticeNo) {
		return faqDAO.selectOneFaq(noticeNo);
	}
	
	@Override
	public int insertFaq(Faq faq) {
		logger.debug("faq={}",faq);
		
		return faqDAO.insertFaq(faq);
	}


	
	@Override
	public int updateFaq(Faq faq) {
		logger.debug("faq={}",faq);
		
		return faqDAO.updateFaq(faq);
	}

	@Override
	public int deleteFaq(String noticeNo) {
		return faqDAO.deleteFaq(noticeNo);
	}

	@Override
	public Map<String, String> selectPreNext(String noticeNo) {
		return faqDAO.selectPreNext(noticeNo);
	}

}
