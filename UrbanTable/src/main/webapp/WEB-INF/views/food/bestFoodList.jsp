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
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/food.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/main.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/foodList.js"></script>

<section class="main_sec">
	<article class="inner">
	    <h3 class="sub_tit">${foodDivisionName=='all'? '베스트 전체보기' : foodDivisionName }</h3>
	    <div class="txt_right marketList_wrap">
		    <select name="marketList" id="marketList" onchange="changeMarket()">
				<c:forEach items="${marketList}" var="m">
					<option value="${m.marketNo }" ${m.marketNo eq marketNo? 'selected':' ' }>${m.marketName }</option>
				</c:forEach>
		    </select>
	    </div>
       <ul class="main_prd_list clearfix">
        <c:forEach items="${foodList }" var="f">
					<li><a
						href="${pageContext.request.contextPath}/food/goFoodView.do?foodNo=${f.foodNo }&marketNo=${marketNo}"
						class="dp_block">
							<div class="prd_img_area">
								<c:if test="${f.eventPercent ne 0}">
									 <p class="fw600 txt_center"><span>SALE</span><br>${f.eventPercent}%</p> 
								</c:if>
								<c:if test="${not empty f.foodImg }">
									<img src="${f.foodImg }" alt="상품 사진">
								</c:if>
								<c:if test="${not empty f.foodRenamedFileName }">
									<img
										src="${pageContext.request.contextPath}/resources/upload/food/${f.foodRenamedFileName}"
										alt="상품 사진">
								</c:if>
							</div>
							<div class="prd_info_area">
								<h4>${f.foodName }</h4>
								<c:if test="${f.eventPercent ne 0}">
									<p class="prd_price"><fmt:formatNumber value="${ f.foodMemberPrice-f.foodMemberPrice*(f.eventPercent/100) } "
								pattern="#,###" />원 </p>
								<p class="prd_price2"><fmt:formatNumber value="${f.foodMemberPrice }"
								pattern="#,###" />원 </p>
								</c:if>
								<c:if test="${f.eventPercent eq 0}">
								<p class="prd_price"><fmt:formatNumber value="${f.foodMemberPrice }"
								pattern="#,###" />원 </p>
								</c:if>
							</div>
					</a></li>
        </c:forEach>
        </ul>
    </article>
    	<input type="hidden" id ="foodDivisionNameGo"  name="foodDivisionName" value="${empty foodDivisionName? '%' :foodDivisionName}" />
</section>
<script>
function changeMarket() {
	var marketNo = $("#marketList option:selected").val();
	var foodDivisionName = $("#foodDivisionNameGo").val();
	location.href = "${pageContext.request.contextPath}/food/selectBestFoodList.do?"
		+"marketNo="+marketNo+"&foodDivisionName="+foodDivisionName;
 }

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>