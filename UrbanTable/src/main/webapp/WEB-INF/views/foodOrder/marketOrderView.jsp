<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/marketOwner.css">
<script>
var marketOrderNo = "${marketOrderNo }";
var cPage = "${cPage}";
var marketOrderFlag = "${marketOrderFlag}";
var priceTotal = "${priceTotal}";
$(()=>{
	var param = {
		marketOrderNo: marketOrderNo,
		cPage : cPage
	}
	$.ajax({
		url: "${pageContext.request.contextPath}/foodOrder/marketOrderViewDetail.do",
		data: param,
		dataType: "json",
		type: "get",
		success: function(data){
			printData(data);
			moneyTotals();
		},
		error: function(xhr, txtStatus, err){
			console.log("ajax 처리 실패", xhr, txtStatus, err);
		}
	});
	
	$(document).on('click', ".pageBar a", function(e){
		e.preventDefault();
		var param = {
			marketOrderNo: marketOrderNo,
			cPage: $(e.target).attr("rel")
		}
			
		$.ajax({
			url: "${pageContext.request.contextPath}/foodOrder/marketOrderViewDetail.do",
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
});

function printData(data){
	var html = "<thead><tr class='sec_bg'>";
	html += "<th width='110'>상품 코드</th>";
	html += "<th width='504'>상품명</th>";
	html += "<th width='80'>수량</th>";
	html += "<th width='100'>가격</th>";
	if(marketOrderFlag==0){
		html += "<th width='60'>수정</th>";
		html += "<th width='60'>취소</th>";
	}
	html += "</tr></thead>";
	
	var mo = data.marketOrderDetailList;
	console.log(mo);
	html += "<tbody>";
	if(mo.length>0){
		for(var i in mo){
			html += "<tr id='"+mo[i].MARKET_ORDER_DETAIL_NO+"'>";
			html += "<td>"+mo[i].FOOD_NO+"</td>";
			html += "<td>"+mo[i].FOOD_NAME+"</td>";
			if(marketOrderFlag==0){
				html += "<td>";
				html += "<input type='hidden' name='foodMarketPrice' value='"+mo[i].FOOD_MARKET_PRICE+"' />";
				html += "<input type='number' name='updateMarketOrderDetailAmount' value='"+mo[i].MARKET_ORDER_DETAIL_AMOUNT+"' style='width:70px;' onChange='money(this);' />";
				html += "</td>";
			} else {
				html += "<td>"+mo[i].MARKET_ORDER_DETAIL_AMOUNT+"</td>";
			}
			html += "<td class='prdPrice'>"+comma(mo[i].MARKET_ORDER_DETAIL_AMOUNT*mo[i].FOOD_MARKET_PRICE)+"원</td>";
			if(marketOrderFlag==0){
				html += "<td><input type='button' value='수정' class='btn btn2' style='width:50px;' onclick='updateAmount(this);' /></td>";
				html += "<td><input type='button' value='-' class='btn btn2' style='width:40px;' onclick='cancelPrd(this);' /></td>";
			}
			html += "</tr>";
		}
	} else {
		html += "<tr><td colspan='4'>조회된 결과가 없습니다.</td></tr>";
	}
	html += "</tbody>";
	
	$(".tbl").html(html);
	$(".pageBar").html(data.pageBar);
}

function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function updateAmount(e){
	var clickedRow = $(e).parent().parent();
	var updateMarketOrderDetailNo = clickedRow.attr("id");
	var updateMarketOrderDetailAmount = clickedRow.children().children("input[name=updateMarketOrderDetailAmount]").val();
	
	var param = {
		marketOrderDetailNo: updateMarketOrderDetailNo,
		marketOrderDetailAmount: updateMarketOrderDetailAmount
	}
	
	console.log(param);
	
	$.ajax({
		url: "${pageContext.request.contextPath}/foodOrder/marketOrderUpdateAmount.do",
		type: "post",
		data: param,
		dataType:"json",
		success: function(data){
			var popup = "<div class='marketOrderPopup'>";
			popup += "<p>"+data.msg+"</p>";
			popup += "<div class='marketOrderBtn txt_center'>";
			popup += "<input type='button' value='확인' class='dp_ib btn' onclick='cancelBtn();' />";
			popup += "</div></div>";
			$(".popupWrap").html(popup).show();
		},
		error: function(xhr, txtStatus, err){
			console.log("ajax 처리 실패", xhr, txtStatus, err);
		}
	});
}

function cancelPrd(e){
	var clickedRow = $(e).parent().parent();
	var deleteMarketOrderDetailNo = clickedRow.attr("id");
	
	$.ajax({
		url: "${pageContext.request.contextPath}/foodOrder/marketOrderDeleteFood.do",
		type: "post",
		data: {marketOrderDetailNo: deleteMarketOrderDetailNo},
		dataType:"json",
		success: function(data){
			var popup = "<div class='marketOrderPopup'>";
			popup += "<p>"+data.msg+"</p>";
			popup += "<div class='marketOrderBtn txt_center'>";
			popup += "<input type='button' value='확인' class='dp_ib btn' onclick='cancelBtn();' />";
			popup += "</div></div>";
			$(".popupWrap").html(popup).show();
		},
		error: function(xhr, txtStatus, err){
			console.log("ajax 처리 실패", xhr, txtStatus, err);
		}
	});
}

function cancelAllPrd(marketOrderNo){
	console.log(marketOrderNo);
	
	$.ajax({
		url: "${pageContext.request.contextPath}/foodOrder/marketOrderDeleteAll.do",
		type: "post",
		data: {marketOrderNo: marketOrderNo},
		dataType:"json",
		success: function(data){
			var popup = "<div class='marketOrderPopup'>";
			popup += "<p>"+data.msg+"</p>";
			popup += "<div class='marketOrderBtn txt_center'>";
			popup += "<input type='button' value='확인' class='dp_ib btn' onclick='goListBtn();' />";
			popup += "</div></div>";
			$(".popupWrap").html(popup).show();
		},
		error: function(xhr, txtStatus, err){
			console.log("ajax 처리 실패", xhr, txtStatus, err);
		}
	});
}

function cancelBtn(){
	$(".popupWrap").hide();
	$(".popupWrap .marketOrderPopup").remove();
	location.reload();
}

function goListBtn(){
	location.href="${pageContext.request.contextPath}/foodOrder/foodOrderRequest.do?memberId=${memberLoggedIn.memberId}";
}

function money(e){
	var selectedRow = $(e).parent().next();
	var money = $(e).prev().val();
	var amount = $(e).val();
	var total = money*amount;
	$(selectedRow).html(comma(money*amount)+"원");
}

function moneyTotals(){
	console.log(moneyTotal);
	$(".orderReqWrap .orderTotal span").html(comma(priceTotal));
}
</script>
<section id="marketOrderView">
	<article class="subPage inner">
	    <h3 class="sub_tit">${marketOrderNo } 발주 내역</h3>
    	<table class="tbl txt_center"></table>
	    <div class="pageBar"></div>
	    <div class="orderReqWrap txt_center clearfix">
			<p class="orderTotal">총 <span class="dp_ib red fw600" style="padding:0 5px 0 10px;"></span>원</p>
			<input type="button" value="전체 취소" class="btn" onclick="cancelAllPrd('${marketOrderNo }');" />
		</div>
		<div class="popupWrap"></div>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>