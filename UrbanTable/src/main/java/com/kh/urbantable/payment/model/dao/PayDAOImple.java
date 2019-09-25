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

}
