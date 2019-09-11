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
		List<Notice> asd = sqlSession.selectList("notice.noticeList");
		if(asd == null) {
			System.out.println("망했다");
		}
		return asd; 
	}

	
}
