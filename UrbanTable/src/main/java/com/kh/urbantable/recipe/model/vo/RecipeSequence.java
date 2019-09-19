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
public class RecipeSequence {
	private String recipeSequenceNo;
	private String recipeNo;
	private int recipeOrder;
	private String recipeContent;
	private String recipePic;
}
