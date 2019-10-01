<%@page import="com.kh.urbantable.food.model.vo.FoodUpper"%>
<%@page import="com.kh.urbantable.marketOwner.model.vo.Market"%>
<%@page import="com.kh.urbantable.food.model.service.FoodServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/foodList.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/main.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/foodList.js"></script>
	<div>
		<span style="padding: 0 10px;">${searchKeyword }</span>
	</div>
<div>
	<ul id="foodList_Cat">
		<li><a href="">전체보기</a></li>
		<c:if test="${not empty subUpperList }">
			<c:forEach items="${subUpperList }" var="foodUpper">
				<c:if test="${foodUpper.foodUpperName ne '그 외' }">
				<li><a
					href="${pageContext.request.contextPath }/food/selectFoodByCat.do?searchNo=${foodUpper.foodUpperNo }&searchKeyword=${foodUpper.foodUpperName}">${foodUpper.foodUpperName }</a>
				</li>
				</c:if>
			</c:forEach>
			<c:forEach items="${subUpperList }" var="foodUpper">
				<c:if test="${foodUpper.foodUpperName eq '그 외' }">
				<li><a
					href="${pageContext.request.contextPath }/food/selectFoodByCat.do?searchNo=${foodUpper.foodUpperNo }&searchKeyword=${foodUpper.foodUpperName}">${foodUpper.foodUpperName }</a>
				</li>
				</c:if>
			</c:forEach>
		</c:if>
		<c:if test="${not empty subSectList }">
			<c:forEach items="${subSectList }" var="foodSect">
				<li><a
					href="${pageContext.request.contextPath }/food/selectFoodByCat.do?searchNo=${foodSect.foodSectionNo }&searchKeyword=${foodSect.foodSectionName}">${foodSect.foodSectionName }</a>
				</li>
			</c:forEach>
		</c:if>
 		<c:if test="${not empty brotherSectList }">
			<c:forEach items="${brotherSectList }" var="foodSect">
				<li><a
					href="${pageContext.request.contextPath }/food/selectFoodByCat.do?searchNo=${foodSect.foodSectionNo }&searchKeyword=${foodSect.foodSectionName}">${foodSect.foodSectionName }</a>
				</li>
			</c:forEach>
		</c:if> 
	</ul>
</div>
<section id="sec1" class="main_sec">
	<article class="inner">
	    <h3 class="sub_tit">서브페이지 제목</h3>
	    <select name="marketList" id="marketList" onchange="changeMarket()">
	    	<%
	    		for(Market m :FoodServiceImpl.marketList){
	    			%>
	    				<option value="<%=m.getMarketNo()%>" <%="강남대치점".equals(m.getMarketName())? "selected":" " %>><%=m.getMarketName() %></option>
	    			<%
	    		}
	    	%>
	    </select>
       <ul class="main_prd_list clearfix">
        <c:forEach items="${foodList }" var="f">
        	<c:if test="${f.stockAmount gt 0 }">
            <li>
                <a href="" class="dp_block">
                    <div class="prd_img_area">
                        <p class="fw600 txt_center"><span>SALE</span><br>20%</p>
                        <img src="${f.foodImg }" alt="상품 사진">
                    </div>
                    <div class="prd_info_area">
                        <h4>${f.foodName }</h4>
                        <p class="prd_price fw600">할인가</p>
                        <p class="prd_price2">${f.foodMarketPrice }</p>
                        <p class="prd_price2">${f.marketName }</p>
                    </div>
                </a>
            </li>
        	</c:if>
           
        </c:forEach>
        <c:forEach items="${foodList }" var="f">
        	<c:if test="${f.stockAmount eq 0 }">
            <li>
                <a href="" class="dp_block">
                    <div class="prd_img_area">
                        <img src="${f.foodImg }" alt="상품 사진">
                    </div>
                    <div class="prd_info_area">
                        <h4>${f.foodName }</h4>
                        <p class="prd_price2">상품준비중</p>
                    </div>
                </a>
            </li>
        	</c:if>
           
        </c:forEach>
        </ul>
    </article>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>