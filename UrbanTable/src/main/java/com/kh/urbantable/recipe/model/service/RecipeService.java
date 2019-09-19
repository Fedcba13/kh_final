package com.kh.urbantable.recipe.model.service;

import java.util.List;

import com.kh.urbantable.recipe.model.vo.Material;
import com.kh.urbantable.recipe.model.vo.Recipe;
import com.kh.urbantable.recipe.model.vo.RecipeVO;

public interface RecipeService {

	List<Recipe> selectRecipeList();

	RecipeVO selectOneRecipe(String recipeNo);

	Material selectOneMaterial(String recipeNo);

}
