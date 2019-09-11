package com.kh.urbantable.marketOwner.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.marketOwner.model.dao.MarketOwnerDAO;

@Service
public class MarketOwnerServiceImpl implements MarketOwnerService {

	@Autowired
	MarketOwnerDAO marketOwnerDAO;
	
}
