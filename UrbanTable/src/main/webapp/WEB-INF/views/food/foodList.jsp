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
	<div>
		<span style="padding: 0 10px;">${firstCat }</span>
	</div>	
	<div>
		<ul id="foodList_Cat">
			<li><a href="">전체보기</a></li>
			<c:forEach items="${secCatList }" var="secCat">
				<li>
	 			<c:if test="${not empty secCat.foodSectionUpper and empty secCat.foodSectionName  }">
				<a href="${pageContext.request.contextPath }/food/selectFoodByUpper.do?foodDivisionNo=${secCat.foodDivisionNo }&foodSectionUpper=${secCat.foodSectionUpper}">${secCat.foodSectionUpper }</a> <!-- divisionNo, sectionUpper -->
				</c:if>
	 			<c:if test="${not empty secCat.foodSectionUpper}">
				<a href="<%-- ${pageContext.request.contextPath }/food/selectFoodBySect.do?foodDivisionNo=${secCat.foodDivisionNo}&foodSectionUpper=${secCat.foodSectionUpper} --%>">${secCat.foodSectionName }</a>
				</c:if>
				</li>
			</c:forEach>
		</ul>
	</div>
<section id="sec1" class="main_sec">
	<article class="inner">
	    <h3 class="sub_tit">서브페이지 제목</h3>
       <ul class="main_prd_list clearfix">
        <c:forEach items="${foodList }" var="f">
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
                    </div>
                </a>
            </li>
        </c:forEach>
        </ul>
    </article>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>