package com.kh.urbantable.review.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.review.model.dao.ReviewDAO;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Autowired
	ReviewDAO reviewDAO;

	@Override
	public int insertReview(Map<String, Object> param) {
		return reviewDAO.insertReview(param);
	}

	@Override
	public int updateReview(Map<String, Object> param) {
		return reviewDAO.updateReview(param);
	}

	@Override
	public int deleteReview(Map<String, Object> param) {
		return reviewDAO.deleteReview(param);
	}

	@Override
	public List<Map<String, Object>> selectReview(Map<String, Object> param) {
		return reviewDAO.selectReview(param);
	}

}
