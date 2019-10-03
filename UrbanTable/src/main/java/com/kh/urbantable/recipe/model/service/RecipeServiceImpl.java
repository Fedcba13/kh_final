package com.kh.urbantable.recipe.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.food.model.vo.FoodSection;
import com.kh.urbantable.recipe.model.dao.RecipeDAO;
import com.kh.urbantable.recipe.model.vo.BoardComment;
import com.kh.urbantable.recipe.model.vo.Material;
import com.kh.urbantable.recipe.model.vo.MaterialWithSection;
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
	public List<MaterialWithSection> selectMaterial(String recipeNo) {
		return recipeDAO.selectMaterial(recipeNo);
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

	@Override
	public String selectFoodDivisionNo(String fr) {
		return recipeDAO.selectFoodDivisionNo(fr);
	}

	@Override
	public List<FoodSection> selectFoodSectionList(String foodDivisionNo) {
		return recipeDAO.selectFoodSectionList(foodDivisionNo);
	}

	@Override
	public int readCountUp(String recipeNo) {
		return recipeDAO.readCountUp(recipeNo);
	}

	@Override
	public List<BoardComment> selectBoardCommentList(String recipeNo) {
		return recipeDAO.selectBoardCommentList(recipeNo);
	}
}
