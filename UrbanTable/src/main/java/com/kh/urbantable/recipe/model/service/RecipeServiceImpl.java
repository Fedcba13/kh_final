package com.kh.urbantable.recipe.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.food.model.vo.Food;
import com.kh.urbantable.food.model.vo.FoodSection;
import com.kh.urbantable.recipe.model.dao.RecipeDAO;
import com.kh.urbantable.recipe.model.vo.Blame;
import com.kh.urbantable.recipe.model.vo.BoardComment;
import com.kh.urbantable.recipe.model.vo.Material;
import com.kh.urbantable.recipe.model.vo.MaterialWithSection;
import com.kh.urbantable.recipe.model.vo.Paging;
import com.kh.urbantable.recipe.model.vo.Recipe;
import com.kh.urbantable.recipe.model.vo.RecipeSequence;
import com.kh.urbantable.recipe.model.vo.RecipeVO;

@Service
public class RecipeServiceImpl implements RecipeService {

	@Autowired
	RecipeDAO recipeDAO;

	@Override
	public List<Recipe> selectRecipeList(Paging paging) {
		return recipeDAO.selectRecipeList(paging);
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

	@Override
	public int boardCommentInsert(BoardComment comment) {
		return recipeDAO.boardCommentInsert(comment);
	}

	@Override
	public int boardCommentUpdate(BoardComment comment) {
		return recipeDAO.boardCommentUpdate(comment);
	}

	@Override
	public int boardCommentDelete(String boardCommentNo) {
		return recipeDAO.boardCommentDelete(boardCommentNo);
	}

	@Override
	public BoardComment selectOneBoardComment(String boardCommentNo) {
		return recipeDAO.selectOneBoardComment(boardCommentNo);
	}

	@Override
	public int boardCommentBlame(Blame blame) {
		return recipeDAO.boardCommentBlame(blame);
	}

	@Override
	public int selectRecipeListCnt() {
		return recipeDAO.selectRecipeListCnt();
	}

	@Override
	public List<Food> foodSearchList(String searchName) {
		return recipeDAO.foodSearchList(searchName);
	}

	@Override
	public String searchFoodNo(String searchResult) {
		return recipeDAO.searchFoodNo(searchResult);
	}

	@Override
	public int recipeDelete(String recipeNo) {
		return recipeDAO.recipeDelete(recipeNo);
	}
}
