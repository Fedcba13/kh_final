package com.kh.urbantable.foodOrder.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.urbantable.foodOrder.model.service.FoodOrderService;
import com.kh.urbantable.foodOrder.model.vo.MarketCart;
import com.kh.urbantable.foodOrder.model.vo.MarketOrder;
import com.kh.urbantable.foodOrder.model.vo.MarketOrderDetail;

@Repository
public class FoodOrderDAOImpl implements FoodOrderDAO {

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public String selectMarketNoByMemberId(String memberId) {
		return sqlSession.selectOne("marketOwner.selectMarketNoByMemberId", memberId);
	}

	@Override
	public int insertMarketOrder(MarketOrder marketOrder) {
		return sqlSession.insert("foodOrder.insertMarketOrder", marketOrder);
	}

	@Override
	public int insertMarketOrderDetail(MarketOrderDetail marketOrderDetail) {
		return sqlSession.insert("foodOrder.insertMarketOrderDetail", marketOrderDetail);
	}

	@Override
	public int deleteMarketCart(Map<String, String> param) {
		return sqlSession.delete("foodOrder.deleteMarketCart", param);
	}

	@Override
	public List<MarketCart> selectMarketCartAllList(String memberId) {
		return sqlSession.selectList("foodOrder.selectMarketCartAllList", memberId);
	}

	@Override
	public List<Map<String, String>> selectMarketOrderList(int cPage, String marketNo) {
		int offset = (cPage-1)*FoodOrderService.NUM_PER_PAGE;
		int limit = FoodOrderService.NUM_PER_PAGE;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return sqlSession.selectList("foodOrder.selectMarketOrderList", marketNo, rowBounds);
	}

	@Override
	public int selectMarketOrderTotal(String marketNo) {
		return sqlSession.selectOne("foodOrder.selectMarketOrderTotal", marketNo);
	}

	@Override
	public List<Map<String, String>> selectMarketOrderDetail(int cPage, String marketOrderNo) {
		int offset = (cPage-1)*FoodOrderService.NUM_PER_PAGE;
		int limit = FoodOrderService.NUM_PER_PAGE;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return sqlSession.selectList("foodOrder.selectMarketOrderDetail", marketOrderNo, rowBounds);
	}

	@Override
	public int selectMarketOrderDetailTotal(String marketOrderNo) {
		return sqlSession.selectOne("foodOrder.selectMarketOrderDetailTotal", marketOrderNo);
	}

	@Override
	public int selectMarketOrderFlag(String marketOrderNo) {
		return sqlSession.selectOne("foodOrder.selectMarketOrderFlag", marketOrderNo);
	}

	@Override
	public int marketOrderUpdateAmount(Map<String, Object> param) {
		return sqlSession.update("foodOrder.marketOrderUpdateAmount", param);
	}

	@Override
	public int marketOrderDeleteFood(String marketOrderDetailNo) {
		return sqlSession.update("foodOrder.marketOrderDeleteFood", marketOrderDetailNo);
	}

	@Override
	public int marketOrderDetailDeleteAll(String marketOrderNo) {
		return sqlSession.update("foodOrder.marketOrderDetailDeleteAll", marketOrderNo);
	}

	@Override
	public int marketOrderDeleteAll(String marketOrderNo) {
		return sqlSession.update("foodOrder.marketOrderDeleteAll", marketOrderNo);
	}

	@Override
	public int selectMarketOrderPriceTotal(String marketOrderNo) {
		return sqlSession.selectOne("foodOrder.selectMarketOrderPriceTotal", marketOrderNo);
	}
	
}
