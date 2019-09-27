package com.kh.urbantable.recipe.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.urbantable.recipe.model.dao.RecipeDAO;
import com.kh.urbantable.recipe.model.vo.Material;
import com.kh.urbantable.recipe.model.vo.Recipe;
import com.kh.urbantable.recipe.model.vo.RecipeSequence;
import com.kh.urbantable.recipe.model.vo.RecipeVO;

@Service
public class RecipeServiceImpl implements RecipeService {

	@Autowired
	RecipeDAO recipeDAO;

	@Override
	public List<Recipe> selectRecipeList() {
		return recipeDAO.selectRecipeList();
	}

	@Override
	public RecipeVO selectOneRecipe(String recipeNo) {
		return recipeDAO.selectOneRecipe(recipeNo);
	}

	@Override
	public Material selectOneMaterial(String recipeNo) {
		return recipeDAO.selectOneMaterial(recipeNo);
	}

	@Override
	public int insertRecipe(RecipeVO recipeVo) {
		return recipeDAO.insertRecipe(recipeVo);
	}

	@Override
	public int insertRecipeSequence(List<RecipeSequence> sequenceList) {
		return recipeDAO.insertRecipeSequence(sequenceList);
	}

	@Override
	public int insertRecipeIngredient(List<Material> materialList) {
		return recipeDAO.insertRecipeIngredient(materialList);
	}

	@Override
	public String selectRecipeNo() {
		return recipeDAO.selectRecipeNo();
	}

	@Override
	public String selectFoodSectionNo(String material) {
		return recipeDAO.selectFoodSectionNo(material);
	}

	@Override
	public List<String> selectFoodNo(String foodSectionNo) {
		return recipeDAO.selectFoodNo(foodSectionNo);
	}
}
