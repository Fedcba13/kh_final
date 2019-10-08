package com.kh.urbantable.review.model.dao;

import java.util.List;
import java.util.Map;

public interface ReviewDAO {

	int insertReview(Map<String, Object> param);

	int updateReview(Map<String, Object> param);

	int deleteReview(Map<String, Object> param);

	List<Map<String, Object>> selectReview(Map<String, Object> param);

}
