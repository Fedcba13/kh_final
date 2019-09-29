package com.kh.urbantable.foodOrder.model.vo;

import lombok.Data;

@Data
public class MarketOrderDetail {

	private String marketOrderDetailNo;
	private String marketOrderNo;
	private String foodNo;
	private int marketOrderDetailAmount;
	private int marketOrderDetailFlag;
	private String foodCompany;
	
}
