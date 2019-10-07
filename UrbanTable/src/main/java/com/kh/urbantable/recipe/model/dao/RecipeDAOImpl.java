package com.kh.urbantable.recipe.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

@Repository
public class RecipeDAOImpl implements RecipeDAO {

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public List<Recipe> selectRecipeList(Paging paging) {
		return sqlSession.selectList("recipe.selectRecipeList", paging);
	}

	@Override
	public RecipeVO selectOneRecipe(String recipeNo) {
		return sqlSession.selectOne("recipe.selectOneRecipe", recipeNo);
	}

	@Override
	public List<MaterialWithSection> selectMaterial(String recipeNo) {
		return sqlSession.selectList("recipe.selectMaterial", recipeNo);
	}

	@Override
	public int insertRecipe(RecipeVO recipeVo) {
		return sqlSession.insert("recipe.insertRecipe", recipeVo);
	}

	@Override
	public int insertRecipeSequence(List<RecipeSequence> sequenceList) {
		return sqlSession.insert("recipe.insertRecipeSequence", sequenceList);
	}

	@Override
	public int insertRecipeIngredient(List<Material> materialList) {
		return sqlSession.insert("recipe.insertRecipeIngredient", materialList);
	}

	@Override
	public String selectRecipeNo() {
		return sqlSession.selectOne("recipe.selectRecipeNo");
	}

	@Override
	public String selectFoodSectionNo(String material) {
		return sqlSession.selectOne("recipe.selectFoodSectionNo", material);
	}

	@Override
	public List<String> selectFoodNo(String foodSectionNo) {
		return sqlSession.selectList("recipe.selectFoodNo", foodSectionNo);
	}

	@Override
	public String selectFoodDivisionNo(String fr) {
		return sqlSession.selectOne("recipe.selectFoodDivisionNo", fr);
	}

	@Override
	public List<FoodSection> selectFoodSectionList(String foodDivisionNo) {
		return sqlSession.selectList("recipe.selectFoodSectionList", foodDivisionNo);
	}

	@Override
	public int readCountUp(String recipeNo) {
		return sqlSession.update("recipe.readCountUp", recipeNo);
	}

	@Override
	public List<BoardComment> selectBoardCommentList(String recipeNo) {
		return sqlSession.selectList("recipe.selectBoardCommentList", recipeNo);
	}

	@Override
	public int boardCommentInsert(BoardComment comment) {
		return sqlSession.insert("recipe.boardCommentInsert", comment);
	}

	@Override
	public int boardCommentUpdate(BoardComment comment) {
		return sqlSession.update("recipe.boardCommentUpdate", comment);
	}

	@Override
	public int boardCommentDelete(String boardCommentNo) {
		return sqlSession.update("recipe.boardCommentDelete", boardCommentNo);
	}

	@Override
	public BoardComment selectOneBoardComment(String boardCommentNo) {
		return sqlSession.selectOne("recipe.selectOneBoardComment", boardCommentNo);
	}

	@Override
	public int boardCommentBlame(Blame blame) {
		return sqlSession.insert("recipe.boardCommentBlame", blame);
	}

	@Override
	public int selectRecipeListCnt() {
		return sqlSession.selectOne("recipe.selectRecipeListCnt");
				
	}

	@Override
	public List<Food> foodSearchList(String searchName) {
		return sqlSession.selectList("recipe.foodSearchList", searchName);
	}

	@Override
	public String searchFoodNo(String searchResult) {
		return sqlSession.selectOne("recipe.searchFoodNo", searchResult);
	}

	@Override
	public int recipeDelete(String recipeNo) {
		return sqlSession.update("recipe.recipeDelete", recipeNo);
	}

	@Override
	public String selectLastImage(String recipeNo) {
		return sqlSession.selectOne("recipe.selectLastImage", recipeNo);
	}
}
