package com.kh.urbantable.food.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.kh.urbantable.admin.model.vo.Banner;
import com.kh.urbantable.common.util.FileRenameUtils;
import com.kh.urbantable.food.model.service.FoodService;
import com.kh.urbantable.food.model.vo.Food;
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

		double M3 = eventPercent * 0.01; // M3는 %를 소수점으로 변환한 값이다 즉 20%를 0.2로 변환한다
		double yourmoney = food.getFoodMemberPrice() * M3; // 할인되는 가격
		double actually = food.getFoodMemberPrice() - yourmoney; // 실제 가격

		if (eventPercent != 0) {
			food.setAfterEventPrice((int) actually);
			food.setEventPercent(eventPercent);
		}
		return food;
	}

	@RequestMapping(value = "/selectFoodInMain1.do")
	@ResponseBody
	public List<FoodWithStockAndEvent> selectFoodInMain1() {

		List<FoodWithStockAndEvent> foodList = foodService.selectFoodInMain1();
		for (FoodWithStockAndEvent food : foodList) {
			food = calculateEventPrice(food);
		}

		return foodList;
	}

	@RequestMapping(value = "/selectFoodInMain2.do")
	@ResponseBody
	public List<FoodWithStockAndEvent> selectFoodInMain2() {

		List<FoodWithStockAndEvent> foodList = foodService.selectFoodInMain2();
		for (FoodWithStockAndEvent food : foodList) {
			food = calculateEventPrice(food);
		}

		return foodList;
	}

	@RequestMapping(value = "/selectFoodInMain3.do")
	@ResponseBody
	public List<FoodWithStockAndEvent> selectFoodInMain3(@RequestParam String foodDivisionNo) {

		List<FoodWithStockAndEvent> foodList = foodService.selectFoodInMain3(foodDivisionNo);
		for (FoodWithStockAndEvent food : foodList) {
			food = calculateEventPrice(food);
		}

		return foodList;
	}

	@RequestMapping(value = "/selectFoodInMain4.do")
	@ResponseBody
	public List<FoodWithStockAndEvent> selectFoodInMain4() {

		List<FoodWithStockAndEvent> foodList = foodService.selectFoodInMain4();
		for (FoodWithStockAndEvent food : foodList) {
			food = calculateEventPrice(food);
		}

		return foodList;
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

		for (FoodWithStockAndEvent food : foodList) {
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

		return "food/insertFood";
	}

	@RequestMapping(value = "/admin/getUpperListToInsertFood.do")
	@ResponseBody
	public List<FoodUpper> getUpperListToInsertFood(String foodDivisionNo) {

		List<FoodUpper> foodUpeprList = foodService.getUpperListToInsertFood(foodDivisionNo);
		return foodUpeprList;

	}

	@RequestMapping(value = "/admin/getSectionListToInsertFood.do")
	@ResponseBody
	public List<FoodSection> getSectionListToInsertFood(String foodUpperNo) {

		List<FoodSection> foodSectionList = foodService.getSectionListToInsertFood(foodUpperNo);
		return foodSectionList;

	}

	@RequestMapping(value = "/admin/foodInsert.do")
	public String foodInsert(Food food, @RequestParam("foodImgFile") MultipartFile foodImgFile,
			HttpServletRequest request, Model model) {
		try {

			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/images/food");

			String realFile = foodImgFile.getOriginalFilename();
			String renamed = FileRenameUtils.getRenamedFileName(realFile);
			food.setFoodOriginalFileName(realFile);
			food.setFoodRenamedFileName(renamed);

			foodImgFile.transferTo(new File(saveDirectory, "/" + renamed));
		} catch (Exception e) {

		}

		int result = foodService.insertFood(food);

		model.addAttribute("msg", result > 0 ? "등록 성공!" : "등록실패!");
		model.addAttribute("loc", "/");
		return "common/msg";
	}

}
