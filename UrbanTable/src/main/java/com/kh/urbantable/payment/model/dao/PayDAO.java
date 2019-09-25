package com.kh.urbantable.payment.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.urbantable.payment.model.vo.Pay;
import com.kh.urbantable.payment.model.vo.PayDetail;

public interface PayDAO {

	int insertPay(Pay pay);

	String getMarketNo(String address);

	String getPayNo(String memberId);

	int insertPayDetail(PayDetail payDetail);

	List<Pay> getPayDetail();

}
