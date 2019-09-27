package com.kh.urbantable.payment.model.vo;

public class Payment_ {
	
	private String paymentNo;
	private String memberId;
	private String paymentWay;
	private String card;
	private String bank;
	private String account;
	
	public Payment_() {
		
	}

	public Payment_(String paymentNo, String memberId, String paymentWay, String card, String bank, String account) {
		super();
		this.paymentNo = paymentNo;
		this.memberId = memberId;
		this.paymentWay = paymentWay;
		this.card = card;
		this.bank = bank;
		this.account = account;
	}

	public String getPaymentNo() {
		return paymentNo;
	}

	public void setPaymentNo(String paymentNo) {
		this.paymentNo = paymentNo;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getPaymentWay() {
		return paymentWay;
	}

	public void setPaymentWay(String paymentWay) {
		this.paymentWay = paymentWay;
	}

	public String getCard() {
		return card;
	}

	public void setCard(String card) {
		this.card = card;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	@Override
	public String toString() {
		return "Payment [paymentNo=" + paymentNo + ", memberId=" + memberId + ", paymentWay=" + paymentWay + ", card="
				+ card + ", bank=" + bank + ", account=" + account + "]";
	}	
}
