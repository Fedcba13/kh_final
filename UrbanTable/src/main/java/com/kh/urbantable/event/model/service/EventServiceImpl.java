package com.kh.urbantable.event.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.event.model.dao.EventDAO;
import com.kh.urbantable.event.model.vo.Coupon;
import com.kh.urbantable.event.model.vo.Event;
import com.kh.urbantable.event.model.vo.EventWithFoodSection;
import com.kh.urbantable.member.model.vo.Member;

@Service
public class EventServiceImpl implements EventService{

	@Autowired
	EventDAO eventDAO;

	@Override
	public int insertCoupon1(Map<String, String> event) {

		return eventDAO.insertCoupon1(event);
	}

	@Override
	public Member selectOne(String memberId) {
		
		return eventDAO.selectOne(memberId);
	}

	@Override
	public String selectMarketNoByMemberId(String memberId) {
		
		return eventDAO.selectMarketNoByMemberId(memberId);
	}

	@Override
	public int insertEvent(Event event) {

		return eventDAO.insertEvent(event);
	}

	@Override
	public List<EventWithFoodSection> selectEventList() {
		
		return eventDAO.selectEventList();
	}

	@Override
	public int deleteEvent(String eventId) {
		
		return eventDAO.deleteEvent(eventId);
	}

	@Override
	public List<Event> selectEventAllList() {
		
		return eventDAO.selectEventAllList();
	}

	@Override
	public List<Coupon> selectAllCoupon() {

		return eventDAO.selectAllCoupon();
	}
	
	
}
