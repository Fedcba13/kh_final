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
	    <h3 class="sub_tit">서브페이지 제목</h3>
	    <select name="marketList" id="marketList" onchange="changeMarket()">
			<c:forEach items="${marketList}" var="m">
				<option value="${m.marketNo }" ${m.marketNo eq marketNo? 'selected':' ' }>${m.marketName }</option>
			</c:forEach>
	    </select>
       <ul class="main_prd_list clearfix">
        <c:forEach items="${foodList }" var="f">
        	<c:if test="${f.stockAmount gt 0 }">
<%--             <li onclick="goFoodView('${f.foodNo}');"> --%>
					<li><a
						href="${pageContext.request.contextPath}/food/goFoodView.do?foodNo=${f.foodNo }&marketNo=${f.marketNo}"
						class="dp_block">
							<div class="prd_img_area">
								<c:if test="${f.eventPercent ne 0 }">
									<p class="fw600 txt_center"><span>SALE</span><br>${f.eventPercent}%</p> 
								</c:if>
								<c:if test="${not empty f.foodImg }">
									<img src="${f.foodImg }" alt="상품 사진">
								</c:if>
								<c:if test="${not empty f.foodRenamedFileName }">
									<img
										src="${pageContext.request.contextPath}/resources/images/food/${f.foodRenamedFileName}"
										alt="상품 사진">
								</c:if>
							</div>
							<div class="prd_info_area">
								<h4>${f.foodName }</h4>
								<c:if test="${f.eventPercent ne 0 }">
									<p class="prd_price fw600">할인가</p>
									<p class="prd_price">${f.afterEventPrice } 원</p>
								</c:if>
								<p class="prd_price">${f.foodMemberPrice } 원</p>
							</div>
					</a></li>
				</c:if>
           
        </c:forEach>
        <c:forEach items="${foodList }" var="f">
        	<c:if test="${f.stockAmount eq 0 }">
            <li>
                <a href="${pageContext.request.contextPath}/food/goFoodView.do?foodNo=${f.foodNo }&marketNo=${f.marketNo}" class="dp_block">
                    <div class="prd_img_area">
            	<c:if test="${not empty f.foodImg }">
                        <img src="${f.foodImg }" alt="상품 사진">
            	</c:if>
            	<c:if test="${not empty f.foodRenamedFileName }">
                        <img src="${pageContext.request.contextPath}/resources/images/food/${f.foodRenamedFileName}" alt="상품 사진">
            	</c:if>
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
<script>
function changeMarket() {
	var marketNo = $("#marketList option:selected").val();
	location.href = "${pageContext.request.contextPath}/food/selectNewFoodList.do?"
		+"marketNo="+marketNo;
 }

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>