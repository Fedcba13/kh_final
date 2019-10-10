package com.kh.urbantable.recipe.model.service;

import java.util.List;

import com.kh.urbantable.admin.model.vo.Good;
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

public interface RecipeService {

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

	List<Recipe> selectRecipeIndexList();

	int materialOldDelete(String materialNo);

	String selectMaterialNo(String materialName);

	int updateRecipe(RecipeVO recipeVo);

	int updateRecipeSequence(List<RecipeSequence> updateSequenceList);

	int deleteRecipeSequence(RecipeSequence deleteSequence);

	String selectRenamedFileName(RecipeSequence rs);

	String selectGood(Recipe r);

	String selectBad(Recipe r);

	int insertGood(Good good);

	int insertBad(Good good);

	Good selectOneGood(Good good);

	int updateGood(Good good);

	int updateBad(Good good);

	int goodCount(String recipeNo);

	int badCount(String recipeNo);

	List<Recipe> selectRecipeSearchList(String searchName);

}
