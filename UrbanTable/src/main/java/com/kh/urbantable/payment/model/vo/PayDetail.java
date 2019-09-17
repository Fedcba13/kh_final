package com.kh.urbantable.payment.model.vo;

public class PayDetail {
	
	private String payDetailNo;
	private String payNo;
	private String foodNo;
	private int payDetailAmount;
	
	public PayDetail() {
		
	}

	public PayDetail(String payDetailNo, String payNo, String foodNo, int payDetailAmount) {
		super();
		this.payDetailNo = payDetailNo;
		this.payNo = payNo;
		this.foodNo = foodNo;
		this.payDetailAmount = payDetailAmount;
	}

	public String getPayDetailNo() {
		return payDetailNo;
	}

	public void setPayDetailNo(String payDetailNo) {
		this.payDetailNo = payDetailNo;
	}

	public String getPayNo() {
		return payNo;
	}

	public void setPayNo(String payNo) {
		this.payNo = payNo;
	}

	public String getFoodNo() {
		return foodNo;
	}

	public void setFoodNo(String foodNo) {
		this.foodNo = foodNo;
	}

	public int getPayDetailAmount() {
		return payDetailAmount;
	}

	public void setPayDetailAmount(int payDetailAmount) {
		this.payDetailAmount = payDetailAmount;
	}

	@Override
	public String toString() {
		return "PayDetail [payDetailNo=" + payDetailNo + ", payNo=" + payNo + ", foodNo=" + foodNo
				+ ", payDetailAmount=" + payDetailAmount + "]";
	}	
}
