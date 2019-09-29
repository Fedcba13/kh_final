package com.kh.urbantable.food.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class FoodWithStockInMarket extends Food {

	private String marketNo;
	private int stockAmount;
	private String memberId;
	private String marketResident;
	private String marktetTelephone;
	private String marketAddress;
	private int marketEnabled;
	private int flag;
	private String marketName;
	private String marketHoliday;
	private String marketTime;

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

}
