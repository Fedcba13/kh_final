package com.kh.urbantable.food.controller;

import java.net.URLEncoder;
import java.util.List;
import java.util.Random;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.kh.urbantable.food.model.service.testService;
import com.kh.urbantable.food.model.vo.Food;
import com.kh.urbantable.food.model.vo.FoodSection;
@Controller
@RequestMapping("/test") // common mapping
public class insertToDBTest {

	@Autowired
	testService ts = new testService();

//	@RequestMapping("/insertTest.do")
//	public void insertTest() throws Exception {
//
////		 내가 서치할 프로덕트 전체 리스트 가져오기
//		List<FoodSection> foodSectionList = ts.getfoodSectionList();
//
//		// 키워드만큼 포문 돌려
//		for (int i = 0; i < foodSectionList.size(); i++) {
//
//			String keyword = URLEncoder.encode(foodSectionList.get(i).getFoodSectionName(), "UTF-8");
//
//			String url = 	
//	"http://openapi.11st.co.kr/openapi/OpenApiService.tmall?key=befb6666fcf440a1f4a20451aae9ce00&apiCode=ProductSearch&sortCd=CP&pageSize=5&targetSearchPrd=KR&keyword="
//	+ keyword;
//					
//			
//			DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
//			DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
//			Document doc = dBuilder.parse(url);
//			
//			// root tag
//			doc.getDocumentElement().normalize();
//			System.out.println("Root element: " + doc.getDocumentElement().getNodeName()); // Root element: result
//
//			NodeList nList = doc.getElementsByTagName("Product");
//			System.out.println("파싱할 리스트 수 : " + nList.getLength()); // 파싱할 리스트 수 : 5
//			
//			for (int temp = 0; temp < nList.getLength(); temp++) {
//				Node nNode = nList.item(temp);
//				if (nNode.getNodeType() == Node.ELEMENT_NODE) {
//
//					Element eElement = (Element) nNode;
//					
//					Food insertFood = new Food();
//					insertFood.setFoodName(getTagValue("ProductName", eElement));
//					insertFood.setFoodSectionNo(foodSectionList.get(i).getFoodSectionNo());
//					insertFood.setFoodCompany(getTagValue("SellerNick", eElement));
//					insertFood.setFoodMarketPrice(Integer.parseInt(getTagValue("ProductPrice", eElement)));
//					Double randouble = Math.random()*0.1+0.05;
//					insertFood.setFoodMemberPrice(insertFood.getFoodMarketPrice()+(int)(insertFood.getFoodMarketPrice()*randouble));
//					insertFood.setFoodImg(getTagValue("ProductImage300", eElement));
//					
//					ts.insertFoodToDB(insertFood);
//				} // for end
//			} // if end
//
//		}
//
//	}
//
//	private static String getTagValue(String tag, Element eElement) {
//		NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
//		Node nValue = (Node) nlList.item(0);
//		if (nValue == null)
//			return null;
//		return nValue.getNodeValue();
//	}

}
	