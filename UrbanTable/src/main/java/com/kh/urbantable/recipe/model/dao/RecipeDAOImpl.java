package com.kh.urbantable.recipe.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.urbantable.food.model.vo.FoodSection;
import com.kh.urbantable.recipe.model.vo.BoardComment;
import com.kh.urbantable.recipe.model.vo.Material;
import com.kh.urbantable.recipe.model.vo.MaterialWithSection;
import com.kh.urbantable.recipe.model.vo.Recipe;
import com.kh.urbantable.recipe.model.vo.RecipeSequence;
import com.kh.urbantable.recipe.model.vo.RecipeVO;

@Repository
public class RecipeDAOImpl implements RecipeDAO {

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public List<Recipe> selectRecipeList() {
		return sqlSession.selectList("recipe.selectRecipeList");
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
}
