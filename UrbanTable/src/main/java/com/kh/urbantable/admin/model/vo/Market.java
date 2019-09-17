package com.kh.urbantable.admin.model.vo;

public class Market {

	private String marketNo;
	private String memberId;
	private String marketResident;
	private String merketTelephone;
	private String marketAddress;
	private String marketAddress2;
	private int market_enabled;
	private int flag;

	public Market() {
		// TODO Auto-generated constructor stub
	}

	public Market(String marketNo, String memberId, String marketResident, String merketTelephone, String marketAddress,
			String marketAddress2, int market_enabled, int flag) {
		super();
		this.marketNo = marketNo;
		this.memberId = memberId;
		this.marketResident = marketResident;
		this.merketTelephone = merketTelephone;
		this.marketAddress = marketAddress;
		this.marketAddress2 = marketAddress2;
		this.market_enabled = market_enabled;
		this.flag = flag;
	}

	public String getMarketNo() {
		return marketNo;
	}

	public void setMarketNo(String marketNo) {
		this.marketNo = marketNo;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getMarketResident() {
		return marketResident;
	}

	public void setMarketResident(String marketResident) {
		this.marketResident = marketResident;
	}

	public String getMerketTelephone() {
		return merketTelephone;
	}

	public void setMerketTelephone(String merketTelephone) {
		this.merketTelephone = merketTelephone;
	}

	public String getMarketAddress() {
		return marketAddress;
	}

	public void setMarketAddress(String marketAddress) {
		this.marketAddress = marketAddress;
	}

	public String getMarketAddress2() {
		return marketAddress2;
	}

	public void setMarketAddress2(String marketAddress2) {
		this.marketAddress2 = marketAddress2;
	}

	public int getMarket_enabled() {
		return market_enabled;
	}

	public void setMarket_enabled(int market_enabled) {
		this.market_enabled = market_enabled;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	@Override
	public String toString() {
		return "Market [marketNo=" + marketNo + ", memberId=" + memberId + ", marketResident=" + marketResident
				+ ", merketTelephone=" + merketTelephone + ", marketAddress=" + marketAddress + ", marketAddress2="
				+ marketAddress2 + ", market_enabled=" + market_enabled + ", flag=" + flag + "]";
	}

}
