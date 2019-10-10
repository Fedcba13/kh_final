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
<br />
<div id= "foodListDiv">
	<ul id="foodList_Cat">
		<c:if test="${not empty subUpperList }">
			<c:forEach items="${subUpperList }" var="u">
				<li><a href="${pageContext.request.contextPath }/food/selectFoodByCat.do?searchNo=${u.foodUpperNo }&searchKeyword=${u.foodUpperName}">${u.foodUpperName}</a></li>
			</c:forEach>
		</c:if>
		<c:if test="${not empty subSectList }">
			<c:forEach items="${subSectList }" var="s">
				<li><a href="${pageContext.request.contextPath }/food/selectFoodByCat.do?searchNo=${s.foodSectionNo }&searchKeyword=${s.foodSectionName}">${s.foodSectionName }</a></li>
			</c:forEach>
		</c:if>
		<c:if test="${not empty brotherSectList }">
			<c:forEach items="${brotherSectList }" var="b">
				<li><a href="${pageContext.request.contextPath }/food/selectFoodByCat.do?searchNo=${b.foodSectionNo }&searchKeyword=${b.foodSectionName}">${b.foodSectionName }</a></li>
			</c:forEach>
		</c:if>
	</ul>
</div>
<section class="main_sec">
	<article class="inner">
	    <h3 class="sub_tit">${searchKeyword }의 검색결과</h3>
	    <select name="marketList" id="marketList" onchange="changeMarket()">
			<c:forEach items="${marketList}" var="m">
				<option value="${m.marketNo }" ${m.marketNo eq marketNo? 'selected':' ' }>${m.marketName }</option>
			</c:forEach>
	    </select>
       <ul class="main_prd_list clearfix">
        <c:forEach items="${foodList }" var="f">
<%--             <li onclick="goFoodView('${f.foodNo}');"> --%>
					<li><a
						href="${pageContext.request.contextPath}/food/goFoodView.do?foodNo=${f.foodNo }&marketNo=${marketNo}"
						class="dp_block">
							<div class="prd_img_area">
								<c:if test="${f.eventPercent ne 0}">
									< <p class="fw600 txt_center"><span>SALE</span><br>${f.eventPercent}%</p> 
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
								<c:if test="${f.eventPercent ne 0 }">
									<p class="prd_price fw600">할인가</p>
									<p class="prd_price"><fmt:formatNumber value="${ f.foodMemberPrice-f.foodMemberPrice*(f.eventPercent/100) }"
								pattern="#,###" />원 </p>
								</c:if>
								<p class="prd_price"><fmt:formatNumber value="${f.foodMemberPrice }"
								pattern="#,###" />원 </p>
							</div>
					</a></li>
           
        </c:forEach>
        </ul>
        <hr />
         <ul class="main_prd_list clearfix">
        <c:forEach items="${needToOrderList }" var="f">
            <li>
                <a href="${pageContext.request.contextPath}/food/goFoodView.do?foodNo=${f.foodNo }&marketNo=${marketNo}" class="dp_block">
						<div class="prd_img_area">
							<c:if test="${not empty f.foodImg }">
								<img src="${f.foodImg }" alt="상품 사진">
								<div class="inner_box">
									<h2>상품 준비중</h2>
								</div>
							</c:if>
							<c:if test="${not empty f.foodRenamedFileName }">
								<img src="${f.foodImg }" alt="상품 사진">
								<div class="inner_box">
									<h2>상품 준비중</h2>
								</div>
							</c:if>
						</div>
						<div class="prd_info_area">
							<h4>${f.foodName }</h4>
						</div>
				</a>
            </li>
        </c:forEach>
        </ul>
    </article>
</section>
<script>
	function changeMarket() {
		var marketNo = $("#marketList option:selected").val();
		location.href = "${pageContext.request.contextPath}/food/selectFoodByCat.do?searchNo=${searchNo}&searchKeyword=${searchKeyword}"
				+ "&marketNo=" + marketNo;
	}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>