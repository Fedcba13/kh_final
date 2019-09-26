package com.kh.urbantable.payment.model.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.payment.model.dao.PayDAO;
import com.kh.urbantable.payment.model.vo.Pay;
import com.kh.urbantable.payment.model.vo.PayDetail;

@Service
public class PayServiceImple implements PayService {
	
	@Autowired
	PayDAO payDAO;
	
	Logger logger = LoggerFactory.getLogger(getClass());

	@Override
	public int insertPay(Pay pay) {
		return payDAO.insertPay(pay);
	}

	@Override
	public String getMarketNo(String address) {
		return payDAO.getMarketNo(address);
	}

	@Override
	public String getPayNo(String memberId) {
		return payDAO.getPayNo(memberId);
	}

	@Override
	public int insertPayDetail(PayDetail payDetail) {
		return payDAO.insertPayDetail(payDetail);
	}

	@Override
	public List<Pay> getPayDetail() {
		return payDAO.getPayDetail();
	}

	@Override
	public void updateStock(Map<String, Object> map) {
		payDAO.updateStock(map);		
	}

	@Override
	public int deletePayDetail(PayDetail payDetail) {
		return payDAO.deletePayDetail(payDetail);
	}

	@Override
	public void rollbackStock(Map<String, Object> map) {
		payDAO.rollbackStock(map);	
	}

	@Override
	public int deletePayInfo(Pay pay) {
		return payDAO.deletePayInfo(pay);
	}

}
