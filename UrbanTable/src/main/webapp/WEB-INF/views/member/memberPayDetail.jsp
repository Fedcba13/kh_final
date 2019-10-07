<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />


<style>

	table.pay_detail_tbl{
		border-bottom: 2px solid #374818;
	}

	table.pay_detail_tbl tr td:nth-child(3n-2){
		width: 120px;
	}
	
	table.pay_detail_tbl tr td:nth-child(3n-1){
		width: 500px;
		padding: 0 30px;
	}
	
	table.pay_detail_tbl tr td:nth-child(3n){
		width: 80px;
	}
	
	table.pay_market_tbl{
		margin-top: 30px;
	}
	
</style>

<script>
$(()=>{
	
});	

</script>

<section>
	<article class="subPage inner myPage">
		<div class="payDetailPage">
		    <jsp:include page="/WEB-INF/views/member/memberNav.jsp" />
		    <div class="payDetail">
		    	<h3 class="sub_tit" style="background-color: white;">구매 상세</h3>
		    	<table class="tbl txt_center pay_detail_tbl" style="width: 700px">
		            <tr>
		                <th>상품 사진</th>
		                <th>상품 정보</th>
		                <th>수량</th>
		            </tr>
		            <c:forEach items="${list }" var="food">
			            <tr>
			                <td><img src='${food.FOOD_IMG }' width="100px" height="130px"></td>
			                <td>${food.FOOD_NAME }</td>
			                <td>${food.PAY_DETAIL_AMOUNT}</td>
			            </tr>
		            </c:forEach>
		        </table>
		        
		        <table class="tbl tbl_view pay_market_tbl">
		            <tr>
		                <th>총 결제 금액</th>
		                <td>${list[0].PAY_PRICE }원</td>
		            </tr>
		            <tr>
		                <th>결제일</th>
		                <td><fmt:formatDate value="${list[0].PAY_DATE}" pattern="yyyy-MM-dd"/></td>
		            </tr>
		            <tr>
		                <th>결제매장</th>
		                <td>${list[0].MARKET_NAME }</td>
		            </tr>
		        </table>
	        </div>
        </div>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>