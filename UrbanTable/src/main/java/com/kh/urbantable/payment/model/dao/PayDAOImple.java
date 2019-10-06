package com.kh.urbantable.payment.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.urbantable.payment.model.vo.Pay;
import com.kh.urbantable.payment.model.vo.PayDetail;
import com.kh.urbantable.payment.model.vo.Payment_;

@Repository
public class PayDAOImple implements PayDAO {
	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	Logger logger = LoggerFactory.getLogger(getClass());

	@Override
	public int insertPay(Pay pay) {
		return sqlSession.insert("pay.insertPay", pay);
	}

	@Override
	public String getMarketNo(String address) {
		return sqlSession.selectOne("pay.getMarketNo", address);
				
	}

	@Override
	public String getPayNo(String memberId) {
		return sqlSession.selectOne("pay.getPayNo", memberId);
	}

	@Override
	public int insertPayDetail(PayDetail payDetail) {
		return sqlSession.insert("pay.insertPayDetail", payDetail);
	}

	@Override
	public List<Pay> getPayDetail() {
		return sqlSession.selectList("pay.getPayDetail");
	}

	@Override
	public void updateStock(Map<String, Object> map) {
		sqlSession.update("pay.updateStock", map);		
	}

	@Override
	public int deletePayDetail(PayDetail payDetail) {
		return sqlSession.delete("pay.deletePayDetail", payDetail);
	}

	@Override
	public void rollbackStock(Map<String, Object> map) {
		sqlSession.update("pay.rollbackStock", map);		
	}

	@Override
	public int deletePayInfo(Pay pay) {
		return sqlSession.delete("pay.deletePayInfo", pay);
	}

	@Override
	public int updatePayInfo(Pay pay) {
		return sqlSession.update("pay.updatePayInfo", pay);
	}

	@Override
	public int insertPayment(Payment_ payment) {
		return sqlSession.insert("pay.insertPayment", payment);
	}

	@Override
	public int deleteCart(Map<String, Object> map) {
		return sqlSession.delete("pay.deleteCart", map);
	}

	@Override
	public List<Map<String, Object>> getCoupons(String memberId) {
		return sqlSession.selectList("pay.getCoupons", memberId);
	}

	@Override
	public int updateCoupon(Map<String, String> map) {
		return sqlSession.update("pay.updateCoupon", map);
	}

	@Override
	public int updatePoint(Map<String, Object> map) {
		return sqlSession.update("pay.updatePoint", map);
	}
}
