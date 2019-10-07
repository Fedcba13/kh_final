package com.kh.urbantable.common.scheduler;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.urbantable.member.model.service.MemberService;

@Service
public class Scheduler {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	MemberService memberService;
	
	//9-18시 정각마다 알림
	@Scheduled(cron="0 0 09-18 * * ?")
	public void curTime() {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		logger.debug(sdf.format(date));
	}
 
}
