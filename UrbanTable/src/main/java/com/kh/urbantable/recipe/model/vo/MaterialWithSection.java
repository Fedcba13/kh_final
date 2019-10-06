package com.kh.urbantable.recipe.model.vo;

import java.util.List;

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
public class MaterialWithSection {

	private String recipeIngreNo;
	private String recipeNo;
	private String foodSectionNo;
	private String foodNo;
	private String foodDivisionNo;
	private String foodSectionName;
	private String foodSectionUpper;
	private String foodName;
	private String foodCompany;
	private int foodMarketPrice;
	private int foodMemberPrice;
	private int foodEnabled;
	private String foodImg;
	private String foodOriginalFileName;
	private String foodRenamedFileName;
	private String foodDivisionName;
	private String foodUpperNo;
	private String foodUpperName;
}
