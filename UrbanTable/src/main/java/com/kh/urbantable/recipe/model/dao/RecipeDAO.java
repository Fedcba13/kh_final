package com.kh.urbantable.recipe.model.dao;

import java.util.List;

import com.kh.urbantable.recipe.model.vo.Recipe;

public interface RecipeDAO {

	List<Recipe> selectRecipeList();

}
