<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/marketOwner.css">
<script>
var orderTotal=0;
var cPage = '${cPage}';
var foodDivision = '${foodDivision}';
var foodOrderSearchType = '${foodOrderSearchType}';
var foodOrderSearchKeyword = '${foodOrderSearchKeyword}';
$(()=>{
	
	var param = {
		memberId: "${memberLoggedIn.memberId}",
		cPage: cPage,
		foodDivision: foodDivision,
		foodOrderSearchType: foodOrderSearchType,
		foodOrderSearchKeyword: foodOrderSearchKeyword
	}
		
	$.ajax({
		url: "${pageContext.request.contextPath}/market/marketStockPage.do",
		type: "get",
		data: param,
		dataType:"json",
		success: function(data){
			printData(data);
		},
		error: function(xhr, txtStatus, err){
			console.log("ajax 처리 실패", xhr, txtStatus, err);
		}
	});
	
	$.ajax({
		url: "${pageContext.request.contextPath}/market/marketNewStockPage.do",
		type: "get",
		data: param,
		dataType:"json",
		success: function(data){
			printNewData(data);
		},
		error: function(xhr, txtStatus, err){
			console.log("ajax 처리 실패", xhr, txtStatus, err);
		}
	});
	
	loadMarketCartList();
	
	$(".list_wrap > div").hide();
	$(".list_wrap > div:first").show();
	$(".marketStockTab li").click(function(){
		var ac_tab = $(this).attr("rel");
		$(".marketStockTab li").removeClass("ac_tab");
		$(this).addClass("ac_tab");
		$(".list_wrap > div").hide();
		$(".list_wrap > div#"+ac_tab).fadeIn("fast");
	});
	
	$(document).on('click', "#stockList .pageBar a", function(e){
		e.preventDefault();
		var param = {
			memberId: "${memberLoggedIn.memberId}",
			cPage: $(e.target).attr("rel"),
			foodDivision: $("#stockList #foodDivision option:selected").val(),
			foodOrderSearchType: $("#stockList #foodOrderSearchType option:selected").val(),
			foodOrderSearchKeyword: $("#stockList #foodOrderSearchKeyword").val()
		}
		
		console.log(param);
			
		$.ajax({
			url: "${pageContext.request.contextPath}/market/marketStockPage.do",
			type: "get",
			data: param,
			dataType:"json",
			success: function(data){
				printData(data);
			},
			error: function(xhr, txtStatus, err){
				console.log("ajax 처리 실패", xhr, txtStatus, err);
			}
		});
	});
	
	$(document).on('click', "#newStockList .pageBar a", function(e){
		e.preventDefault();
		var param = {
			memberId: "${memberLoggedIn.memberId}",
			cPage: $(e.target).attr("rel"),
			foodDivision: $("#newStockList #newFoodDivision option:selected").val(),
			foodOrderSearchType: $("#newStockList #newFoodOrderSearchType option:selected").val(),
			foodOrderSearchKeyword: $("#newStockList #newFoodOrderSearchKeyword").val()
		}
		
		console.log(param);
			
		$.ajax({
			url: "${pageContext.request.contextPath}/market/marketNewStockPage.do",
			type: "get",
			data: param,
			dataType:"json",
			success: function(data){
				printNewData(data);
			},
			error: function(xhr, txtStatus, err){
				console.log("ajax 처리 실패", xhr, txtStatus, err);
			}
		});
	});
	
	$("#stockList .searchFrm input[type=button]").click(function(){
		var param = {
			memberId: "${memberLoggedIn.memberId}",
			cPage: cPage,
			foodDivision: $("#stockList #foodDivision option:selected").val(),
			foodOrderSearchType: $("#stockList #foodOrderSearchType option:selected").val(),
			foodOrderSearchKeyword: $("#stockList #foodOrderSearchKeyword").val()
		}
		
		console.log(param);
		
		$.ajax({
			url: "${pageContext.request.contextPath}/market/marketStockPage.do",
			type: "get",
			data: param,
			dataType:"json",
			success: function(data){
				printData(data);
			},
			error: function(xhr, txtStatus, err){
				console.log("ajax 처리 실패", xhr, txtStatus, err);
			}
		});
	});
	
	$("#newStockList .searchFrm input[type=button]").click(function(){
		var param = {
			memberId: "${memberLoggedIn.memberId}",
			cPage: cPage,
			foodDivision: $("#newStockList #newFoodDivision option:selected").val(),
			foodOrderSearchType: $("#newStockList #newFoodOrderSearchType option:selected").val(),
			foodOrderSearchKeyword: $("#newStockList #newFoodOrderSearchKeyword").val()
		}
		
		console.log(param);
		
		$.ajax({
			url: "${pageContext.request.contextPath}/market/marketNewStockPage.do",
			type: "get",
			data: param,
			dataType:"json",
			success: function(data){
				printNewData(data);
			},
			error: function(xhr, txtStatus, err){
				console.log("ajax 처리 실패", xhr, txtStatus, err);
			}
		});
	});
	
	$(document).on("click", ".orderBtn", function(){
		var clickedRow = $(this).parent().parent();
		var param = {
			memberId : "${memberLoggedIn.memberId}",
			foodNo: clickedRow.children("td[rel=foodNo]").text(),
			marketOrderDetailAmount: clickedRow.children("td[rel=marketOrderAmount]").children("input[name=marketOrderDetailAmount]").val(),
			status: 0
		}
		
		console.log(param);
		
		$.ajax({
			url: "${pageContext.request.contextPath}/market/marketOrderCart.do",
			type: "post",
			data: param,
			dataType: "json",
			success: function(data){
				var popup = "<div class='marketOrderPopup'>";
				popup += "<p>"+data.msg+"</p>";
				if(data.checkMarketCart==0){
					popup += "<p>발주 수량을 <span class='red'>"+param.marketOrderDetailAmount+"개</span>로 변경하시겠습니까?</p>";
				}
				popup += "<div class='marketOrderBtn txt_center'>";
				if(data.checkMarketCart==0){
					popup += "<input type='button' value='변경' onclick='amountUpdate("+JSON.stringify(param)+")' class='dp_ib btn' />";
					popup += "<input type='button' value='취소' class='cancelBtn dp_ib btn btn_disabled' />";
				} else {
					popup += "<input type='button' value='확인' class='cancelBtn dp_ib btn' />";
				}
				popup += "</div></div>";
				$(".popupWrap").html(popup).show();
				$("input[name=marketOrderDetailAmount]").val('');
			},
			error: function(xhr, txtStatus, err){
				console.log("ajax 처리 실패", xhr, txtStatus, err);
			}
		});
	});
	
	$(document).on("click", ".delBtn", function(){
		var clickedRow = $(this).parent().parent();
		var param = {
			memberId : "${memberLoggedIn.memberId}",
			foodNo: clickedRow.children("td[rel=foodNo]").text()
		}
		
		console.log(param);
		
		$.ajax({
			url: "${pageContext.request.contextPath}/market/delMarketOrderCart.do",
			type: "post",
			data: param,
			dataType: "json",
			success: function(data){
				var popup = "<div class='marketOrderPopup'>";
				popup += "<p>"+data.msg+"</p>";
				popup += "<div class='marketOrderBtn txt_center'>";
				popup += "<input type='button' value='확인' class='cancelBtn dp_ib btn' />";
				popup += "</div></div>";
				$(".popupWrap").html(popup).show();
			},
			error: function(xhr, txtStatus, err){
				console.log("ajax 처리 실패", xhr, txtStatus, err);
			}
		});
	});
	
	$(document).on("click", ".marketOrderPopup .cancelBtn", function(){
		$(".popupWrap").hide();
		$(".popupWrap .marketOrderPopup").remove();
		//location.reload();
		loadMarketCartList();
	});
	
	$(document).on('click', "#orderList .pageBar a", function(e){
		e.preventDefault();
		var cartParam = {
			memberId: "${memberLoggedIn.memberId}",
			cPage: $(e.target).attr("rel")
		}
		
		$.ajax({
			url: "${pageContext.request.contextPath}/market/marketCartPage.do",
			type: "get",
			data: cartParam,
			dataType:"json",
			success: function(data){
				printCartData(data);
			},
			error: function(xhr, txtStatus, err){
				console.log("ajax 처리 실패", xhr, txtStatus, err);
			}
		});
	});
});

function loadMarketCartList(){
	var cartParam = {
		memberId: "${memberLoggedIn.memberId}",
		cPage: cPage
	}
	
	$.ajax({
		url: "${pageContext.request.contextPath}/market/marketCartPage.do",
		type: "get",
		data: cartParam,
		dataType:"json",
		success: function(data){
			printCartData(data);
		},
		error: function(xhr, txtStatus, err){
			console.log("ajax 처리 실패", xhr, txtStatus, err);
		}
	});
}

function printData(data){
	var fs = data.foodStockList;
	var html = "<thead><tr class='sec_bg'>";
	html += "<th width='110'>상품코드</th>";
	html += "<th width='504'>상품명</th>";
	html += "<th width='80'>재고 수량</th>";
	html += "<th width='100'>발주 가격</th>";
	html += "<th width='90'>발주 수량</th>";
	html += "<th width='60'>발주</th>";
	html += "</tr></thead><tbody>";
	if(fs.length>0){
		var stockAmount = 0;
		for(var i in fs){
			if(fs[i].STOCK_AMOUNT!=null){
				stockAmount=fs[i].STOCK_AMOUNT;
			}
			html += "<tr>";
			html += "<td rel='foodNo'>"+fs[i].FOOD_NO+"</td>";
			html += "<td rel='foodName'>"+fs[i].FOOD_NAME+"</td>";
			html += "<td rel='foodStockAmount'>"+stockAmount+"</td>";
			html += "<td rel='foodMarketPrice'>"+comma(fs[i].FOOD_MARKET_PRICE)+"원</td>";
			html += "<td rel='marketOrderAmount'><input type='number' name='marketOrderDetailAmount' style='width:70px;' min='0' onkeypress='onlyNumber();' /></td>";
			html += "<td><input type='button' value='+' class='btn orderBtn' style='width:40px;' /></td>";
			html += "</tr>";
		}
	} else {
		html += "<tr><td colspan='6'>조회된 데이터가 없습니다.</td></tr>";
	}
	html += "</tbody>";
	$("#stockList .tbl").html(html);
	$("#stockList .pageBar").html(data.pageBar);
}

function printNewData(data){
	var fs = data.foodStockList;
	var html = "<tr class='sec_bg'>";
	html += "<th width='110'>상품코드</th>";
	html += "<th width='504'>상품명</th>";
	html += "<th width='80'>재고 수량</th>";
	html += "<th width='100'>발주 가격</th>";
	html += "<th width='90'>발주 수량</th>";
	html += "<th width='60'>발주</th>";
	html += "</tr>";
	if(fs.length>0){
		var stockAmount = 0;
		var stockList = $("#stockList .tbl tbody tr");
		var stockListArr = [];
		for(var j=0; j<stockList.length; j++){
			stockListArr.push(stockList.children("td[rel=foodNo]").text());
		}
		
		for(var i in fs){
			if(fs[i].STOCK_AMOUNT!=null){
				stockAmount=fs[i].STOCK_AMOUNT;
			}
			
			if (stockListArr.indexOf(fs[i].FOOD_NO) == -1) {
				html += "<tr>";
				html += "<td rel='foodNo'>"+fs[i].FOOD_NO+"</td>";
				html += "<td rel='foodName'>"+fs[i].FOOD_NAME+"</td>";
				html += "<td rel='foodStockAmount'>"+stockAmount+"</td>";
				html += "<td rel='foodMarketPrice'>"+comma(fs[i].FOOD_MARKET_PRICE)+"원</td>";
				html += "<td rel='marketOrderAmount'><input type='number' name='marketOrderDetailAmount' style='width:70px;' min='0' onkeypress='onlyNumber();' /></td>";
				html += "<td><input type='button' value='+' class='btn orderBtn' style='width:40px;' /></td>";
				html += "</tr>";
			}
		}
	} else {
		html += "<tr><td colspan='6'>조회된 데이터가 없습니다.</td></tr>";
	}
	
	$("#newStockList .tbl").html(html);
	$("#newStockList .pageBar").html(data.pageBar);
}

function printCartData(data){
	var mc = data.marketCartList;
	var html = "<thead><tr class='sec_bg'>";
	html += "<th width='110'>상품코드</th>";
	html += "<th width='474'>상품명</th>";
	html += "<th width='100'>발주 단품 가격</th>";
	html += "<th width='90'>발주 수량</th>";
	html += "<th width='110'>발주 가격</th>";
	html += "<th width='60'>취소</th>";
	html += "</tr></thead><tbody>";
	if(mc.length>0){
		for(var i in mc){
			html += "<tr>";
			html += "<td rel='foodNo'>"+mc[i].FOOD_NO+"</td>";
			html += "<td>"+mc[i].FOOD_NAME+"</td>";
			html += "<td>"+mc[i].FOOD_MARKET_PRICE+"</td>";
			html += "<td>"+mc[i].CART_AMOUNT+"</td>";
			html += "<td>"+comma(mc[i].FOOD_MARKET_PRICE*mc[i].CART_AMOUNT)+"원</td>";
			html += "<td><input type='button' value='-' class='btn delBtn' style='width:40px;' /></td>";
			html += "</tr>";
		}
		orderTotal = data.cartTotal;
		var reqWrap = "<div class='orderReqWrap txt_center clearfix'>";
		reqWrap += "<p class='orderTotal'>총 <span class='dp_ib red fw600' style='padding:0 5px 0 10px;'>"+comma(orderTotal)+"</span>원</p>";
		reqWrap += "<input type='button' value='발주 요청' class='btn' onclick='orderToAdmin();' />";
		reqWrap += "</div>";
		$("#orderList #orderTotal").html(reqWrap);
	} else {
		html += "<tr><td colspan='6'>조회된 데이터가 없습니다.</td></tr>";
	}
	html += "</tbody>";
	$("#orderList .tbl").html(html);
	$("#orderList .pageBar").html(data.pageBar);
}

function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function onlyNumber() {
	if((event.keyCode<48)||(event.keyCode>57))
        event.returnValue=false;
}

function amountUpdate(param){
	param.status = 1;
	console.log(param);
	$.ajax({
		url: "${pageContext.request.contextPath}/market/marketOrderCart.do",
		type: "post",
		data: param,
		dataType: "json",
		success: function(data){
			var popup = "<div class='marketOrderPopup'>";
			popup += "<p>"+data.msg+"</p>";
			popup += "<div class='marketOrderBtn txt_center'>";
			popup += "<input type='button' value='확인' class='cancelBtn dp_ib btn' />";
			popup += "</div></div>";
			$(".popupWrap").html(popup).show();
			$("input[name=marketOrderDetailAmount]").val('');
		},
		error: function(xhr, txtStatus, err){
			console.log("ajax 처리 실패", xhr, txtStatus, err);
		}
	});
}

function orderToAdmin(){
	var param = {
		memberId: "${memberId}",
		marketNo:"${marketNo}",
		orderTotal: orderTotal
	}; 
	
	$.ajax({
		url: "${pageContext.request.contextPath}/foodOrder/marketFoodOrder.do",
		data: param,
		type: "post",
		dataType: "json",
		success: function(data){
			var popup = "<div class='marketOrderPopup'>";
			popup += "<p>"+data.msg+"</p>";
			popup += "<div class='marketOrderBtn txt_center'>";
			popup += "<input type='button' value='확인' class='dp_ib btn' onclick='goRequestList();' />";
			popup += "</div></div>";
			$(".popupWrap").html(popup).show();
		},
		error: function(xhr, txtStatus, err){
			console.log("ajax 처리 실패", xhr, txtStatus, err);
		}
	});
}

function goRequestList(){
	location.href="${pageContext.request.contextPath}/foodOrder/foodOrderRequest.do?memberId=${memberId}";
}
</script>
<section>
	<article class="subPage inner asda">
	    <ul class="marketStockTab txt_center">
	    	<li rel="stockList" class="ac_tab">재고 관리</li>
	    	<li rel="newStockList">신규 발주</li>
	    	<li rel="orderList">발주 요청</li>
	    </ul>
	    <div class="list_wrap">
	    	<div id="stockList">
	    		<h3 class="sub_tit">상품 재고 관리</h3>
	    		<div class="searchFrm" style="width:450px;">
	    			<select name="foodDivision" id="foodDivision" class="dp_ib" style="width:117px;">
		    			<option value="">전체분류</option>
		    			<c:forEach items="${foodDivisionList }" var="fd">
		    			<option value="${fd.foodDivisionNo }">${fd.foodDivisionName }</option>
		    			</c:forEach>
		    		</select>
	    			<select name="foodOrderSearchType" id="foodOrderSearchType" class="dp_ib" style="width:117px;">
		    			<option value="food_name">상품명</option>
		    			<option value="food_no">상품코드</option>
		    		</select>
		    		<input type="text" name="foodOrderSearchKeyword" id="foodOrderSearchKeyword" class="dp_ib" style="width:209px; padding-right:40px;" />
		    		<input type="button" value="검색" class="dp_ib txt_center" />
		    	</div>
	    		<table class="tbl txt_center"></table>
		        <div class="pageBar"></div>
	    	</div>
	    	<div id="newStockList">
	    		<h3 class="sub_tit">신규 발주</h3>
	    		<div class="searchFrm" style="width:450px;">
	    			<select name="newFoodDivision" id="newFoodDivision" class="dp_ib" style="width:117px;">
		    			<option value="">전체분류</option>
		    			<c:forEach items="${foodDivisionList }" var="fd">
		    			<option value="${fd.foodDivisionNo }">${fd.foodDivisionName }</option>
		    			</c:forEach>
		    		</select>
	    			<select name="newFoodOrderSearchType" id="newFoodOrderSearchType" class="dp_ib" style="width:117px;">
		    			<option value="food_name">상품명</option>
		    			<option value="food_no">상품코드</option>
		    		</select>
		    		<input type="text" name="newFoodOrderSearchKeyword" id="newFoodOrderSearchKeyword" class="dp_ib" style="width:209px; padding-right:40px;" />
		    		<input type="button" value="검색" class="dp_ib txt_center" />
		    	</div>
	    		<table class="tbl txt_center"></table>
	    		<div class="pageBar"></div>
	    	</div>
	    	<div id="orderList">
	    		<h3 class="sub_tit">발주 요청 예정 품목</h3>
	    		<table class="tbl txt_center"></table>
	    		<div class="pageBar"></div>
	    		<div id="orderTotal"></div>
	    	</div>
	    </div>
	    <div class="popupWrap"></div>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>