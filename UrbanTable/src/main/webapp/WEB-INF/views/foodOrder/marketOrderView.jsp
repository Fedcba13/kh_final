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
	html += "<th>상품 코드</th>";
	html += "<th>상품명</th>";
	html += "<th>수량</th>";
	html += "<th>가격</th>";
	html += "</tr></thead>";
	
	var mo = data.marketOrderDetailList;
	html += "<tbody>";
	if(mo.length>0){
		for(var i in mo){
			var flag = "";
			if(mo[i].MARKET_ORDER_FLAG == 0){
				flag = "발주 요청";
			} else {
				flag = "입고 완료";
			}
			html += "<tr>";
			html += "<td>"+mo[i].FOOD_NO+"</td>";
			html += "<td>"+mo[i].FOOD_NAME+"</td>";
			html += "<td>"+mo[i].MARKET_ORDER_DETAIL_AMOUNT+"</td>";
			html += "<td>"+comma(mo[i].MARKET_ORDER_DETAIL_AMOUNT*mo[i].FOOD_MARKET_PRICE)+"원</td>";
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
</script>
<section id="marketOrderView">
	<article class="subPage inner">
	    <h3 class="sub_tit">${marketOrderNo } 발주 내역</h3>
	    <table class="tbl txt_center"></table>
	    <div class="pageBar"></div>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>