package com.kh.urbantable.review.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReviewDAOImpl implements ReviewDAO {
	
	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public int insertReview(Map<String, Object> param) {
		return sqlSession.insert("review.insertReview", param);
	}

	@Override
	public int updateReview(Map<String, Object> param) {
		return sqlSession.update("review.updateReview", param);
	}

	@Override
	public int deleteReview(Map<String, Object> param) {
		return sqlSession.delete("review.deleteReview", param);
	}

	@Override
	public List<Map<String, Object>> selectReview(Map<String, Object> param) {
		return sqlSession.selectList("review.selectReview", param);
	}

}
