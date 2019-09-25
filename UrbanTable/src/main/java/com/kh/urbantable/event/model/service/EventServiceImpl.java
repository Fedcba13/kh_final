package com.kh.urbantable.event.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.event.model.dao.EventDAO;

@Service
public class EventServiceImpl implements EventService{

	@Autowired
	EventDAO eventDAO;
}
