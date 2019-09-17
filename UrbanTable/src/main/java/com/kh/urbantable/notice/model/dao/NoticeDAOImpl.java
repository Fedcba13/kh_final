package com.kh.urbantable.notice.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.urbantable.notice.model.vo.Notice;


@Repository
public class NoticeDAOImpl implements NoticeDAO{

	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Override
	public List<Notice> noticeList() {
		
		return sqlSession.selectList("notice.noticeList"); 
	}

	@Override
	public Notice selectOne(String noticeNo) {
		
		return sqlSession.selectOne("notice.selectOne", noticeNo);
	}

	@Override
	public int readcount(String noticeNo) {
		
		return sqlSession.update("notice.readcount", noticeNo);
	}

	@Override
	public int insertNotice(Notice notice) {
		
		return sqlSession.insert("notice.insertNotice", notice);
	}

	@Override
	public int updateNotice(Notice notice) {
		
		return sqlSession.update("notice.updateNotice", notice);
	}

	@Override
	public int deleteNotice(String noticeNo) {
		
		return sqlSession.update("notice.deleteNotice", noticeNo);
	}

	
}
