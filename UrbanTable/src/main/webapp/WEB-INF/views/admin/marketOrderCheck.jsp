<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/marketOwner.css">

<script>
 
function order(idx){
	
	var marketNo = $('#marketNo'+idx).val();
	var amount = $('#amount'+idx).val();
	var foodNo = $('#foodNo'+idx).val();
	var orderNo = $('#orderNo'+idx).val();

	location.href = "${pageContext.request.contextPath}/check/updateOrder.do?marketNo="
		+ marketNo
		+ "&orderNo="
		+ orderNo;
return true;
	
	}

</script>
<section>
	<article class="subPage inner asda">
	   
	    <div class="list_wrap">
	    		<table class="tbl txt_center"></table>
		        <div class="pageBar"></div>
	    	</div>
	    	<div id="orderList">
	    	
	    		<h3 class="sub_tit">발주 요청 예정 품목</h3>
	    		<table class="tbl txt_center">
	    			<tr class="sec_bg">
	    				<th>발주매장</th>
	    				<th style="width:450px;">품목</th>
	    				<th>수량</th>
	    				<th>발주일시</th>
	    				<th style="width:70px;"></th>
	    			</tr>
	    		<c:forEach items="${list }" var="list" varStatus="vs">
				<tr>
	    				<td>${list.MARKETNAME }</td>
	    				<td class="txt_left">${list.FOODNAME }</td>
	    				<td>${list.MARKET_ORDER_DETAIL_AMOUNT }</td>
	    				<td>${list.ORDER_DATE }</td>
	    				<input type="hidden" name="marketNo" value="${list.MARKET_NO }" id="marketNo${vs.index }"/>
	    				<input type="hidden" name="orderNo" value="${list.MARKET_ORDER_NO }" id="orderNo${vs.index }"/>
	    				<td><input type="button" value="O" class="btn" onclick="order(${vs.index})" style="width:50px;"/></td>
	    		</tr>
	    		</c:forEach>

	    		</table>
	    		<div class="pageBar"></div>
	    		<div id="orderTotal"></div>
	    	</div>
	    </div>
	    <div class="popupWrap"></div>
    </article>

</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>