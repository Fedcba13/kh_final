package com.kh.urbantable.notice.model.dao;

import java.util.List;

import com.kh.urbantable.notice.model.vo.Notice;

public interface NoticeDAO {

	List<Notice> noticeList();

	Notice selectOne(String noticeNo);

	int readcount(String noticeNo);

	int insertNotice(Notice notice);

	int updateNotice(Notice notice);

	int deleteNotice(String noticeNo);

}
