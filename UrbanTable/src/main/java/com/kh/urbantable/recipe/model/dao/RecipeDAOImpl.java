package com.kh.urbantable.recipe.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

	@Override
	public List<Recipe> selectRecipeIndexList() {
		return sqlSession.selectList("recipe.selectRecipeIndexList");
	}

	@Override
	public int MaterialOldDelete(Material deleteM) {
		return sqlSession.delete("recipe.materialOldDelete", deleteM);
	}

	@Override
	public String selectMaterialNo(String materialName) {
		return sqlSession.selectOne("recipe.selectMaterialNo", materialName);
	}

	@Override
	public int updateRecipe(RecipeVO recipeVo) {
		return sqlSession.update("recipe.updateRecipe", recipeVo);
	}

	@Override
	public int updateRecipeSequence(List<RecipeSequence> updateSequenceList) {
		return sqlSession.update("recipe.updateRecipeSequence", updateSequenceList);
	}

	@Override
	public int deleteRecipeSequence(RecipeSequence deleteSequence) {
		return sqlSession.delete("recipe.deleteRecipeSequence", deleteSequence);
	}

	@Override
	public String selectRenamedFileName(RecipeSequence rs) {
		return sqlSession.selectOne("recipe.selectRenamedFileName", rs);
	}

	@Override
	public String selectGood(Recipe r) {
		return sqlSession.selectOne("recipe.selectGood", r);
	}

	@Override
	public String selectBad(Recipe r) {
		return sqlSession.selectOne("recipe.selectBad", r);
	}

	@Override
	public int insertGood(Good good) {
		return sqlSession.insert("recipe.insertGood", good);
	}

	@Override
	public int insertBad(Good good) {
		return sqlSession.insert("recipe.insertBad", good);
	}

	@Override
	public Good selectOneGood(Good good) {
		return sqlSession.selectOne("recipe.selectOneGood", good);
	}

	@Override
	public int updateGood(Good good) {
		return sqlSession.update("recipe.updateGood", good);
	}

	@Override
	public int updateBad(Good good) {
		return sqlSession.update("recipe.updateBad", good);
	}

	@Override
	public int goodCount(String recipeNo) {
		return sqlSession.selectOne("recipe.goodCount", recipeNo);
	}

	@Override
	public int badCount(String recipeNo) {
		return sqlSession.selectOne("recipe.badCount", recipeNo);
	}

	@Override
	public List<Recipe> selectRecipeSearchList(String searchName) {
		return sqlSession.selectList("recipe.selectRecipeSearchList", searchName);
	}
}
