package com.kh.urbantable.foodOrder.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class MarketOrder {

	private String marketOrderNo;
	private String marketNo;
	private Date marketOrderDate;
	private int marketOrderPrice;
	private int marketOrderFlag;
	private int marketOrderEnabled;
	
}
