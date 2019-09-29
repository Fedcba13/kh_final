package com.kh.urbantable.food.model.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class FoodWithFoodSection extends Food {

	private List<FoodSection> foodSectionList;

	@Override
	public String toString() {
		return "FoodWithFoodSection [foodSectionList=" + foodSectionList + ", getFoodNo()=" + getFoodNo()
				+ ", getFoodName()=" + getFoodName() + ", getFoodSectionNo()=" + getFoodSectionNo()
				+ ", getFoodCompany()=" + getFoodCompany() + ", getFoodMarketPrice()=" + getFoodMarketPrice()
				+ ", getFoodMemberPrice()=" + getFoodMemberPrice() + ", getFoodEnabled()=" + getFoodEnabled()
				+ ", getFoodImg()=" + getFoodImg() + ", toString()=" + super.toString() + ", getClass()=" + getClass()
				+ ", hashCode()=" + hashCode() + "]";
	}
	
}
