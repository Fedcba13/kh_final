package com.kh.urbantable.payment.model.vo;

public class Payment_ {
	
	private String paymentNo;
	private String memberId;
	private String paymentWay;
	private String card;
	private String bank;
	private String account;
	private String payNo;
	
	public Payment_() {
		
	}

	public Payment_(String paymentNo, String memberId, String paymentWay, String card, String bank, String account,
			String payNo) {
		super();
		this.paymentNo = paymentNo;
		this.memberId = memberId;
		this.paymentWay = paymentWay;
		this.card = card;
		this.bank = bank;
		this.account = account;
		this.payNo = payNo;
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

	public String getPayNo() {
		return payNo;
	}

	public void setPayNo(String payNo) {
		this.payNo = payNo;
	}

	@Override
	public String toString() {
		return "Payment_ [paymentNo=" + paymentNo + ", memberId=" + memberId + ", paymentWay=" + paymentWay + ", card="
				+ card + ", bank=" + bank + ", account=" + account + ", payNo=" + payNo + "]";
	}

	
}
