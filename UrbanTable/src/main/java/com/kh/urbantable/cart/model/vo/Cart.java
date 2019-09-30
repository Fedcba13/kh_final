package com.kh.urbantable.cart.model.vo;

public class Cart {
	
	private String memberId;
	private String foodNo;
	private int cartAmount;
	private int flag;
	
	public Cart() {
		
	}
	
	public Cart(String memberId, String foodNo, int cartAmount, int flag) {
		super();
		this.memberId = memberId;
		this.foodNo = foodNo;
		this.cartAmount = cartAmount;
		this.flag=flag;
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

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	@Override
	public String toString() {
		return "Cart [memberId=" + memberId + ", foodNo=" + foodNo + ", cartAmount=" + cartAmount + ", flag=" + flag
				+ "]";
	}

}
