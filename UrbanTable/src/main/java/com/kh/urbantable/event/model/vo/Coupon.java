package com.kh.urbantable.event.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class Coupon {
	
	private String couponId;
	private String memberId;
	private String couponDiscount;
	private Date couponStartDate;
	private Date couponEndDate;
	private int couponEnabled;
	private int couponMinPrice;
	
	
}
