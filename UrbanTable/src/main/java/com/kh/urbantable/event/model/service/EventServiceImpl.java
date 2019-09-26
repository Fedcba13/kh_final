package com.kh.urbantable.event.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.event.model.dao.EventDAO;
import com.kh.urbantable.event.model.vo.Coupon;
import com.kh.urbantable.member.model.vo.Member;

@Service
public class EventServiceImpl implements EventService{

	@Autowired
	EventDAO eventDAO;

	@Override
	public int insertCoupon1(Map<String, String> event) {

		return eventDAO.insertCoupon1(event);
	}}
