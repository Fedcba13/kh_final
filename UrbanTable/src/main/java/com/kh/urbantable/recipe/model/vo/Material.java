package com.kh.urbantable.recipe.model.vo;

import java.sql.Date;

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
public class Material {
	
	private String recipeIngreNo;
	private String recipeNo;
	private String foodSectionNo;
	private String foodNo;
}
