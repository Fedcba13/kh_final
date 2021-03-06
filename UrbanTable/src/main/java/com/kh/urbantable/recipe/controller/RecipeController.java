package com.kh.urbantable.recipe.controller;

import java.io.File;
import java.lang.reflect.Array;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Random;

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

import com.kh.urbantable.admin.model.vo.Good;
import com.kh.urbantable.food.model.vo.Food;
import com.kh.urbantable.food.model.vo.FoodSection;
import com.kh.urbantable.recipe.model.service.RecipeService;
import com.kh.urbantable.recipe.model.vo.Blame;
import com.kh.urbantable.recipe.model.vo.BoardComment;
import com.kh.urbantable.recipe.model.vo.Material;
import com.kh.urbantable.recipe.model.vo.MaterialWithSection;
import com.kh.urbantable.recipe.model.vo.Paging;
import com.kh.urbantable.recipe.model.vo.Recipe;
import com.kh.urbantable.recipe.model.vo.RecipeSequence;
import com.kh.urbantable.recipe.model.vo.RecipeVO;

@Controller
@RequestMapping("/recipe")
public class RecipeController {
	
	@Autowired
	RecipeService recipeService;
	
	List<String> set = new ArrayList<String>();
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/recipe")
	public String recipe(HttpServletRequest request) {
		
		int totalCount = recipeService.selectRecipeListCnt();

        Paging paging = new Paging();
        paging.setPageNo(1);
        paging.setPageSize(10);
        paging.setTotalCount(totalCount);
        
        List<Recipe> list = recipeService.selectRecipeList(paging);
        List<String> imageList = new ArrayList<String>();
        for(int i=0; i<list.size(); i++) {
        	String renamedFileName = recipeService.selectLastImage(list.get(i).getRecipeNo());
        	
        	if(renamedFileName != null && renamedFileName != "") {
        		imageList.add(renamedFileName);        		
        	}
        	
        }
		
		request.setAttribute("list", list);
		request.setAttribute("paging", paging);
		request.setAttribute("image", imageList);
//		logger.debug("list=" + list);
		return "/recipe/recipe";
	}
	
	@ResponseBody
	@RequestMapping("/selectRecipeList")
	public List<Recipe> selectRecipeList() {
        
        List<Recipe> list = recipeService.selectRecipeIndexList();
		
		return list;
	}
	
	@ResponseBody
	@RequestMapping("/selectImageList")
	public List<String> selectImageIndexList() {
		
		List<Recipe> list = recipeService.selectRecipeIndexList();
        List<String> imageList = new ArrayList<String>();
        for(int i=0; i<list.size(); i++) {
        	String renamedFileName = recipeService.selectLastImage(list.get(i).getRecipeNo());
        	
        	if(renamedFileName != null && renamedFileName != "") {
        		imageList.add(renamedFileName);        		
        	}
        	
        }
		return imageList;
	}
	
	@RequestMapping("/recipeView.do")
	public String recipeView(@RequestParam String recipeNo, @RequestParam String memberId, Model model) {
		Recipe recipe = recipeService.selectOneRecipe(recipeNo);
		List<MaterialWithSection> materialList = recipeService.selectMaterial(recipeNo);
		List<BoardComment> commentList = recipeService.selectBoardCommentList(recipeNo);
		int goodCount = recipeService.goodCount(recipeNo);
		int badCount = recipeService.badCount(recipeNo);
		
		
		if(!recipe.getMemberId().equals(memberId)) {
			int result = recipeService.readCountUp(recipeNo);
			recipe = recipeService.selectOneRecipe(recipeNo);
		}
		
		model.addAttribute("recipe", recipe);
		model.addAttribute("material", materialList);
		model.addAttribute("comment", commentList);
		model.addAttribute("goodCount", goodCount);
		model.addAttribute("badCount", badCount);
		return "recipe/recipeView";
	}
	
	@RequestMapping("/insert")
	public String recipeInsert() {
		
		return "/recipe/recipeInsert";
	}
	
	@ResponseBody
	@GetMapping("/materialInsert/{section}")
	public List<String> materialInsert(@PathVariable("section") String section, @RequestParam("materialSet") String materialSet, @RequestParam("searchResult") String searchResult) {
		if(materialSet.equals("")) {
			set = new ArrayList<String>();
		}
		
		set.add(section + "-" + searchResult);
		
		logger.info("a" + set.toString());
		
		return set;
	}
	
	@ResponseBody
	@GetMapping("/materialDelete/{index}")
	public List<String> materialDelete(@PathVariable("index") String index, @RequestParam("materialSet") String materialSet) {
		
		logger.info("a" + set.toString());
		logger.info(index);
		
		int removeIndex = set.indexOf(index);
		if(removeIndex != -1) {
			set.remove(removeIndex);
		}
		
		logger.info("a" + set.toString());
		
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
				logger.debug(materialArr[j]);
				String[] ingreArray = materialArr[j].split("-");
				logger.debug(Arrays.toString(ingreArray));
				String foodSectionNo = recipeService.selectFoodSectionNo(ingreArray[0]);
				
				Material material = new Material();
				material.setRecipeNo(recipeNo);
				material.setFoodSectionNo(foodSectionNo);
				if(ingreArray.length == 2) {
					material.setFoodNo(ingreArray[1]);									
					logger.debug(ingreArray[1]);
				}
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
	
	@RequestMapping("/recipeUpdateEnd.do")
	public String recipeUpdateEnd(RecipeVO recipeVo, 
			MultipartFile[] recipePic,
			@RequestParam("materialSet") String materialSet,
			@RequestParam("updateLastOrder") int updateLastOrder, @RequestParam("sequenceLast") int sequenceLast,
			Model model, HttpServletRequest request) {
		logger.debug(materialSet);
		String[] uploadNames = request.getParameterValues("upload_name_origin");
		logger.info(Arrays.toString(uploadNames));
		
		int recipe_result = recipeService.updateRecipe(recipeVo);
		
		String msg = "";
		String recipeNo = recipeVo.getRecipeNo();

		if(recipe_result>0) {
			
		} else {
			msg = "레시피 수정 실패!";
			model.addAttribute("msg", msg);
			model.addAttribute("loc", "/recipe/recipe");
			return "common/msg";
		}
		
		try {
			String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/recipe");
			
			List<RecipeSequence> sequenceList = new ArrayList<RecipeSequence>();
			List<RecipeSequence> updateSequenceList = new ArrayList<RecipeSequence>();
			RecipeSequence deleteSequence = new RecipeSequence();
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
				} else {
					if(!uploadNames[i].equals("")) {
						RecipeSequence rs = new RecipeSequence();
						originalFileName = uploadNames[i];
						rs.setRecipeNo(recipeNo);
						rs.setRecipeOrder(i+1);
						renamedFileName = recipeService.selectRenamedFileName(rs);
					}
				}
				
				RecipeSequence recipeSequence = new RecipeSequence();
				
				recipeSequence.setRecipeNo(recipeNo);
				recipeSequence.setRecipeOrder(recipeVo.getRecipeSequenceList().get(i).getRecipeOrder());
				recipeSequence.setRecipeContent(recipeVo.getRecipeSequenceList().get(i).getRecipeContent());
				recipeSequence.setOriginalRecipePic(originalFileName);
				recipeSequence.setRenamedRecipePic(renamedFileName);
				
				if(recipeVo.getRecipeSequenceList().get(i).getRecipeOrder() <= sequenceLast) {
					updateSequenceList.add(recipeSequence);
				} else {
					sequenceList.add(recipeSequence);
				}
				
				i++;
			}
			
			int sequence_delete_result = 0;
			int sequence_result = 0;
			
			if(updateLastOrder < sequenceLast) {
				int deleteSequenceOrder = recipeVo.getRecipeSequenceList().get(recipeVo.getRecipeSequenceList().size()-1).getRecipeOrder();
				String deleteSequenceRecipeNo = recipeVo.getRecipeSequenceList().get(recipeVo.getRecipeSequenceList().size()-1).getRecipeNo();
				
				deleteSequence.setRecipeOrder(deleteSequenceOrder);
				deleteSequence.setRecipeNo(deleteSequenceRecipeNo);
				sequence_delete_result = recipeService.deleteRecipeSequence(deleteSequence);
				msg = sequence_delete_result>0?"레시피 수정 성공!":"레시피 수정 실패!";
			} else if(updateLastOrder > sequenceLast) {
				sequence_result = recipeService.insertRecipeSequence(sequenceList);
				msg = sequence_result>0?"레시피 수정 성공!":"레시피 수정 실패!";
			}
			
			int sequence_update_result = recipeService.updateRecipeSequence(updateSequenceList);
			
			int ingredient_result = 0;
			
			if(materialSet != null && !materialSet.equals("")) {
				List<Material> materialList = new ArrayList<Material>();
				
				String[] materialArr = materialSet.split(",");
				
				
				logger.info(Arrays.toString(materialArr));
				
				for(int j = 0; j<materialArr.length; j++) {
					String[] ingreArray = materialArr[j].split("-");
					String foodSectionNo = recipeService.selectFoodSectionNo(ingreArray[0]);
					
					Material material = new Material();
					material.setRecipeNo(recipeNo);
					material.setFoodSectionNo(foodSectionNo);
					if(ingreArray.length == 2) {
						material.setFoodNo(ingreArray[1]);		
					}
					materialList.add(material);
				}
				
				ingredient_result = recipeService.insertRecipeIngredient(materialList);
				msg = ingredient_result>0?"레시피 수정 성공!":"레시피 수정 실패!";
			}
			
			msg = "레시피 수정 성공!";
			
			model.addAttribute("msg", msg);
			model.addAttribute("loc", "/recipe/recipe");
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "common/msg";
	}
	
	@ResponseBody
	@GetMapping("/materialSelectBox")
	public List<FoodSection> materialSelectBox(@RequestParam("fr") String fr) {
		String foodDivisionNo = recipeService.selectFoodDivisionNo(fr);
		
		List<FoodSection> sectionList = recipeService.selectFoodSectionList(foodDivisionNo);

		return sectionList;
	}
	
	@RequestMapping("/commentInsert")
	public String boardCommentInsert(BoardComment comment, Model model) {
		if(comment.getBoardCommentRef() != null && comment.getBoardCommentRef() != "") {
			logger.debug(comment.getBoardCommentRef());
			
			BoardComment refComment = recipeService.selectOneBoardComment(comment.getBoardCommentRef());			
			if(refComment.getBoardCommentEnabled() != 1) {
				String msg = "삭제된 댓글입니다!";
				
				model.addAttribute("msg", msg);
				model.addAttribute("loc", "/recipe/recipeView.do?recipeNo=" + comment.getRecipeNo() + "&memberId=");
				
				return "common/msg";
			}
		}
		
		
		try {
			int result = recipeService.boardCommentInsert(comment);
			String msg = result>0?"댓글 등록 성공":"댓글 등록 실패";
			
			model.addAttribute("msg", msg);
			model.addAttribute("loc", "/recipe/recipeView.do?recipeNo=" + comment.getRecipeNo() + "&memberId=");
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "common/msg";
	}
	
	@RequestMapping("/commentUpdate")
	public String boardCommentUpdate(BoardComment comment, Model model) {
		
		try {
			int result = recipeService.boardCommentUpdate(comment);
			String msg = result>0?"댓글 수정 성공":"댓글 수정 실패";
			
			model.addAttribute("msg", msg);
			model.addAttribute("loc", "/recipe/recipeView.do?recipeNo=" + comment.getRecipeNo() + "&memberId=");
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "common/msg";
	}
	
	@RequestMapping("/commentDelete")
	public String boardCommentDelete(@RequestParam String boardCommentNo, @RequestParam String recipeNo, Model model) {
		
		try {
			int result = recipeService.boardCommentDelete(boardCommentNo);
			String msg = result>0?"댓글 삭제 성공":"댓글 삭제 실패";
			
			model.addAttribute("msg", msg);
			model.addAttribute("loc", "/recipe/recipeView.do?recipeNo=" + recipeNo + "&memberId=");
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "common/msg";
	}
	
	@RequestMapping("/blameComment")
	public String boardCommentBlame(Blame blame,
										@RequestParam String recipeNo,
										Model model,
										@RequestParam String targetType,
										@RequestParam(defaultValue="") String foodNo,
										@RequestParam(defaultValue="") String marketNo) {
		
		try {
			int result = recipeService.boardCommentBlame(blame);
			String msg = result>0?"신고 성공":"신고 실패";
			
			model.addAttribute("msg", msg);
			model.addAttribute("loc", "/recipe/recipeView.do?recipeNo=" + recipeNo + "&memberId=");
			if(targetType.equals("2")) {
				model.addAttribute("loc", "/food/goFoodView.do?foodNo="+foodNo+"&marketNo="+marketNo);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "common/msg";
	}
	
	@RequestMapping("/searchFrm")
	public String SearchFrm() {
		
		return "recipe/foodSearch";
	}
	
	@ResponseBody
	@GetMapping("/foodSearchList")
	public List<Food> foodSearchList(@RequestParam("searchName") String searchName) {
		
		List<Food> list = recipeService.foodSearchList(searchName);
		
		return list;
	}
	
	@RequestMapping("/recipeDelete")
	public String recipeDelete(@RequestParam("recipeNo") String recipeNo, Model model) {
		
		try {
			int result = recipeService.recipeDelete(recipeNo);
			String msg = result>0?"게시글 삭제 성공":"게시글 삭제 실패";
			
			model.addAttribute("msg", msg);
			model.addAttribute("loc", "/recipe/recipe");
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "common/msg";
	}
	
	@RequestMapping("/recipeUpdate")
	public String recipeUpdate(@RequestParam("recipeNo") String recipeNo, Model model) {
		
		RecipeVO recipeVo = recipeService.selectOneRecipe(recipeNo);
		List<MaterialWithSection> list = recipeService.selectMaterial(recipeNo);
		
		model.addAttribute("recipe", recipeVo);
		model.addAttribute("material", list);
		
		return "recipe/recipeUpdate";
	}
	
	@RequestMapping("/recipeUpdateEnd")
	public String recipeUpdateEnd(@RequestParam("recipeNo") String recipeNo, Model model) {
		
		try {
			int result = recipeService.recipeDelete(recipeNo);
			String msg = result>0?"게시글 수정 성공":"게시글 수정 실패";
			
			model.addAttribute("msg", msg);
			model.addAttribute("loc", "/recipe/recipe");
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "common/msg";
	}
	
	@ResponseBody
	@RequestMapping("/materialOldDelete/{materialName}")
	public int materialOldDelete(@PathVariable("materialName") String materialName) {
		
		int result = 0;
		String materialNo = recipeService.selectMaterialNo(materialName);
		
		try {
			//result = recipeService.materialOldDelete(materialNo);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@RequestMapping("/recipeBlame")
	public String recipeBlame(@RequestParam("recipeNo") String recipeNo, 
			HttpServletRequest request, 
			@RequestParam(value="type", defaultValue="") String type,
			@RequestParam(value="foodNo", defaultValue="") String foodNo,
			@RequestParam(value="marketNo", defaultValue="") String marketNo) {
		
		request.setAttribute("recipeNo", recipeNo);
		request.setAttribute("foodNo", foodNo);
		request.setAttribute("marketNo", marketNo);
		request.setAttribute("type", type);
		return "recipe/blame";
	}
	
	@ResponseBody
	@RequestMapping("/selectGood")
	public int selectGood(@RequestParam("memberId") String memberId, @RequestParam("recipeNo") String recipeNo) {
		
		Recipe r = new Recipe();
		r.setRecipeNo(recipeNo);
		r.setMemberId(memberId);
		String good_string = recipeService.selectGood(r);
		
		int good = 0;
		
		if(good_string != null) {
			good = Integer.parseInt(good_string);
		}
		
		return good;
	}
	
	@ResponseBody
	@RequestMapping("/selectBad")
	public int selectBad(@RequestParam("memberId") String memberId, @RequestParam("recipeNo") String recipeNo) {
		
		Recipe r = new Recipe();
		r.setRecipeNo(recipeNo);
		r.setMemberId(memberId);
		String bad_string = recipeService.selectBad(r);
		
		int bad = 0;
		
		if(bad_string != null) {
			bad = Integer.parseInt(bad_string);
		}
		
		return bad;
	}
	
	@ResponseBody
	@RequestMapping("/insertGoodorBad")
	public int insertGoodorBad(Good good,@RequestParam("type") String type, @RequestParam("check") int check) {
		
		Good g = recipeService.selectOneGood(good);
		
		int result = 0;
		
		if(g != null) {
			if(type.equals("good")) {
				good.setGood(check);
				result = recipeService.updateGood(good);
			} else {
				good.setBad(check);
				result = recipeService.updateBad(good);
			}
		} else {
			if(type.equals("good")) {
				result = recipeService.insertGood(good);
			} else {
				result = recipeService.insertBad(good);
			}
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/countGoodorBad")
	public int countGoodorBad(@RequestParam("type") String type, @RequestParam("targetId") String targetId) {
		
		int result = 0;
		
		if(type.equals("good")) {
			result = recipeService.goodCount(targetId);
		} else {
			result = recipeService.badCount(targetId);
		}
		
		return result;
	}
	
	@RequestMapping("/recipeSearch")
	public String recipeSearch(@RequestParam("searchName") String searchName, HttpServletRequest request) {

		int totalCount = recipeService.selectRecipeListCnt();

        Paging paging = new Paging();
        paging.setPageNo(1);
        paging.setPageSize(10);
        paging.setTotalCount(totalCount);
        
        List<Recipe> list = recipeService.selectRecipeSearchList(searchName);
        List<String> imageList = new ArrayList<String>();
        for(int i=0; i<list.size(); i++) {
        	String renamedFileName = recipeService.selectLastImage(list.get(i).getRecipeNo());
        	
        	if(renamedFileName != null && renamedFileName != "") {
        		imageList.add(renamedFileName);        		
        	}
        	
        }
		
		request.setAttribute("list", list);
		request.setAttribute("paging", paging);
		request.setAttribute("image", imageList);
//		logger.debug("list=" + list);
		
		return "recipe/search";
	}

}
