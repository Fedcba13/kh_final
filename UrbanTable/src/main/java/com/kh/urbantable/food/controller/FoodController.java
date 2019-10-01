package com.kh.urbantable.food.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.urbantable.food.model.service.FoodService;
import com.kh.urbantable.food.model.vo.Food;
import com.kh.urbantable.food.model.vo.FoodSection;
import com.kh.urbantable.food.model.vo.FoodUpper;
import com.kh.urbantable.marketOwner.model.vo.Market;

@Controller
@RequestMapping("/food")
@SessionAttributes("memberLoggedIn")
public class FoodController {

	private Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private FoodService foodService;

	@RequestMapping(value = "/selectFoodByCat.do", method = RequestMethod.GET)
	public String selectFoodByCat(Model model, @RequestParam(value = "searchNo") String searchNo,
			@RequestParam(value = "searchKeyword") String searchKeyword,
			@RequestParam(value = "marketName", required = false, defaultValue = "mar00012") String marketNo) {

		Map<String, String> param = new HashMap<String, String>();
		param.put("searchNo", searchNo);
		param.put("marketNo", marketNo);

		String whichCat = searchNo.substring(0, 3);

		List<FoodUpper> subUpperList = null;
		List<FoodSection> subSectList = null;
		List<FoodSection> brotherSectList = null;

		if ("DIV".equals(whichCat)) {
			param.put("table", "DIVISION");
			param.put("FOOD_DIVISION_NO", searchNo);
			subUpperList = foodService.getSubUpperList(searchNo);
		} else if ("UPP".equals(whichCat)) {
			param.put("FOOD_UPPER_NO", searchNo);
			subSectList = foodService.getSubSectList(searchNo);
		} else if ("SEC".equals(whichCat)) {
			param.put("FOOD_SECTION_NO", searchNo);
			String upperNo = foodService.getUpperNoBySectNo(searchNo);
			brotherSectList = foodService.selectBrotherSectList(upperNo);
		}

		List<Food> foodList = foodService.selectFoodListByCat(param);
		List<Market> marketList = foodService.selectMarketList();

		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("subUpperList", subUpperList);
		model.addAttribute("subSectList", subSectList);
		model.addAttribute("brotherSectList", brotherSectList);
		model.addAttribute("marketList", marketList);
		model.addAttribute("foodList", foodList);

		return "food/foodList";
	}

//
}
