package com.kh.urbantable.food.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.urbantable.food.model.service.FoodService;
import com.kh.urbantable.food.model.vo.Food;
import com.kh.urbantable.food.model.vo.FoodDivision;
import com.kh.urbantable.food.model.vo.FoodSection;

@Controller
@RequestMapping("/food")
@SessionAttributes("memberLoggedIn")
public class FoodController {

	private Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private FoodService foodService;

	@RequestMapping(value = "/selectFoodByDiv.do", method = RequestMethod.GET)
	public String selectFoodByDiv(Model model, FoodDivision foodDivision,
			@RequestParam(value = "marketName", required = false, defaultValue = "mar00012") String marketNo) {

		Map<String, String> param = new HashMap<String, String>();
		param.put("marketNo", marketNo);
		param.put("foodDivisionNo", foodDivision.getFoodDivisionNo());

		List<Food> foodList = foodService.selectFoodByDiv(param);
		List<FoodSection> subSectionList = foodService.selectSubSectionList(foodDivision.getFoodDivisionNo());

		model.addAttribute("firstCat", foodDivision.getFoodDivisionName());
		model.addAttribute("secCatList", subSectionList);
		model.addAttribute("foodList", foodList);

		return "food/foodList";
	}

	@RequestMapping(value = "/selectFoodByUpper.do", method = RequestMethod.GET)
	public String selectFoodByUpper(Model model, FoodSection foodSection) {

		Map<String, String> param = new HashMap<String, String>();
		param.put("foodDivisionNo", foodSection.getFoodDivisionNo());
		param.put("foodSectionUpper", foodSection.getFoodSectionUpper());

		List<Food> foodList = foodService.selectFoodByUpper(param);
		List<FoodSection> subSectionList = foodService.selectFoodSectionNameList(param);

		model.addAttribute("firstCat", foodSection.getFoodSectionUpper());
		model.addAttribute("secCatList", subSectionList);

		model.addAttribute("foodList", foodList);

		return "food/foodList";

	}

	@RequestMapping(value = "/selectFoodBySect.do", method = RequestMethod.GET)
	public String selectFoodBySect(Model model, FoodSection foodSection) {

		Map<String, String> param = new HashMap<String, String>();
		param.put("foodDivisionNo", foodSection.getFoodDivisionNo());
		param.put("foodSectionUpper", foodSection.getFoodSectionUpper());

		List<Food> foodList = foodService.selectFoodBySect(param);
		List<FoodSection> subSectionList = foodService.selectFoodSectionNameList(param);

		model.addAttribute("firstCat", foodSection.getFoodSectionUpper());
		model.addAttribute("secCatList", subSectionList);
		model.addAttribute("foodList", foodList);
		logger.debug("zzzzzzzzzzzzzzz");
		logger.debug(foodList.toString());
		logger.debug(subSectionList.toString());

		return "food/foodList";
	}

//	// 카테고리 검색 실험용 로직 시작!!!
	/*
	 * @RequestMapping(value = "/selectFoodByDivOrSect.do", method =
	 * RequestMethod.GET) public String selectFoodByDivOrSect(Model model,
	 * 
	 * @RequestParam(value = "searchKeyword", required = false) String
	 * searchKeyword,
	 * 
	 * @RequestParam(value = "foodDivisionNo", required = false, defaultValue = " ")
	 * String foodDivisionNo,
	 * 
	 * @RequestParam(value = "marketName", required = false, defaultValue =
	 * "mar00012") String marketNo ) {
	 * 
	 * String catTable = searchKeyword.substring(0, 3); // div or sec Map<String,
	 * String> param = new HashMap<String, String>(); param.put("marketNo",
	 * marketNo); // division 클릭시 if ("DIV".equals(catTable)) {
	 * param.put("foodDivisionNo", searchKeyword); } //최하위로 조회시 else if
	 * ("SEC".equals(catTable)){ param.put("foodSectNo", searchKeyword); }//upper로
	 * 조회시 else { param.put("foodSectionUpper", searchKeyword);
	 * param.put("foodDivisionNo", foodDivisionNo); }
	 * 
	 * List<FoodSection> subSectionList =
	 * foodService.selectFoodSectionNameList(param);
	 * 
	 * model.addAttribute("secCatList", subSectionList);
	 * model.addAttribute("foodList", foodList); logger.debug("zzzzzzzzzzzzzzz");
	 * logger.debug(foodList.toString()); logger.debug(subSectionList.toString());
	 * 
	 * return "food/foodList"; }
	 */
}
