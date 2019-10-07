package com.kh.urbantable.recipe.model.dao;

import java.util.List;

import com.kh.urbantable.food.model.vo.Food;
import com.kh.urbantable.food.model.vo.FoodSection;
import com.kh.urbantable.recipe.model.vo.Blame;
import com.kh.urbantable.recipe.model.vo.BoardComment;
import com.kh.urbantable.recipe.model.vo.Material;
import com.kh.urbantable.recipe.model.vo.MaterialWithSection;
import com.kh.urbantable.recipe.model.vo.Paging;
import com.kh.urbantable.recipe.model.vo.Recipe;
import com.kh.urbantable.recipe.model.vo.RecipeSequence;
import com.kh.urbantable.recipe.model.vo.RecipeVO;

public interface RecipeDAO {

	List<Recipe> selectRecipeList(Paging paging);

	RecipeVO selectOneRecipe(String recipeNo);

	List<MaterialWithSection> selectMaterial(String recipeNo);

	int insertRecipe(RecipeVO recipeVo);

	int insertRecipeSequence(List<RecipeSequence> sequenceList);

	int insertRecipeIngredient(List<Material> materialList);

	String selectRecipeNo();

	String selectFoodSectionNo(String material);

	List<String> selectFoodNo(String foodSectionNo);

	String selectFoodDivisionNo(String fr);

	List<FoodSection> selectFoodSectionList(String foodDivisionNo);

	int readCountUp(String recipeNo);

	List<BoardComment> selectBoardCommentList(String recipeNo);

	int boardCommentInsert(BoardComment comment);

	int boardCommentUpdate(BoardComment comment);

	int boardCommentDelete(String boardCommentNo);

	BoardComment selectOneBoardComment(String boardCommentNo);

	int boardCommentBlame(Blame blame);

	int selectRecipeListCnt();

	List<Food> foodSearchList(String searchName);

	String searchFoodNo(String searchResult);

	int recipeDelete(String recipeNo);

	String selectLastImage(String recipeNo);

}
