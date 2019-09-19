package com.kh.urbantable.cart.model.vo;

public class Cart {
	
	private String memberId;
	private String foodNo;
	private int cartAmount;
	
	public Cart() {
		
	}
	
	public Cart(String memberId, String foodNo, int cartAmount) {
		super();
		this.memberId = memberId;
		this.foodNo = foodNo;
		this.cartAmount = cartAmount;
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

	public int getCartAmount() {
		return cartAmount;
	}

	public void setCartAmount(int cartAmount) {
		this.cartAmount = cartAmount;
	}

	@Override
	public String toString() {
		return "Cart [memberId=" + memberId + ", foodNo=" + foodNo + ", cartAmount=" + cartAmount + "]";
	}
	

}