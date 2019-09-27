package com.kh.urbantable.recipe.model.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.urbantable.recipe.model.vo.Material;
import com.kh.urbantable.recipe.model.vo.Recipe;
import com.kh.urbantable.recipe.model.vo.RecipeSequence;
import com.kh.urbantable.recipe.model.vo.RecipeVO;

public interface RecipeService {

	List<Recipe> selectRecipeList();

	RecipeVO selectOneRecipe(String recipeNo);

	Material selectOneMaterial(String recipeNo);

	int insertRecipe(RecipeVO recipeVo);

	int insertRecipeSequence(List<RecipeSequence> sequenceList);

	int insertRecipeIngredient(List<Material> materialList);

	String selectRecipeNo();

	String selectFoodSectionNo(String material);

	List<String> selectFoodNo(String foodSectionNo);

}
