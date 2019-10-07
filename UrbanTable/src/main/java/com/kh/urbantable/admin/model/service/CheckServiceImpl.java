package com.kh.urbantable.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.admin.model.dao.CheckDAO;
import com.kh.urbantable.foodOrder.model.vo.MarketOrderDetail;
import com.kh.urbantable.recipe.model.vo.Blame;

@Service
public class CheckServiceImpl implements CheckService{

	@Autowired
	CheckDAO checkDAO;

	@Override
	public List<Map<String, Object>> selectAllList() {

		return checkDAO.selectAllList();
	}

	@Override
	public int selectFoodNo(Map<String, Object> param) {

		return checkDAO.selectFoodNo(param);
	}

	@Override
	public int updateAmount(Map<String, Object> param) {
		
		
		
		return checkDAO.updateAmount(param);	
	}

	@Override
	public int insertFood(Map<String, Object> param) {
		
		return checkDAO.insertFood(param);

	}

	@Override
	public List<MarketOrderDetail> selectMODList(String orderNo) {

		return checkDAO.selectMODList(orderNo);
	}

	@Override
	public int updateFlag(String orderNo) {

		return checkDAO.updateFlag(orderNo);
	}

	@Override
	public List<Blame> selectBlameList() {
		
		return checkDAO.selectBlameList();
	}

	
}
