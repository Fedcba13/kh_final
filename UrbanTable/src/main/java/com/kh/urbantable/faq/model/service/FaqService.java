package com.kh.urbantable.faq.model.service;

import java.util.List;
import java.util.Map;

import com.kh.urbantable.faq.model.vo.Faq;

public interface FaqService {
	//페이지당 게시물수
//	int NUM_PER_PAGE = 10;
	
	List<Faq> selectFaqList();

	Faq selectOneFaq(String noticeNo);
	
	int insertFaq(Faq faq);

	int updateFaq(Faq faq);
	
	int deleteFaq(String noticeNo);

	Map<String, String> selectPreNext(String noticeNo);

}
