package com.kh.urbantable.recipe.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.urbantable.recipe.model.vo.Material;
import com.kh.urbantable.recipe.model.vo.Recipe;
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
	public Material selectOneMaterial(String recipeNo) {
		return sqlSession.selectOne("recipe.selectOneMaterial", recipeNo);
	}
}
