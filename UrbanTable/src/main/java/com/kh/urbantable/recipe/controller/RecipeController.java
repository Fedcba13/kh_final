package com.kh.urbantable.recipe.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.urbantable.recipe.model.service.RecipeService;
import com.kh.urbantable.recipe.model.vo.Recipe;
import com.kh.urbantable.recipe.model.vo.RecipeVO;

@Controller
@RequestMapping("/recipe")
public class RecipeController {
	
	@Autowired
	RecipeService recipeService;
	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/recipe")
	public String recipe(HttpServletRequest request) {
		logger.debug("/recipe/recipe");
		
		List<Recipe> list = recipeService.selectRecipeList();
		
		request.setAttribute("list", list);
//		logger.debug("list=" + list);
		return "/recipe/recipe";
	}
	
	@RequestMapping("/recipeView.do")
	public String recipeView(@RequestParam String recipeNo, Model model) {
		logger.debug("recipe/recipeView.do");
		
		model.addAttribute("recipe", recipeService.selectOneRecipe(recipeNo));
		model.addAttribute("material", recipeService.selectOneMaterial(recipeNo));
		return "recipe/recipeView";
	}
	
	@RequestMapping("/insert")
	public String recipeInsert() {
		logger.debug("recip/insert");
		
		return "/recipe/recipeInsert";
	}

}
