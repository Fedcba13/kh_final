package com.kh.urbantable.member.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberAutoLogin {
	
	private String cookieKey;
	private String memberId;
	private Date lastDate;

}
