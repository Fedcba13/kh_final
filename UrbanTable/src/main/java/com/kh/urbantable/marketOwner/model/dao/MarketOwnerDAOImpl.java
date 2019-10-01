package com.kh.urbantable.marketOwner.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.urbantable.admin.model.vo.MarketMember;
import com.kh.urbantable.cart.model.vo.Cart;
import com.kh.urbantable.event.model.vo.Event;
import com.kh.urbantable.food.model.vo.FoodDivision;
import com.kh.urbantable.marketOwner.model.service.MarketOwnerService;
import com.kh.urbantable.marketOwner.model.vo.Market;
import com.kh.urbantable.marketOwner.model.vo.MarketEvent;

@Repository
public class MarketOwnerDAOImpl implements MarketOwnerDAO {
	
	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public int insertMarketFounded(Market market) {
		return sqlSession.insert("marketOwner.insertMarketFounded", market);
	}

	@Override
	public MarketMember selectByMemberId(String memberId) {
		return sqlSession.selectOne("marketOwner.selectByMemberId", memberId);
	}

	@Override
	public int updateMarketFounded(Market market) {
		return sqlSession.update("marketOwner.updateMarketFounded", market);
	}

	@Override
	public int cancelFounded(String marketNo) {
		return sqlSession.update("marketOwner.cancelFounded", marketNo);
	}

	@Override
	public List<Market> selectMarketList(Map<String, Object> param) {
		return sqlSession.selectList("marketOwner.selectMarketList", param);
	}
	
	public int updateMemberFounded(String memberId) {
		return sqlSession.update("marketOwner.updateMemberFounded", memberId);
	}

	@Override
	public int updateMemberCancelFounded(String memberId) {
		return sqlSession.update("marketOwner.updateMemberCancelFounded", memberId);
	}

	@Override
	public int myMarketUpdate(Market market) {
		return sqlSession.update("marketOwner.myMarketUpdate", market);
	}

	@Override
	public int myMarketOpen(String marketNo) {
		return sqlSession.update("marketOwner.myMarketOpen", marketNo);
	}

	@Override
	public List<MarketEvent> selectMarketWithEvent(Map<String, Object> param) {
		return sqlSession.selectList("marketOwner.selectMarketWithEvent", param);
	}

	@Override
	public List<Event> selectEventList(Map<String, Object> param) {
		return sqlSession.selectList("marketOwner.selectEventList", param);
	}

	@Override
	public List<Market> searchMarketList(Map<String, Object> param) {
		return sqlSession.selectList("marketOwner.searchMarketList", param);
	}

	@Override
	public List<String> eventCompanySearch(String srchCompany) {
		return sqlSession.selectList("marketOwner.eventCompanySearch", srchCompany);
	}

	@Override
	public List<Map<String, String>> eventSearchCategory(Map<String, String> param) {
		return sqlSession.selectList("marketOwner.eventSearchCategory", param);
	}

	@Override
	public String selectMarketNoByMemberId(String memberId) {
		return sqlSession.selectOne("marketOwner.selectMarketNoByMemberId", memberId);
	}

	@Override
	public List<Map<String, String>> selectFoodStockList(int cPage, Map<String, String> param) {
		//offset : 건너뛸 페이지. 
		//limit
		int offset = (cPage-1)*MarketOwnerService.NUM_PER_PAGE;
		int limit = MarketOwnerService.NUM_PER_PAGE;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return sqlSession.selectList("marketOwner.selectFoodStockList", param, rowBounds);
	}

	@Override
	public int selectTotalContents(Map<String, String> param) {
		return sqlSession.selectOne("marketOwner.selectTotalContents", param);
	}

	@Override
	public List<FoodDivision> selectFoodDivision() {
		return sqlSession.selectList("marketOwner.selectFoodDivision");
	}

	@Override
	public int insertMarketOrderCart(Map<String, Object> param) {
		return sqlSession.insert("marketOwner.insertMarketOrderCart", param);
	}

	@Override
	public List<Cart> checkMarketCart(Map<String, Object> param) {
		return sqlSession.selectList("marketOwner.checkMarketCart", param);
	}

	@Override
	public int updateMarketOrderCart(Map<String, Object> param) {
		return sqlSession.update("marketOwner.updateMarketOrderCart", param);
	}

	@Override
	public List<Map<String, String>> selectMarketCartList(int cPage, Map<String, String> param) {
		int offset = (cPage-1)*MarketOwnerService.NUM_PER_PAGE;
		int limit = MarketOwnerService.NUM_PER_PAGE;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return sqlSession.selectList("marketOwner.selectMarketCartList", param, rowBounds);
	}

	@Override
	public int selectCartTotalContents(Map<String, String> param) {
		return sqlSession.selectOne("marketOwner.selectCartTotalContents", param);
	}

	@Override
	public int delMarketOrderCart(Map<String, String> param) {
		return sqlSession.delete("marketOwner.delMarketOrderCart", param);
	}

	@Override
	public int selectCartTotal(String memberId) {
		return sqlSession.selectOne("marketOwner.selectCartTotal", memberId);
	}

}
