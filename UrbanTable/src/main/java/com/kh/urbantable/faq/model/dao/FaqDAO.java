package com.kh.urbantable.faq.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.urbantable.faq.model.vo.Faq;

public interface FaqDAO {

	List<Faq> selectFaqList();

	Faq selectOneFaq(String noticeNo);
	
	int insertFaq(Faq faq);
	
	int updateFaq(Faq faq);
	
	int deleteFaq(String noticeNo);

	Map<String, String> selectPreNext(String noticeNo);
	
}
