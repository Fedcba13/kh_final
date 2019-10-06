package com.kh.urbantable.marketOwner.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.urbantable.admin.model.vo.MarketMember;
import com.kh.urbantable.event.model.vo.Event;
import com.kh.urbantable.food.model.vo.FoodDivision;
import com.kh.urbantable.marketOwner.model.service.MarketOwnerService;
import com.kh.urbantable.marketOwner.model.vo.Market;
import com.kh.urbantable.member.model.vo.Member;

@Controller
@RequestMapping("/market")
public class MarketOwnerController {

	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	MarketOwnerService marketOwnerService;
	
	@RequestMapping("/founded.do")
	public String founded() {
		logger.info("창업 신청 페이지 요청");
		return "marketOwner/founded";
	}
	
	@RequestMapping(value="/foundedEnd.do", method=RequestMethod.POST)
	public String foundedEnd(Market market, Model model, HttpServletRequest request) {
		logger.info("창업 신청 insert 요청");
		logger.info("market="+market);
		
		int result = marketOwnerService.insertMarketFounded(market);
		
		model.addAttribute("msg", result>0?"창업 신청이 완료되었습니다.":"창업 신청에 실패했습니다. 관리자에게 문의하세요.");
		model.addAttribute("loc", "/");
		
		if(result>0) {
			HttpSession session = request.getSession(true);
			Member member = (Member)session.getAttribute("memberLoggedIn");
			member.setMemberCheck(2);
		}
		
		return "common/msg";
	}
	
	@RequestMapping("/foundedEndView.do")
	public String foundedEndView(@RequestParam(value="memberId") String memberId, Model model) {
		logger.info("창업 신청 내역 페이지 요청");
		
		MarketMember market = marketOwnerService.selectByMemberId(memberId);
		logger.info("marketMember@controller="+market);
		
		model.addAttribute("founded", market);
		
		return "marketOwner/foundedEndView";
	}
	
	@RequestMapping("/updateFounded.do")
	public ModelAndView updateFounded(@RequestParam(value="memberId") String memberId, ModelAndView mav) {
		logger.info("창업 신청 수정 페이지 요청");
		
		//기존 신청 정보 불러오기
		MarketMember market = marketOwnerService.selectByMemberId(memberId);
		logger.info("market@="+market);
		
		if(market!=null) {
			mav.addObject("founded", market);
			mav.setViewName("marketOwner/updateFounded");
		} else if (market==null) {
			mav.addObject("msg", "창업 신청 내역이 없습니다.");
			mav.addObject("loc", "/");
			mav.setViewName("common/msg");
		}
		
		return mav;
	}
	
	@RequestMapping(value="/updateFoundedEnd.do", method=RequestMethod.POST)
	public String updateFoundedEnd(Market market, Model model) {
		logger.info("창업 신청 수정 요청");
		logger.info("market="+market);
		
		int result = marketOwnerService.updateMarketFounded(market);
		
		model.addAttribute("msg", result>0?"창업 신청이 수정되었습니다.":"창업 신청 수정에 실패했습니다. 관리자에게 문의하세요.");
		model.addAttribute("loc", "/");
		
		return "common/msg";
	}
	
	@RequestMapping("/cancelFounded.do")
	public String cancleFounded(@RequestParam String marketNo, @RequestParam String memberId, 
			Model model, HttpServletRequest request) {
		logger.info("창업 신청 취소 요청");
		logger.info("marketNo="+marketNo);
		
		int result = marketOwnerService.cancelFounded(marketNo, memberId);
		
		model.addAttribute("msg", result>0?"창업 신청이 취소되었습니다.":"창업 신청 취소에 실패했습니다. 관리자에게 문의하세요.");
		model.addAttribute("loc", "/");
		
		if(result>0) {
			HttpSession session = request.getSession(true);
			Member member = (Member)session.getAttribute("memberLoggedIn");
			member.setMemberCheck(1);
		}
		
		return "common/msg";
	}
	
	@RequestMapping("/marketOrder.do")
	public String marketOrder(@RequestParam String memberId, Model model,
			@RequestParam(value="cPage", defaultValue="1") int cPage,
			@RequestParam(value="orderSearchType", defaultValue="") String orderSearchType,
			@RequestParam(value="orderSearchKeyword", defaultValue="") String orderSearchKeyword,
			@RequestParam(value="payFlag", defaultValue="9") int payFlag,
			@RequestParam(value="deliverType", defaultValue="") String deliverType,
			@RequestParam(value="payStartDate", defaultValue="") String payStartDate,
			@RequestParam(value="payEndDate", defaultValue="") String payEndDate){
		logger.info("지점 주문내역 페이지 요청");
		String marketNo = marketOwnerService.selectMarketNoByMemberId(memberId);
		model.addAttribute("marketNo", marketNo);
		model.addAttribute("cPage", cPage);
		model.addAttribute("orderSearchType", orderSearchType);
		model.addAttribute("orderSearchKeyword", orderSearchKeyword);
		model.addAttribute("payFlag", payFlag);
		model.addAttribute("deliverType", deliverType);
		model.addAttribute("payStartDate", payStartDate);
		model.addAttribute("payEndDate", payEndDate);
		return "marketOwner/marketOrder";
	}
	
	@ResponseBody
	@RequestMapping(value="/marketOrderList.do", method=RequestMethod.GET)
	public Map<String, Object> marketOrderList(@RequestParam(value="marketNo") String marketNo,
			@RequestParam(value="cPage", defaultValue="1", required=false) int cPage,
			@RequestParam(value="orderSearchType", defaultValue="") String orderSearchType,
			@RequestParam(value="orderSearchKeyword", defaultValue="") String orderSearchKeyword,
			@RequestParam(value="payFlag", defaultValue="9") int payFlag,
			@RequestParam(value="deliverType", defaultValue="") String deliverType,
			@RequestParam(value="payStartDate", defaultValue="") String payStartDate,
			@RequestParam(value="payEndDate", defaultValue="") String payEndDate){
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("marketNo", marketNo);
		param.put("orderSearchType", orderSearchType);
		param.put("orderSearchKeyword", orderSearchKeyword);
		param.put("payFlag", payFlag);
		param.put("deliverType", deliverType);
		param.put("payStartDate", payStartDate);
		param.put("payEndDate", payEndDate);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<Map<String, Object>> marketOrderList = marketOwnerService.selectMarketOrderList(cPage, param);
		int totalContents = marketOwnerService.selectMarketOrderTotalContents(param);
		int totalPage = (int)Math.ceil((double)totalContents/marketOwnerService.NUM_PER_PAGE);
		
		final int pageBarSize = 10;
		String pageBar = "";
		
		int pageStart = ((cPage-1)/pageBarSize)*pageBarSize+1;
		int pageEnd = pageStart+pageBarSize-1;
		
		int pageNo = pageStart;
		
		//이전
		if(pageNo==1) { //첫번째 페이지일 경우
			//pageBar += "<span><</span>";
		} else {
			pageBar += "<a href='#' rel='"+(pageNo-1)+"'><</a>";
		}
		
		//page
		while(pageNo<=pageEnd && pageNo<=totalPage) {
			if(pageNo==cPage) {
				pageBar+="<span class='cPage'>"+pageNo+"</span>";
			} else {
				pageBar+="<a href='#' rel='"+pageNo+"'>"+pageNo+"</a>";
			}
			pageNo++;
		}
		
		//다음
		if(pageNo>totalPage) {
			//pageBar += "<span>></span>";
		} else {
			pageBar += "<a href='#' rel='"+pageNo+"'>></a>";
		}
		
		result.put("marketNo", marketNo);
		result.put("pageBar", pageBar);
		result.put("marketOrderList", marketOrderList);
		
		return result;
	}
	
	@RequestMapping("/marketOrderView.do")
	public String marketOrderView(@RequestParam String payNo, Model model) {
		List<Map<String, Object>> orderDetailFood = marketOwnerService.selectOrderDetailFoodByPayNo(payNo);
		Map<String, Object> orderDetailPay = marketOwnerService.selectOrderDetailPayByPayNo(payNo);
		Map<String, Object> orderDetailMember = marketOwnerService.selectOrderDetailMemberByPayNo(payNo);
		model.addAttribute("orderDetailFood", orderDetailFood);
		model.addAttribute("orderDetailPay", orderDetailPay);
		model.addAttribute("orderDetailMember", orderDetailMember);
		model.addAttribute("payNo", payNo);
		return "marketOwner/marketOrderView";
	}
	
	@ResponseBody
	@RequestMapping(value="/marketOrderDelivery.do", method=RequestMethod.POST)
	public Map<String, String> marketOrderDelivery(@RequestParam String payNo){
		int delivery = marketOwnerService.updatePayFlag(payNo);
		Map<String, String> result = new HashMap<String, String>();
		result.put("msg", delivery>0?"배송이 완료되었습니다.":"배송 완료에 실패했습니다. 관리자에게 문의하세요.");
		return result;
	}
	
	@RequestMapping("/myMarket.do")
	public String myMarket(@RequestParam String memberId, Model model) {
		logger.info("내 지점 관리 페이지 요청");
		
		MarketMember market = marketOwnerService.selectByMemberId(memberId);
		logger.info("market@="+market);
		
		model.addAttribute("market", market);
		
		return "marketOwner/myMarket";
	}
	
	@ResponseBody
	@RequestMapping("/myMarketUpdate.do")
	public Map<String, String> myMarketUpdate(@RequestParam(value="marketNo") String marketNo,
			@RequestParam(value="marketTelephone") String marketTelephone,
			@RequestParam(value="marketHoliday") String marketHoliday,
			@RequestParam(value="marketTime") String marketTime) {
		logger.info("내 지점 정보 수정 요청");
		
		Market market = new Market();
		market.setMarketNo(marketNo);
		market.setMarketTelephone(marketTelephone);
		market.setMarketHoliday(marketHoliday);
		market.setMarketTime(marketTime);
		
		int result = marketOwnerService.myMarketUpdate(market);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("marketTelephone", marketTelephone);
		map.put("result", result>0?"지점 정보를 수정하였습니다.":"지점 정보 수정에 실패했습니다. 관리자에게 문의하세요");
		
		return map;
	}
	
	@ResponseBody
	@RequestMapping("/myMarketOpen.do")
	public Map<String, String> myMarketOpen(@RequestParam(value="marketNo") String marketNo){
		logger.info("지점 오픈 요청");
		
		int result = marketOwnerService.myMarketOpen(marketNo);
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", result>0?"지점을 오픈하였습니다.":"지점 오픈에 실패했습니다. 관리자에게 문의하세요");
		
		return map;
	}
	
	@RequestMapping("/marketList.do")
	public String marketList(Model model) {
		logger.info("매장 리스트 페이지 요청");
		//List<MarketEvent> marketList = marketOwnerService.selectMarketWithEvent();
		//model.addAttribute("marketList", marketList);
		return "marketOwner/marketList";
	}
	
	@ResponseBody
	@RequestMapping("/selectMarketList.do")
	public Map<String, Object> selectMarketList(@RequestParam(value="flag") int flag,
			@RequestParam(value="marketNo") String marketNo,
			@RequestParam(value="marketAddress") String marketAddress){
		
		logger.info("매장 리스트 타입={}, 매장 번호={}",flag, marketNo);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("flag", flag);
		param.put("marketNo", marketNo);
		param.put("marketAddress", marketAddress);
		logger.info("param="+param);
		
		List<Market> marketList = marketOwnerService.selectMarketList(param);
		List<Event> eventList = marketOwnerService.selectEventList(param);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("marketList", marketList);
		result.put("eventList", eventList);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/searchMarket.do") 
	public Map<String, Object> searchMarket(@RequestParam(value="flag") int flag,
			@RequestParam(value="marketAddress") String marketAddress){
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("flag", flag);
		param.put("marketAddress", marketAddress);
		logger.info("param="+param);
		
		Map<String, Object> searchList = marketOwnerService.searchMarketList(param);
		return searchList;
	}
	
//	@RequestMapping("/event.do")
//	public String marketEvent() {
//		return "marketOwner/eventList";
//	}
	
//	@RequestMapping("/marketEventEnroll.do")
//	public String marketEventEnroll(@RequestParam(value="memberId") String memberId, Model model) {
//		String marketNo = marketOwnerService.selectMarketNoByMemberId(memberId);
//		model.addAttribute("eventMarketNo", marketNo);
//		return "marketOwner/marketEventEnroll";
//	}
	
	@ResponseBody
	@RequestMapping("/eventCompanySearch.do")
	public List<String> eventCompanySearch(@RequestParam(value="srchCompany") String srchCompany){
		List<String> foodCompanyList = marketOwnerService.eventCompanySearch(srchCompany);
		return foodCompanyList;
	}
	
	@ResponseBody
	@RequestMapping("/eventSearchCategory.do")
	public List<Map<String, String>> eventSearchCategory(@RequestParam(value="srchCompany") String srchCompany,
			@RequestParam(value="eventCategory") String eventCategory){
		Map<String, String> param = new HashMap<String, String>();
		param.put("srchCompany", srchCompany);
		param.put("eventCategory", eventCategory);
		
		List<Map<String, String>> result = marketOwnerService.eventSearchCategory(param);
		
		return result;
	}
	
//	@PostMapping("/marketEventEnrollEnd.do")
//	public String marketEventEnrollEnd(Event event) {
//		logger.info("event={}",event);
//		return "marketOwner/marketEventEnroll";
//	}
	
	@RequestMapping("/marketStock.do")
	public String marketStock(@RequestParam(value="cPage", defaultValue="1") int cPage,
			@RequestParam(value="foodDivision", defaultValue="") String foodDivision,
			@RequestParam(value="foodOrderSearchType", defaultValue="") String foodOrderSearchType,
			@RequestParam(value="foodOrderSearchKeyword", defaultValue="") String foodOrderSearchKeyword,
			@RequestParam String memberId,
			Model model) {
		List<FoodDivision> foodDivisionList = marketOwnerService.selectFoodDivision();
		String marketNo = marketOwnerService.selectMarketNoByMemberId(memberId);
		
		model.addAttribute("foodDivisionList", foodDivisionList);
		model.addAttribute("cPage", cPage);
		model.addAttribute("foodDivision", foodDivision);
		model.addAttribute("foodOrderSearchType", foodOrderSearchType);
		model.addAttribute("foodOrderSearchKeyword", foodOrderSearchKeyword);
		model.addAttribute("marketNo", marketNo);
		model.addAttribute("memberId", memberId);
		return "marketOwner/marketStock";
	}
	
	@ResponseBody
	@RequestMapping("/marketStockPage.do")
	public Map<String, Object> marketStockPage(@RequestParam(value="cPage", defaultValue="1", required=false) int cPage,
			@RequestParam String memberId,
			@RequestParam String foodDivision,
			@RequestParam String foodOrderSearchType, 
			@RequestParam String foodOrderSearchKeyword, HttpServletRequest request){
		
		String marketNo = marketOwnerService.selectMarketNoByMemberId(memberId);
		
		Map<String, String> param = new HashMap<String, String>();
		param.put("marketNo", marketNo);
		param.put("foodDivision", foodDivision);
		param.put("foodOrderSearchType", foodOrderSearchType);
		param.put("foodOrderSearchKeyword", foodOrderSearchKeyword);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<Map<String, String>> foodStockList = marketOwnerService.selectFoodStockList(cPage, param);
		int totalContents = marketOwnerService.selectTotalContents(param);
		int totalPage = (int)Math.ceil((double)totalContents/marketOwnerService.NUM_PER_PAGE);
		
		final int pageBarSize = 10;
		String pageBar = "";
		
		int pageStart = ((cPage-1)/pageBarSize)*pageBarSize+1;
		int pageEnd = pageStart+pageBarSize-1;
		
		int pageNo = pageStart;
		
		//이전
		if(pageNo==1) { //첫번째 페이지일 경우
			//pageBar += "<span><</span>";
		} else {
			pageBar += "<a href='#' rel='"+(pageNo-1)+"'><</a>";
		}
		
		//page
		while(pageNo<=pageEnd && pageNo<=totalPage) {
			if(pageNo==cPage) {
				pageBar+="<span class='cPage'>"+pageNo+"</span>";
			} else {
				pageBar+="<a href='#' rel='"+pageNo+"'>"+pageNo+"</a>";
			}
			pageNo++;
		}
		
		//다음
		if(pageNo>totalPage) {
			//pageBar += "<span>></span>";
		} else {
			pageBar += "<a href='#' rel='"+pageNo+"'>></a>";
		}
		
		result.put("marketNo", marketNo);
		result.put("pageBar", pageBar);
		result.put("foodStockList", foodStockList);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/marketOrderCart.do", method=RequestMethod.POST)
	public Map<String, Object> marketOrderCart(@RequestParam String memberId,
				@RequestParam String foodNo, @RequestParam int marketOrderDetailAmount, 
				@RequestParam int status){
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("memberId", memberId);
		param.put("foodNo", foodNo);
		param.put("marketOrderDetailAmount", marketOrderDetailAmount);
		
		String msg = "";
		int checkMarketCart = 0;
		
		logger.info("status={}",status);
		
		if(status == 0) {
			checkMarketCart = marketOwnerService.insertMarketOrderCart(param);
			if(checkMarketCart>0) {
				msg = "발주 요청 항목에 추가하였습니다.";
			} else if(checkMarketCart==0) {
				msg = "이미 추가된 발주 항목입니다.";
			} else {
				msg = "발주 요청 항목에 추가에 실패하였습니다. 관리자에게 문의하세요.";
			}
		} else if(status==1) {
			checkMarketCart = marketOwnerService.updateMarketOrderCart(param);
			if(checkMarketCart>0) {
				msg = "발주 요청 수량을 변경했습니다.";
			} else {
				msg = "발주 요청 항목에 추가에 실패하였습니다. 관리자에게 문의하세요.";
			}
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("msg", msg);
		result.put("checkMarketCart", checkMarketCart);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/marketCartPage.do")
	public Map<String, Object> marketCartPage(@RequestParam(value="cPage", defaultValue="1", required=false) int cPage,
			@RequestParam String memberId, HttpServletRequest request){
		Map<String, String> param = new HashMap<String, String>();
		param.put("memberId", memberId);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<Map<String, String>> marketCartList = marketOwnerService.selectMarketCartList(cPage, param);
		int cartTotal = 0;
		if(!marketCartList.isEmpty()) {
			cartTotal = marketOwnerService.selectCartTotal(memberId);
		}
		int totalContents = marketOwnerService.selectCartTotalContents(param);
		int totalPage = (int)Math.ceil((double)totalContents/marketOwnerService.NUM_PER_PAGE);
		
		final int pageBarSize = 10;
		String pageBar = "";
		
		int pageStart = ((cPage-1)/pageBarSize)*pageBarSize+1;
		int pageEnd = pageStart+pageBarSize-1;
		
		int pageNo = pageStart;
		
		//이전
		if(pageNo==1) { //첫번째 페이지일 경우
			//pageBar += "<span><</span>";
		} else {
			pageBar += "<a href='#' rel='"+(pageNo-1)+"'><</a>";
		}
		
		//page
		while(pageNo<=pageEnd && pageNo<=totalPage) {
			if(pageNo==cPage) {
				pageBar+="<span class='cPage'>"+pageNo+"</span>";
			} else {
				pageBar+="<a href='#' rel='"+pageNo+"'>"+pageNo+"</a>";
			}
			pageNo++;
		}
		
		//다음
		if(pageNo>totalPage) {
			//pageBar += "<span>></span>";
		} else {
			pageBar += "<a href='#' rel='"+pageNo+"'>></a>";
		}
		
		result.put("pageBar", pageBar);
		result.put("marketCartList", marketCartList);
		result.put("cartTotal", cartTotal);
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/delMarketOrderCart.do", method=RequestMethod.POST)
	public Map<String, Object> delMarketOrderCart(@RequestParam String memberId,
			@RequestParam String foodNo){
		Map<String, String> param = new HashMap<String, String>();
		param.put("memberId", memberId);
		param.put("foodNo", foodNo);
		
		int delCart = marketOwnerService.delMarketOrderCart(param);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("msg", delCart>0?"발주 요청 품목에서 삭제했습니다.":"발푸 요청 품목 삭제에 실패했습니다. 관리자에게 문의하세요.");
		return result;
	}
	
	@RequestMapping("/marketChart.do")
	public String marketChart(@RequestParam String memberId, Model model) {
		String marketNo = marketOwnerService.selectMarketNoByMemberId(memberId);
		model.addAttribute("marketNo", marketNo);
		return "marketOwner/marketChart";
	}
	
	@ResponseBody
	@RequestMapping("/selectChartWeek.do")
	public List<Map<String, Object>> selectChartWeek(@RequestParam String marketNo){
		List<Map<String, Object>> chartWeek = marketOwnerService.selectChartWeek(marketNo);
		return chartWeek;
	}
	
	@ResponseBody
	@RequestMapping("/selectChartMonth.do")
	public List<Map<String, Object>> selectChartMonth(@RequestParam String marketNo){
		List<Map<String, Object>> chartMonth = marketOwnerService.selectChartMonth(marketNo);
		return chartMonth;
	}
	
	@ResponseBody
	@RequestMapping("/selectChartCategory.do")
	public Map<String, Object> selectChartCategory(@RequestParam String marketNo){
		List<Map<String, Object>> chartCategory = marketOwnerService.selectChartCategory(marketNo);
		int totalOrder = marketOwnerService.selectTotalPayDetail(marketNo);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("chartCategory",chartCategory);
		result.put("totalOrder",totalOrder);
		return result;
	}
	
	@RequestMapping(value="/excelDown.do")
	public void excelDown(HttpServletResponse response,
			@RequestParam(value="marketNo") String marketNo,
			@RequestParam(value="cPage", defaultValue="1", required=false) int cPage,
			@RequestParam(value="orderSearchType", defaultValue="") String orderSearchType,
			@RequestParam(value="orderSearchKeyword", defaultValue="") String orderSearchKeyword,
			@RequestParam(value="payFlag", defaultValue="9") int payFlag,
			@RequestParam(value="deliverType", defaultValue="") String deliverType,
			@RequestParam(value="payStartDate", defaultValue="") String payStartDate,
			@RequestParam(value="payEndDate", defaultValue="") String payEndDate) throws Exception {
	    
		//게시판 목록조회
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("marketNo", marketNo);
		param.put("orderSearchType", orderSearchType);
		param.put("orderSearchKeyword", orderSearchKeyword);
		param.put("payFlag", payFlag);
		param.put("deliverType", deliverType);
		param.put("payStartDate", payStartDate);
		param.put("payEndDate", payEndDate);
		
	    List<Map<String, Object>> marketOrderList = marketOwnerService.selectMarketOrderList(cPage, param);
	    
	    logger.info("@controller="+marketOrderList);
	    
	    // 워크북 생성
	    Workbook wb = new HSSFWorkbook();
	    Sheet sheet = wb.createSheet("게시판");
	    Row row = null;
	    Cell cell = null;
	    int rowNo = 0;

	    // 테이블 헤더용 스타일
	    CellStyle headStyle = wb.createCellStyle();
	    headStyle.setBorderTop(BorderStyle.THIN);
	    headStyle.setBorderBottom(BorderStyle.THIN);
	    headStyle.setBorderLeft(BorderStyle.THIN);
	    headStyle.setBorderRight(BorderStyle.THIN);
	    headStyle.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
	    headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
	    headStyle.setAlignment(HorizontalAlignment.CENTER);

	    // 데이터용 경계 스타일 테두리만 지정
	    CellStyle bodyStyle = wb.createCellStyle();
	    bodyStyle.setBorderTop(BorderStyle.THIN);
	    bodyStyle.setBorderBottom(BorderStyle.THIN);
	    bodyStyle.setBorderLeft(BorderStyle.THIN);
	    bodyStyle.setBorderRight(BorderStyle.THIN);

	    // 헤더 생성
	    row = sheet.createRow(rowNo++);
	    cell = row.createCell(0);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("주문번호");
	    cell = row.createCell(1);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("주문자 ID");
	    cell = row.createCell(2);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("주문자명");
	    cell = row.createCell(3);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("연락처");
	    cell = row.createCell(4);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("주문일자");
	    cell = row.createCell(5);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("주문상태");
	    cell = row.createCell(6);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("주문 합계");
	    cell = row.createCell(7);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("결제 수단");
	    cell = row.createCell(8);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("배송 종류");

	    // 데이터 부분 생성
	    for(Map<String, Object> list : marketOrderList) {
	        row = sheet.createRow(rowNo++);
	        cell = row.createCell(0);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(String.valueOf(list.get("PAY_NO")));
	        cell = row.createCell(1);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(String.valueOf(list.get("MEMBER_ID")));
	        cell = row.createCell(2);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(String.valueOf(list.get("MEMBER_NAME")));
	        cell = row.createCell(3);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(String.valueOf(list.get("MEMBER_PHONE")));
	        cell = row.createCell(4);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(String.valueOf(list.get("PAY_DATE")));
	        
	        String flag = "";
			if(Integer.parseInt(String.valueOf(list.get("PAY_FLAG")))==0){
				flag = "주문";
			} else if(Integer.parseInt(String.valueOf(list.get("PAY_FLAG")))==1){
				flag = "결제 완료";
			} if(Integer.parseInt(String.valueOf(list.get("PAY_FLAG")))==2){
				flag = "배송 완료";
			}
	        cell = row.createCell(5);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(flag);
	        cell = row.createCell(6);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(String.valueOf(list.get("PAY_PRICE")));
	        
	        String paymentway = "";
			if(list.get("PAYMENT_WAY")!=null 
					&& String.valueOf(list.get("PAYMENT_WAY")).equals("card")){
				paymentway = "신용카드";
			} else if(list.get("PAYMENT_WAY")==null ){
				paymentway = "";
			} else {
				paymentway = String.valueOf(list.get("PAYMENT_WAY"));
			}

			cell = row.createCell(7);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(paymentway);
	        
	        String delivery = "";
			if(String.valueOf(list.get("DELIVER_TYPE")).equals("d")){
				delivery = "샛별 배송";
			} else if(String.valueOf(list.get("DELIVER_TYPE")).equals("n")){
				delivery = "일반 배송";
			} else if(String.valueOf(list.get("DELIVER_TYPE")).equals("r")){
				delivery = "정기 배송";
			}
	        cell = row.createCell(8);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(delivery);
	    }

	    // 컨텐츠 타입과 파일명 지정
	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename=order_list.xls");
	    response.setHeader("Set-Cookie", "fileDownload=true; path=/");
	   
	    // 엑셀 출력
	    wb.write(response.getOutputStream());
	    wb.close();
	}


}
