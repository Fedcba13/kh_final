package com.kh.urbantable.review.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.urbantable.review.model.service.ReviewService;

@Controller
public class ReviewController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	ReviewService reviewService;
	
	@ResponseBody
	@RequestMapping("/member/writeReview")
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
	
	

}
