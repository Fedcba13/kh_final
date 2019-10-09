package com.kh.urbantable.review.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.urbantable.review.model.service.ReviewService;

@RestController
@RequestMapping("/member")
public class ReviewController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	ReviewService reviewService;
	
	@RequestMapping("/writeReview")
	public Map<String, Object> writeReview(@RequestParam String detailNo,
											@RequestParam String content,
											HttpSession session){
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		Map<String,Object> param = new HashMap<String, Object>();
		param.put("detailNo", detailNo);
		param.put("content", content);
		
		int result = reviewService.insertReview(param);
		
		resultMap.put("msg", result>0 ? "작성 성공" : "작성 실패");
		
		return resultMap;
	}
	
	@RequestMapping("/modifyReview")
	public Map<String, Object> modifyReview(@RequestParam String detailNo,
											@RequestParam String content,
											HttpSession session){
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		Map<String,Object> param = new HashMap<String, Object>();
		param.put("detailNo", detailNo);
		param.put("content", content);
		
		int result = reviewService.updateReview(param);
		
		resultMap.put("msg", result>0 ? "수정 성공" : "수정 실패");
		
		return resultMap;
	}
	
	@RequestMapping("/deleteReview")
	public Map<String, Object> deleteReview(@RequestParam String detailNo,
											HttpSession session){
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		Map<String,Object> param = new HashMap<String, Object>();
		param.put("detailNo", detailNo);
		
		int result = reviewService.deleteReview(param);
		
		resultMap.put("msg", result>0 ? "삭제 성공" : "삭제 실패");
		
		return resultMap;
	}
	
	@RequestMapping("/selectReview")
	public List<Map<String, Object>> selectReview(@RequestParam String marketNo,
											@RequestParam String foodNo,
											HttpSession session){
		
		Map<String,Object> param = new HashMap<String, Object>();
		param.put("marketNo", marketNo);
		param.put("foodNo", foodNo);
		
		List<Map<String, Object>> list = reviewService.selectReview(param);
		
		return list;
	}
}
