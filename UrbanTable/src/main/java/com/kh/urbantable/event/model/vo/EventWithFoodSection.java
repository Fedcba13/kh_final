package com.kh.urbantable.event.model.vo;

import com.kh.urbantable.food.model.vo.FoodSection;
import com.kh.urbantable.marketOwner.model.vo.Market;

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
public class EventWithFoodSection extends Event{

	private FoodSection foodSection;
	private Market market;
	
	
}
