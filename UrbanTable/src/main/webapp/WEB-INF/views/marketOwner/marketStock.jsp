<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/marketOwner.css">
<script>
$(()=>{
	
	var cPage = '${cPage}';
	var param = {
		memberId: "${memberId}",
		cPage: cPage
	}
	console.log(param);
		
	$.ajax({
		url: "${pageContext.request.contextPath}/market/marketStockPage.do",
		type: "get",
		data: param,
		dataType:"json",
		success: function(data){
			console.log(data);
		},
		error: function(xhr, txtStatus, err){
			console.log("ajax 처리 실패", xhr, txtStatus, err);
		}
	});
	
	$(".list_wrap > div").hide();
	$(".list_wrap > div:first").show();
	$(".marketStockTab li").click(function(){
		var ac_tab = $(this).attr("rel");
		$(".marketStockTab li").removeClass("ac_tab");
		$(this).addClass("ac_tab");
		$(".list_wrap > div").hide();
		$(".list_wrap > div#"+ac_tab).fadeIn("fast");
	});
	
	$(".pageBar a").click(function(e){
		e.preventDefault();
		var param = {
			memberId: "${memberId}",
			cPage: $(e.target).text()
		}
		
		console.log(param);
		
		$.ajax({
			url: "${pageContext.request.contextPath}/market/marketStockPage.do",
			type: "get",
			data: param,
			dataType:"json",
			success: function(data){
				console.log(data);
			},
			error: function(xhr, txtStatus, err){
				console.log("ajax 처리 실패", xhr, txtStatus, err);
			}
		});
	});
	
	$(".orderBtn").click(function(){
		var clickedRow = $(this).parent().parent();
		var param = {
			foodNo: clickedRow.children("td[rel=foodNo]").text(),
			foodName: clickedRow.children("td[rel=foodName]").text(),
			foodMarketPrice: clickedRow.children("td[rel=foodMarketPrice]").text(),
			marketOrderDetailAmount: clickedRow.children("td[rel=marketOrderAmount]").children("input[name=marketOrderDetailAmount]").val()
		}
		
		console.log(param);
	});
});
</script>
<section>
	<article class="subPage inner asda">
	    <ul class="marketStockTab txt_center">
	    	<li rel="stockList" class="ac_tab">재고 관리</li>
	    	<li rel="orderList">발주 요청</li>
	    </ul>
	    <div class="list_wrap">
	    	<div id="stockList">
	    		<h3 class="sub_tit">상품 재고 관리</h3>
	    		<table class="tbl txt_center">
		            <tr class="sec_bg">
		                <th width="110">상품코드</th>
		                <th width="504">상품명</th>
		                <th width="80">재고 수량</th>
		                <th width="100">발주 가격</th>
		                <th width="90">발주 수량</th>
		                <th width="60">발주</th>
		            </tr>
		           <%--  <c:forEach items="${foodStockList }" var="fs">
		            <tr>
		            	<td rel="foodNo">${fs.FOOD_NO }</td>
		            	<td rel="foodName">${fs.FOOD_NAME }</td>
		            	<td rel="foodStockAmount">${fs.STOCK_AMOUNT }</td>
		            	<td rel="foodMarketPrice">${fs.FOOD_MARKET_PRICE }</td>
		            	<td rel="marketOrderAmount"><input type="number" name="marketOrderDetailAmount" id="marketOrderDetailAmount" style="width:70px;" /></td>
		            	<td><input type="button" value="+" class="btn orderBtn" style="width:40px;" /></td>
		            </tr>
		            </c:forEach> --%>
		        </table>
		       <%-- <div class="pageBar">${pageBar }</div> --%>
	    	</div>
	    	<div id="orderList">
	    		<h3 class="sub_tit">발주 요청</h3>
	    		<table class="tbl txt_center">
	    			<tr class="sec_bg">
		                <th>상품코드</th>
		                <th>상품명</th>
		                <th>발주 가격</th>
		                <th>발주 수량</th>
		            </tr>
	    		</table>
	    	</div>
	    </div>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>