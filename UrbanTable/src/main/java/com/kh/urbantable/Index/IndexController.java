package com.kh.urbantable.Index;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/")
	public String index() {
		logger.debug("index");
		return "index";
	}
	

}
