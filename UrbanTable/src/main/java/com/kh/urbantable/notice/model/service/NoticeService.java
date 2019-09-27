package com.kh.urbantable.notice.model.service;

import java.util.List;
import java.util.Map;

import com.kh.urbantable.notice.model.vo.Notice;

public interface NoticeService {

	List<Notice> noticeList();

	Notice selectOne(String noticeNo);

	int readcount(String noticeNo);

	int insertNotice(Notice notice);

	int updateNotice(Notice notice);

	int deleteNotice(String noticeNo);

	Map<String, String> selectPreNext(String noticeNo);

}
