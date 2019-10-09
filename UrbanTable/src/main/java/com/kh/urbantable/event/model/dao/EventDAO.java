package com.kh.urbantable.event.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.urbantable.event.model.vo.Coupon;
import com.kh.urbantable.event.model.vo.Event;
import com.kh.urbantable.event.model.vo.EventWithFoodSection;
import com.kh.urbantable.member.model.vo.Member;

public interface EventDAO {

	int insertCoupon1(Map<String, String> event);

	Member selectOne(String memberId);

	String selectMarketNoByMemberId(String memberId);

	int insertEvent(Event event);

	List<EventWithFoodSection> selectEventList();

	int deleteEvent(String eventId);

	List<Event> selectEventAllList();

	List<Coupon> selectAllCoupon();

}
