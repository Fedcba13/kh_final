package com.kh.urbantable.payment.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.urbantable.payment.model.vo.Pay;
import com.kh.urbantable.payment.model.vo.PayDetail;
import com.kh.urbantable.payment.model.vo.Payment_;

public interface PayDAO {

	int insertPay(Pay pay);

	String getMarketNo(String address);

	String getPayNo(String memberId);

	int insertPayDetail(PayDetail payDetail);

	List<Pay> getPayDetail();

	void updateStock(Map<String, Object> map);

	int deletePayDetail(PayDetail payDetail);

	void rollbackStock(Map<String, Object> map);

	int deletePayInfo(Pay pay);

	int updatePayInfo(Pay pay);

	int insertPayment(Payment_ payment);

	int deleteCart(Map<String, Object> map);

	List<Map<String, Object>> getCoupons(String memberId);

	int updateCoupon(Map<String, String> map);

}
