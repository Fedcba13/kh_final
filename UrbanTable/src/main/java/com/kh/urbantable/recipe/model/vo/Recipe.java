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
public class Recipe {

	private String recipeNo;
	private String memberId;
	private String recipeTitle;
	private int recipeReadcount;
	private Date recipeDate;
	private int recipeEnabled;
}
