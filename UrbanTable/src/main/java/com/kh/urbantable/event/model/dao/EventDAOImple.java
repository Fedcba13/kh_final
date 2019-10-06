package com.kh.urbantable.event.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.urbantable.event.model.vo.Event;
import com.kh.urbantable.event.model.vo.EventWithFoodSection;
import com.kh.urbantable.member.model.vo.Member;

@Repository
public class EventDAOImple implements EventDAO{

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public int insertCoupon1(Map<String, String> event) {
		
		return sqlSession.insert("event.insertCoupon1", event);
	}

	@Override
	public Member selectOne(String memberId) {
		
		return sqlSession.selectOne("event.selectOne", memberId);
	}

	@Override
	public String selectMarketNoByMemberId(String memberId) {
		
		return sqlSession.selectOne("event.selectMarketNoByMemberId", memberId);
	}

	@Override
	public int insertEvent(Event event) {

		return sqlSession.insert("event.insertEvent", event);
	}

	@Override
	public List<EventWithFoodSection> selectEventList() {

		return sqlSession.selectList("event.selectEventList");
	}

	@Override
	public int deleteEvent(String eventId) {
		
		return sqlSession.update("event.deleteEvent", eventId);
	}

	@Override
	public List<Event> selectEventAllList() {
		
		return sqlSession.selectList("event.selectEventAllList");
	}
}
