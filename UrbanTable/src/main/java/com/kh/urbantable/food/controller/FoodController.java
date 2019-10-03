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
import com.kh.urbantable.food.model.vo.FoodSection;
import com.kh.urbantable.food.model.vo.FoodUpper;
import com.kh.urbantable.food.model.vo.FoodWithStockAndEvent;
import com.kh.urbantable.marketOwner.model.vo.Market;

@Controller
@RequestMapping("/food")
@SessionAttributes("memberLoggedIn")
public class FoodController {

	private Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	private FoodService foodService;


	public FoodWithStockAndEvent calculateEventPrice(FoodWithStockAndEvent food) {
		int eventPercent = foodService.selectEventPercent(food);
		
		 	double M3=eventPercent*0.01; // M3는 %를 소수점으로 변환한 값이다 즉 20%를 0.2로 변환한다
		    double yourmoney=food.getFoodMemberPrice()*M3; // 할인되는 가격
		    double actually=food.getFoodMemberPrice()-yourmoney; // 실제 가격

		if(eventPercent != 0) {
			food.setAfterEventPrice((int)actually);
			food.setEventPercent(eventPercent);
		}
		return food;
	}
	@RequestMapping(value = "/selectFoodByCat.do", method = RequestMethod.GET)
	public String selectFoodByCat(Model model, @RequestParam(value = "searchNo") String searchNo,
			@RequestParam(value = "searchKeyword") String searchKeyword,
			@RequestParam(value = "marketNo", required = false, defaultValue = "mar00012") String marketNo) {

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

		List<FoodWithStockAndEvent> foodList = foodService.selectFoodListByCat(param);
		List<Market> marketList = foodService.selectMarketList();
		
		for(FoodWithStockAndEvent food : foodList) {
			food = calculateEventPrice(food);
		}
		
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("searchNo", searchNo);
		model.addAttribute("marketNo", marketNo);
		model.addAttribute("subUpperList", subUpperList);
		model.addAttribute("subSectList", subSectList);
		model.addAttribute("brotherSectList", brotherSectList);
		model.addAttribute("marketList", marketList);
		model.addAttribute("foodList", foodList);

		return "food/foodList";
	}
	
	@RequestMapping(value = "/goFoodView.do", method = RequestMethod.GET)
	public String goFoodView(Model model, @RequestParam(value = "foodNo") String foodNo,
								@RequestParam(value = "marketNo") String marketNo) {
		
		
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("foodNo", foodNo);
		param.put("marketNo", marketNo);
		
		FoodWithStockAndEvent food = foodService.selectFood(param);

		food = calculateEventPrice(food);
		model.addAttribute("food", food);
		
		return "food/foodView";
	}
	@RequestMapping(value = "/admin/goInsertFoodView.do", method = RequestMethod.GET)
	public String goInsertFoodView(Model model) {
		
		//소분류리스트 가져오기
//		List<FoodSection> foodSectionList = foodService.getFoodSectionList();
//		model.addAttribute("sectionList", foodSectionList);
		
		return "food/insertFood";
	}
	@RequestMapping(value = "/admin/getUpperListToInsertFood.do", method = RequestMethod.POST)
	public List<FoodUpper> getUpperListToInsertFood(String foodDivisionNo) {
		
//		List<FoodUpper> foodUpeprList = foodService.getUpperListToInsertFood();
		
		return null; 
	}
	
	
}
