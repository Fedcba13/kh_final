package com.kh.urbantable.common.scheduler;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service
public class Scheduler {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Scheduled(cron="0 * * * * ?")
	public void curTime() {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		logger.debug(sdf.format(date));
	}
 
}
