package com.kh.urbantable.food.model.vo;

public class FoodWithStockAndEvent extends Food {

	private String marketNo;
	private int stockAmount;
	private String memberId;
	private String marketResident;
	private String marketAddress;
	private int marketEnabled;
	private int flag;
	private String marketName;
	private String marketHoliday;
	private String marketTime;
	private int eventPercent;
	private int good;
	private int bad;
	
	private String marketTelephone;
	

	public void setMarketTelephone(String marketTelephone) {
		this.marketTelephone = marketTelephone;
	}
	public String getMarketTelephone() {
		return marketTelephone;
	}

	@Override
	public String getFoodCompany() {
		// TODO Auto-generated method stub
		return super.getFoodCompany();
	}

	@Override
	public int getFoodEnabled() {
		// TODO Auto-generated method stub
		return super.getFoodEnabled();
	}

	@Override
	public String getFoodImg() {
		// TODO Auto-generated method stub
		return super.getFoodImg();
	}

	@Override
	public int getFoodMarketPrice() {
		// TODO Auto-generated method stub
		return super.getFoodMarketPrice();
	}

	@Override
	public int getFoodMemberPrice() {
		// TODO Auto-generated method stub
		return super.getFoodMemberPrice();
	}

	@Override
	public String getFoodName() {
		// TODO Auto-generated method stub
		return super.getFoodName();
	}

	@Override
	public String getFoodNo() {
		// TODO Auto-generated method stub
		return super.getFoodNo();
	}

	@Override
	public String getFoodSectionNo() {
		
		// TODO Auto-generated method stub
		return super.getFoodSectionNo();
	}

	@Override
	public void setFoodCompany(String foodCompany) {
		// TODO Auto-generated method stub
		super.setFoodCompany(foodCompany);
	}

	@Override
	public void setFoodEnabled(int foodEnabled) {
		// TODO Auto-generated method stub
		super.setFoodEnabled(foodEnabled);
	}

	@Override
	public void setFoodImg(String foodImg) {
		// TODO Auto-generated method stub
		super.setFoodImg(foodImg);
	}

	@Override
	public void setFoodMarketPrice(int foodMarketPrice) {
		// TODO Auto-generated method stub
		super.setFoodMarketPrice(foodMarketPrice);
	}

	@Override
	public void setFoodMemberPrice(int foodMemberPrice) {
		// TODO Auto-generated method stub
		super.setFoodMemberPrice(foodMemberPrice);
	}

	@Override
	public void setFoodName(String foodName) {
		// TODO Auto-generated method stub
		super.setFoodName(foodName);
	}

	@Override
	public void setFoodNo(String foodNo) {
		// TODO Auto-generated method stub
		super.setFoodNo(foodNo);
	}

	@Override
	public void setFoodSectionNo(String foodSectionNo) {
		// TODO Auto-generated method stub
		super.setFoodSectionNo(foodSectionNo);
	}

	public String getMarketNo() {
		return marketNo;
	}

	public void setMarketNo(String marketNo) {
		this.marketNo = marketNo;
	}

	public int getStockAmount() {
		return stockAmount;
	}

	public void setStockAmount(int stockAmount) {
		this.stockAmount = stockAmount;
	}

	public int getGood() {
		return good;
	}
	public void setGood(int good) {
		this.good = good;
	}
	public int getBad() {
		return bad;
	}
	public void setBad(int bad) {
		this.bad = bad;
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

	public String getMarketAddress() {
		return marketAddress;
	}

	public void setMarketAddress(String marketAddress) {
		this.marketAddress = marketAddress;
	}

	public int getMarketEnabled() {
		return marketEnabled;
	}

	public void setMarketEnabled(int marketEnabled) {
		this.marketEnabled = marketEnabled;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public String getMarketName() {
		return marketName;
	}

	public void setMarketName(String marketName) {
		this.marketName = marketName;
	}

	public String getMarketHoliday() {
		return marketHoliday;
	}

	public void setMarketHoliday(String marketHoliday) {
		this.marketHoliday = marketHoliday;
	}

	public String getMarketTime() {
		return marketTime;
	}

	public void setMarketTime(String marketTime) {
		this.marketTime = marketTime;
	}


	public int getEventPercent() {
		return eventPercent;
	}

	public void setEventPercent(int eventPercent) {
		this.eventPercent = eventPercent;
	}

	

	
	@Override
	public String toString() {
		return "FoodWithStockAndEvent [marketNo=" + marketNo + ", stockAmount=" + stockAmount + ", memberId=" + memberId
				+ ", marketResident=" + marketResident + ", marketAddress=" + marketAddress + ", marketEnabled="
				+ marketEnabled + ", flag=" + flag + ", marketName=" + marketName + ", marketHoliday=" + marketHoliday
				+ ", marketTime=" + marketTime + ", eventPercent="
				+ eventPercent + ", good=" + good + ", bad=" + bad + ", marketTelephone=" + marketTelephone
				+ ", toString()=" + super.toString() + "]";
	}
	public FoodWithStockAndEvent(String marketNo, int stockAmount, String memberId, String marketResident,
			String marketAddress, int marketEnabled, int flag, String marketName, String marketHoliday,
			String marketTime, int eventPercent, int good, int bad, String marketTelephone) {
		super();
		this.marketNo = marketNo;
		this.stockAmount = stockAmount;
		this.memberId = memberId;
		this.marketResident = marketResident;
		this.marketAddress = marketAddress;
		this.marketEnabled = marketEnabled;
		this.flag = flag;
		this.marketName = marketName;
		this.marketHoliday = marketHoliday;
		this.marketTime = marketTime;
		this.eventPercent = eventPercent;
		this.good = good;
		this.bad = bad;
		this.marketTelephone = marketTelephone;
	}
	public FoodWithStockAndEvent() {
		super();
		// TODO Auto-generated constructor stub
	}


	
	

}
