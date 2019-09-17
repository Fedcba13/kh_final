package com.kh.urbantable.payment.model.vo;

import java.sql.Date;

public class Pay {
	
	private String payNo;
	private String memberId;
	private Date payDate;
	private int price;
	private int payFlag;
	private int payEnabled;
	private String deliverType;
	private String marketNo;
	
	public Pay() {
		
	}

	public Pay(String payNo, String memberId, Date payDate, int price, int payFlag, int payEnabled, String deliverType,
			String marketNo) {
		this.payNo = payNo;
		this.memberId = memberId;
		this.payDate = payDate;
		this.price = price;
		this.payFlag = payFlag;
		this.payEnabled = payEnabled;
		this.deliverType = deliverType;
		this.marketNo = marketNo;
	}

	public String getPayNo() {
		return payNo;
	}

	public void setPayNo(String payNo) {
		this.payNo = payNo;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public Date getPayDate() {
		return payDate;
	}

	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getPayFlag() {
		return payFlag;
	}

	public void setPayFlag(int payFlag) {
		this.payFlag = payFlag;
	}

	public int getPayEnabled() {
		return payEnabled;
	}

	public void setPayEnabled(int payEnabled) {
		this.payEnabled = payEnabled;
	}

	public String getDeliverType() {
		return deliverType;
	}

	public void setDeliverType(String deliverType) {
		this.deliverType = deliverType;
	}

	public String getMarketNo() {
		return marketNo;
	}

	public void setMarketNo(String marketNo) {
		this.marketNo = marketNo;
	}

	@Override
	public String toString() {
		return "Pay [payNo=" + payNo + ", memberId=" + memberId + ", payDate=" + payDate + ", price=" + price
				+ ", payFlag=" + payFlag + ", payEnabled=" + payEnabled + ", deliverType=" + deliverType + ", marketNo="
				+ marketNo + "]";
	}
}
