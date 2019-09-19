package com.kh.urbantable.recipe.model.dao;

import java.util.List;

import com.kh.urbantable.recipe.model.vo.Material;
import com.kh.urbantable.recipe.model.vo.Recipe;
import com.kh.urbantable.recipe.model.vo.RecipeVO;

public interface RecipeDAO {

	List<Recipe> selectRecipeList();

	RecipeVO selectOneRecipe(String recipeNo);

	Material selectOneMaterial(String recipeNo);

}
