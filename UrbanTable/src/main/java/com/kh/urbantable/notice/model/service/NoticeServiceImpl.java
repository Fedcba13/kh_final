package com.kh.urbantable.notice.model.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.notice.model.dao.NoticeDAO;
import com.kh.urbantable.notice.model.vo.Notice;

@Service
public class NoticeServiceImpl implements NoticeService{

	@Autowired
	NoticeDAO noticeDAO;
	
	Logger logger = LoggerFactory.getLogger(getClass());

	@Override
	public List<Notice> noticeList() {
		
		return noticeDAO.noticeList();
	}

	@Override
	public Notice selectOne(String noticeNo) {
		
		return noticeDAO.selectOne(noticeNo);
	}

	@Override
	public int readcount(String noticeNo) {
		
		return noticeDAO.readcount(noticeNo);
	}
}
