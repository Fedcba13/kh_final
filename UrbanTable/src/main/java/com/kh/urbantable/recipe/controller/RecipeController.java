package com.kh.urbantable.recipe.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.urbantable.recipe.model.service.RecipeService;
import com.kh.urbantable.recipe.model.vo.Material;
import com.kh.urbantable.recipe.model.vo.Recipe;
import com.kh.urbantable.recipe.model.vo.RecipeSequence;
import com.kh.urbantable.recipe.model.vo.RecipeVO;

@Controller
@RequestMapping("/recipe")
public class RecipeController {
	
	@Autowired
	RecipeService recipeService;
	
	Set<String> set = new HashSet<String>();
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/recipe")
	public String recipe(HttpServletRequest request) {
		
		List<Recipe> list = recipeService.selectRecipeList();
		
		request.setAttribute("list", list);
//		logger.debug("list=" + list);
		return "/recipe/recipe";
	}
	
	@RequestMapping("/recipeView.do")
	public String recipeView(@RequestParam String recipeNo, Model model) {
		
		model.addAttribute("recipe", recipeService.selectOneRecipe(recipeNo));
		model.addAttribute("material", recipeService.selectOneMaterial(recipeNo));
		return "recipe/recipeView";
	}
	
	@RequestMapping("/insert")
	public String recipeInsert() {
		
		return "/recipe/recipeInsert";
	}
	
	@ResponseBody
	@GetMapping("/materialInsert/{section}")
	public Set<String> materialInsert(@PathVariable("section") String section, @RequestParam("materialSet") String materialSet) {
		if(materialSet.equals("")) {
			set = new HashSet<String>();
		}
		set.add(section);
		
		return set;
	}
	
	@RequestMapping("/recipeInsertEnd.do")
	public String recipeInsertEnd(RecipeVO recipeVo, MultipartFile[] recipePic,
								@RequestParam("materialSet") String materialSet, @RequestParam("memberId") String memberId,
								Model model, HttpServletRequest request) {
		logger.debug(materialSet);
		recipeVo.setMemberId(memberId);
		
		int recipe_result = recipeService.insertRecipe(recipeVo);
		
		String msg = "";
		String recipeNo = "";

		if(recipe_result>0) {
			recipeNo = recipeService.selectRecipeNo();
		} else {
			msg = "레시피 등록 실패!";
			model.addAttribute("msg", msg);
			model.addAttribute("loc", "/recipe/recipe");
			return "common/msg";
		}
		
		try {
			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/recipe");
			
			List<RecipeSequence> sequenceList = new ArrayList<RecipeSequence>();
			String originalFileName = "";
			String renamedFileName = "";
			int i = 0;
			
			for(MultipartFile f : recipePic) {
				if(!f.isEmpty()) {
					originalFileName = f.getOriginalFilename();
					String ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
					int rndNum = new Random().nextInt(1000);
					renamedFileName = sdf.format(new Date()) + "_" + rndNum + "." + ext;
					
					try {
						f.transferTo(new File(saveDirectory + "/" + renamedFileName));
					} catch(Exception e) {
						e.printStackTrace();
					}
				}
				
				RecipeSequence recipeSequence = new RecipeSequence();
				recipeSequence.setRecipeNo(recipeNo);
				recipeSequence.setRecipeOrder(recipeVo.getRecipeSequenceList().get(i).getRecipeOrder());
				recipeSequence.setRecipeContent(recipeVo.getRecipeSequenceList().get(i).getRecipeContent());
				recipeSequence.setOriginalRecipePic(originalFileName);
				recipeSequence.setRenamedRecipePic(renamedFileName);
				sequenceList.add(recipeSequence);
				
				i++;
			}
			
			logger.debug(sequenceList.toString());
			
			int sequence_result = recipeService.insertRecipeSequence(sequenceList);
			
			List<Material> materialList = new ArrayList<Material>();
			
			String[] materialArr = materialSet.split(",");
			
			logger.debug(Arrays.toString(materialArr));
			
			for(int j = 0; j<materialArr.length; j++) {
				String foodSectionNo = recipeService.selectFoodSectionNo(materialArr[j]);
				List<String> foodNoList = recipeService.selectFoodNo(foodSectionNo);
				String foodNo = "";
				
				Material material = new Material();
				material.setRecipeNo(recipeNo);
				material.setFoodSectionNo(foodSectionNo);
				for(int k=0; k<foodNoList.size(); k++) {
					foodNo = foodNoList.get(k);
//					foodNo += foodNoList.get(k);
//					if(k != foodNoList.size()-1) {
//						foodNo += ",";
//					}
				}
				material.setFoodNo(foodNo);
				materialList.add(material);
			}
			
			int ingredient_result = recipeService.insertRecipeIngredient(materialList);
			
			if(sequence_result>0 && ingredient_result>0) {
				msg = "레시피 등록 성공!";
			} else {
				msg = "레시피 등록 실패!";
			}
			
			model.addAttribute("msg", msg);
			model.addAttribute("loc", "/recipe/recipe");
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "common/msg";
	}

}
