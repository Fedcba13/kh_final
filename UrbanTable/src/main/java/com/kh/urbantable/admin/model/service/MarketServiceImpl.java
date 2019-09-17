package com.kh.urbantable.admin.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.admin.model.dao.MarketDAO;

@Service
public class MarketServiceImpl implements MarketService{
	
	@Autowired
	MarketDAO marketDAO;

}
