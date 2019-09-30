package com.kh.urbantable.event.model.service;

import java.util.Map;

import com.kh.urbantable.event.model.vo.Coupon;
import com.kh.urbantable.event.model.vo.Event;
import com.kh.urbantable.member.model.vo.Member;

public interface EventService {

	int insertCoupon1(Map<String, String> event);

	Member selectOne(String memberId);

	String selectMarketNoByMemberId(String memberId);

	int insertEvent(Event event);

}
