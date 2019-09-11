package com.kh.urbantable.cart.model.vo;

public class Cart {
	
	private String memberId;
	private String foodNo;
	private int foodAmount;
	
	public Cart() {
		
	}
	
	public Cart(String memberId, String foodNo, int foodAmount) {
		super();
		this.memberId = memberId;
		this.foodNo = foodNo;
		this.foodAmount = foodAmount;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getFoodNo() {
		return foodNo;
	}

	public void setFoodNo(String foodNo) {
		this.foodNo = foodNo;
	}

	public int getFoodAmount() {
		return foodAmount;
	}

	public void setFoodAmount(int foodAmount) {
		this.foodAmount = foodAmount;
	}

	@Override
	public String toString() {
		return "Cart [memberId=" + memberId + ", foodNo=" + foodNo + ", foodAmount=" + foodAmount + "]";
	}
	

}
