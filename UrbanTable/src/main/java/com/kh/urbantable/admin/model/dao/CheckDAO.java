package com.kh.urbantable.admin.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.urbantable.foodOrder.model.vo.MarketOrderDetail;
import com.kh.urbantable.recipe.model.vo.Blame;

public interface CheckDAO {

	List<Map<String, Object>> selectAllList();

	int selectFoodNo(Map<String, Object> param);

	int updateAmount(Map<String, Object> param);

	int updateFlag(String orderNo);

	int insertFood(Map<String, Object> param);

	List<MarketOrderDetail> selectMODList(String orderNo);

	List<Blame> selectBlameList();

	Blame selectBlame(String blameId);

	int blameActionChk(Blame b);

	int updateComment(Blame b);

}
