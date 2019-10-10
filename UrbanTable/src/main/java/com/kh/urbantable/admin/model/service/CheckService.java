package com.kh.urbantable.admin.model.service;

import java.util.List;
import java.util.Map;

import com.kh.urbantable.foodOrder.model.vo.MarketOrderDetail;
import com.kh.urbantable.recipe.model.vo.Blame;

public interface CheckService {

	List<Map<String, Object>> selectAllList();

	int selectFoodNo(Map<String, Object> param);

	int updateAmount(Map<String, Object> param);

	int insertFood(Map<String, Object> param);

	List<MarketOrderDetail> selectMODList(String orderNo);

	int updateFlag(String orderNo);

	List<Blame> selectBlameList();

	Blame selectBlame(String blameId);

	int blameActionChk(Blame b);

	int notBlameChk(Blame b);

}
