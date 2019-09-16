package com.kh.urbantable.recipe.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.recipe.model.dao.RecipeDAO;
import com.kh.urbantable.recipe.model.vo.Recipe;

@Service
public class RecipeServiceImpl implements RecipeService {

	@Autowired
	RecipeDAO recipeDAO;

	@Override
	public List<Recipe> selectRecipeList() {
		return recipeDAO.selectRecipeList();
	}
}
