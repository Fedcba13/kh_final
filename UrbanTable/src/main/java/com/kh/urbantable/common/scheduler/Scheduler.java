package com.kh.urbantable.common.scheduler;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.urbantable.common.util.Utils;
import com.kh.urbantable.member.model.service.MemberService;
import com.kh.urbantable.message.vo.Message;

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
		
		List<HashMap<String, Object>> list = memberService.selectSendMsg();
		
		for(int i=0; i<list.size(); i++) {
			Message message = new Message(list.get(i).get("MEMBER_PHONE").toString(),
					"01040418769", "[" + list.get(i).get("FOOD_SECTION_NAME") + "]"
							+ " UrbanTable 신청하신 재고가 입고되었습니다.");
			Utils.sendMessage(message);
			
			HashMap<String, Object> param = new HashMap<String, Object>();
			param.put("memberId", list.get(i).get("MEMBER_ID"));
			param.put("foodNo", list.get(i).get("FOOD_NO"));
			param.put("foodNo", list.get(i).get("MARKET_NO"));
			
			memberService.deleteSendMsg(param);
			
		}
		
	}
 
}
